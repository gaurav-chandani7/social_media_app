import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/authentication/domain/usecases/usecases.dart';

abstract class GraphQLCreateUserDataSource {
  Future<bool> checkEmailAvailableToRegister(String email);
  Future<Either<Failure, String>> createUser(RegisterParams registerParams);
  Future<bool> deleteUser();
  Future<Either<Failure, Map<String, dynamic>>> getUserDetailsAfterLogin(
      String email);
}

class GraphQLCreateUserDataSourceImpl implements GraphQLCreateUserDataSource {
  final GraphQLClient _graphQLClient;

  GraphQLCreateUserDataSourceImpl(this._graphQLClient);

  @override
  Future<bool> checkEmailAvailableToRegister(String email) async {
    String checkEmailQuery = """
        query Query(\$email: String) {
        checkEmailAvailableForRegister(email: \$email)
      }
    """;
    try {
      QueryResult queryResult = await _graphQLClient.query(QueryOptions(
          document: gql(checkEmailQuery),
          variables: {"email": email},
          fetchPolicy: FetchPolicy.noCache));
      log(queryResult.data.toString());
      return queryResult.data?["checkEmailAvailableForRegister"];
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  @override
  Future<Either<Failure, String>> createUser(
      RegisterParams registerParams) async {
    String createUserMutation = """
      mutation Mutation(\$userInput: UserInput) {
        createUser(userInput: \$userInput) {
          id
          firstName
          lastName
          username
          email
          bio
          displayPicture
          createdAt
          followingList
          followerList
        }
      }
    """;

    try {
      QueryResult queryResult = await _graphQLClient.mutate(
          MutationOptions(document: gql(createUserMutation), variables: {
        "userInput": {
          "firstName": registerParams.firstName,
          "lastName": registerParams.lastName,
          "username": registerParams.username,
          "email": registerParams.email,
          "displayPicture": defaultDisplayPicture,
          "bio": registerParams.bio
        }
      }));
      log(queryResult.data.toString());
      return Right(queryResult.data?['createUser']['id']);
    } catch (e) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<bool> deleteUser() {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getUserDetailsAfterLogin(
      String email) async {
    String getUserDetailsByEmailQuery = """
        query GetUserDetailsByEmail(\$email: String) {
          getUserDetailsByEmail(email: \$email) {
            id
            firstName
            lastName
            username
            email
            bio
            displayPicture
            createdAt
            followingList
            followerList
          }
        }
    """;
    try {
      QueryResult queryResult = await _graphQLClient.query(QueryOptions(
          document: gql(getUserDetailsByEmailQuery),
          variables: {"email": email}));
      log(queryResult.data.toString());
      return Right({
        "id": queryResult.data?["getUserDetailsByEmail"]["id"],
        "firstName": queryResult.data?["getUserDetailsByEmail"]["firstName"],
        "lastName": queryResult.data?["getUserDetailsByEmail"]["lastName"]
      });
    } catch (e) {
      return const Left(ServerFailure());
    }
  }
}
