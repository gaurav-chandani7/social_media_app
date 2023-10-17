import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:social_media_app/core/error/failure.dart';
import 'package:social_media_app/features/news-feed/data/models/create_post.dart';
import 'package:social_media_app/features/news-feed/data/models/models.dart';
import 'package:social_media_app/features/news-feed/data/models/user_action_model.dart';

abstract class GraphQLDataSource {
  Future<Either<Failure, List<NewsFeedItemModel>>> getNewsFeed(String userId);
  Future<Either<Failure, List<UserModel>>> getUsersRecommendation(
      String userId);
  Future<Either<Failure, NewsFeedItemModel>> createPost(
      {required CreatePostModel createPostModel});
  Future<Either<Failure, bool>> followUser(
      {required UserActionModel userActionModel});
  Future<Either<Failure, bool>> unfollowUser(
      {required UserActionModel userActionModel});
}

class GraphQLDataSourceImpl implements GraphQLDataSource {
  final GraphQLClient _graphQLClient;

  GraphQLDataSourceImpl(this._graphQLClient);
  @override
  Future<Either<Failure, List<NewsFeedItemModel>>> getNewsFeed(
      String userId) async {
    String query = """
    query GetNewsFeed(\$userId: ID!) {
      getNewsFeed(userId: \$userId) {
        id
        postTitle
        postDescription
        postedBy
        createdAt
        taggedMembers
        urls
        authorDetails {
          id
          firstName
          lastName
        }
      }
    }
    """;
    try {
      QueryResult queryResult = await _graphQLClient.query(
          QueryOptions(document: gql(query), variables: {"userId": userId}));
      List<NewsFeedItemModel> newsFeedItems =
          (queryResult.data?["getNewsFeed"] as List)
              .map((e) => NewsFeedItemModel.fromJson(e))
              .toList();
      return Right(newsFeedItems);
    } catch (e) {
      log(e.toString());
      return const Left(OtherFailure());
    }
  }

  @override
  Future<Either<Failure, List<UserModel>>> getUsersRecommendation(
      String userId) async {
    String query = """
    query GetUsersRecommendation(\$userId: ID!) {
      getUsersRecommendation(userId: \$userId) {
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
        followingCount
        followerCount
      }
    }
    """;
    try {
      QueryResult queryResult = await _graphQLClient.query(
          QueryOptions(document: gql(query), variables: {"userId": userId}));
      log(queryResult.data.toString());
      List<UserModel> userList =
          (queryResult.data?["getUsersRecommendation"] as List)
              .map((e) => UserModel.fromJson(e))
              .toList();
      return Right(userList);
    } catch (e) {
      log(e.toString());
      return const Left(OtherFailure());
    }
  }

  @override
  Future<Either<Failure, NewsFeedItemModel>> createPost(
      {required CreatePostModel createPostModel}) async {
    String query = """
    mutation CreatePost(\$postInput: PostInput) {
      createPost(postInput: \$postInput) {
        id
        postTitle
        postDescription
        postedBy
        createdAt
        taggedMembers
        urls
        authorDetails {
          id
          firstName
          lastName
        }
      }
    }
    """;
    try {
      QueryResult queryResult = await _graphQLClient
          .query(QueryOptions(document: gql(query), variables: {
        "postInput": {
          "postTitle": createPostModel.postTitle,
          "postedBy": createPostModel.postedBy,
          "taggedMembers": createPostModel.taggedMembers,
          "urls": createPostModel.urls,
          "postDescription": createPostModel.postDescription
        }
      }));
      return Right(NewsFeedItemModel.fromJson(queryResult.data?['createPost']));
    } catch (e) {
      log(e.toString());
      return const Left(OtherFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> followUser(
      {required UserActionModel userActionModel}) async {
    String query = """
    mutation FollowUser(\$selfId: ID!, \$targetUserId: ID!) {
      followUser(selfId: \$selfId, targetUserId: \$targetUserId)
    }
    """;
    try {
      QueryResult queryResult = await _graphQLClient.mutate(MutationOptions(
          document: gql(query), variables: userActionModel.toMap()));
      return Right(queryResult.data?['followUser']);
    } catch (e) {
      log(e.toString());
      return const Left(OtherFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> unfollowUser(
      {required UserActionModel userActionModel}) async {
    String query = """
    mutation UnfollowUser(\$selfId: ID!, \$targetUserId: ID!) {
      unfollowUser(selfId: \$selfId, targetUserId: \$targetUserId)
    }
    """;
    try {
      QueryResult queryResult = await _graphQLClient.mutate(MutationOptions(
          document: gql(query), variables: userActionModel.toMap()));
      return Right(queryResult.data?['unfollowUser']);
    } catch (e) {
      log(e.toString());
      return const Left(OtherFailure());
    }
  }
}
