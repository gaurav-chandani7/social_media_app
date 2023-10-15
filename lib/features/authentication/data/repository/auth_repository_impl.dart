import 'package:dartz/dartz.dart';
import 'package:social_media_app/core/error/failure.dart';
import 'package:social_media_app/features/authentication/data/data_sources/remote_data_source.dart';

import '../../domain/entities/entities.dart';
import '../../domain/repository/repository.dart';
import '../../domain/usecases/usecases.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  const AuthRepositoryImpl(this.authRemoteDataSource);
  @override
  Future<Either<Failure, Login>> login(LoginParams loginParams) async {
    final response = await authRemoteDataSource.login(loginParams);
    return response.fold(
        (failure) => Left(failure),
        (loginResponse) => Right(Login(
            name: loginResponse.user!.displayName!,
            email: loginResponse.user!.email ?? "",
            token: loginResponse.credential!.token.toString())));
  }

  @override
  Future<Either<Failure, void>> logout() async {
    final response = await authRemoteDataSource.logout();
    return response.fold((failure) => Left(failure), (r) => const Right(null));
  }
  
  @override
  Future<Either<Failure, Login>> register(RegisterParams registerParams) async{
    final response = await authRemoteDataSource.register(registerParams);
    return response.fold(
        (failure) => Left(failure),
        (loginResponse) => Right(Login(
            name: loginResponse.user!.displayName!,
            email: loginResponse.user!.email ?? "",
            token: loginResponse.credential!.token.toString())));
  }
}
