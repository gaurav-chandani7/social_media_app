import 'package:dartz/dartz.dart';
import 'package:social_media_app/core/error/failure.dart';
import 'package:social_media_app/features/authentication/data/data_sources/firebase/firebase_data_source.dart';
import 'package:social_media_app/features/authentication/data/data_sources/graphql/graphql_create_user_data_source.dart';

import '../../domain/entities/entities.dart';
import '../../domain/repository/repository.dart';
import '../../domain/usecases/usecases.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final GraphQLCreateUserDataSource graphQLCreateUserDataSource;
  const AuthRepositoryImpl(
      this.authRemoteDataSource, this.graphQLCreateUserDataSource);
  @override
  Future<Either<Failure, UserLoginInfo>> login(LoginParams loginParams) async {
    //Auth service login
    final response = await authRemoteDataSource.login(loginParams);
    String? userDetailsError;

    if (response.isRight()) {
      //Get user details from db
      final userDetailsResponse = await graphQLCreateUserDataSource
          .getUserDetailsAfterLogin(loginParams.email!);

      if (userDetailsResponse.isRight()) {
        Map details = userDetailsResponse.getOrElse(() => {});
        String userId = details["id"];
        String name = "${details['firstName']} ${details['lastName']}";
        return Right(UserLoginInfo(
            name: name, email: loginParams.email!, token: "", userId: userId));
      }
      userDetailsError = "Unable to fetch data";
    }
    return response.fold((failure) {
      if (userDetailsError != null) {
        return Left(ServerFailure(message: userDetailsError));
      } else {
        return Left(failure);
      }
    },
        (loginResponse) => Right(UserLoginInfo(
            name: "", email: loginParams.email ?? "", token: "", userId: "")));
  }

  @override
  Future<Either<Failure, void>> logout() async {
    final response = await authRemoteDataSource.logout();
    return response.fold((failure) => Left(failure), (r) => const Right(null));
  }

  @override
  Future<Either<Failure, UserLoginInfo>> register(
      RegisterParams registerParams) async {
    String? userId;
    //Check whether email available
    final validationResponse = await graphQLCreateUserDataSource
        .checkEmailAvailableToRegister(registerParams.email);

    if (!validationResponse) {
      return const Left(OtherFailure(
          message: "You are already registered. Login to continue"));
    }

    //Adding user to db
    final dbResponse =
        await graphQLCreateUserDataSource.createUser(registerParams);
    if (dbResponse.isRight()) {
      userId = dbResponse.getOrElse(() => "");
    } else {
      return const Left(ServerFailure(message: "Try after sometime"));
    }

    //Adding user to authentication service
    final response = await authRemoteDataSource.register(registerParams);

    //If authentication service fails, Delete entry from db
    // graphQLCreateUserDataSource.deleteUser()

    return response.fold((failure) => Left(failure), (registerResponse) {
      //User will login again from login page
      logout();
      return Right(UserLoginInfo(
          userId: userId ?? "",
          name: "${registerParams.firstName} ${registerParams.lastName}",
          email: registerParams.email,
          token: ""));
    });
  }

  @override
  Future<Either<Failure, UserLoginInfo>> checkLoggedInAndGetDetails() async {
    var userDetails = authRemoteDataSource.loggedInUser;
    if (userDetails == null) {
      return const Left(OtherFailure(message: "Not logged in"));
    }
    var dbResponse = await graphQLCreateUserDataSource
        .getUserDetailsAfterLogin(userDetails.email ?? "");
    return dbResponse.fold(
        (failure) => Left(failure),
        (userMap) => Right(UserLoginInfo(
            name: "${userMap['firstName']} ${userMap['lastName']}",
            email: userDetails.email ?? "",
            userId: userMap['id'])));
  }
}
