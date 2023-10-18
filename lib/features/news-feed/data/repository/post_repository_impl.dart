import 'dart:developer';

import 'package:dartz/dartz.dart';

import 'package:social_media_app/core/error/failure.dart';
import 'package:social_media_app/features/news-feed/data/data_sources/data_sources.dart';
import 'package:social_media_app/features/news-feed/data/data_sources/firebase_storage_data_source.dart';
import 'package:social_media_app/features/news-feed/data/models/create_post.dart';
import 'package:social_media_app/features/news-feed/data/models/models.dart';
import 'package:social_media_app/features/news-feed/data/models/user_action_model.dart';
import 'package:social_media_app/features/news-feed/data/models/user_edit_model.dart';
import 'package:social_media_app/features/news-feed/domain/entities/create_post/create_post_item.dart';
import 'package:social_media_app/features/news-feed/domain/entities/news_feed_item.dart';
import 'package:social_media_app/features/news-feed/domain/entities/user.dart';
import 'package:social_media_app/features/news-feed/domain/entities/user_action/edit_user_params.dart';
import 'package:social_media_app/features/news-feed/domain/entities/user_action/user_action_params.dart';
import 'package:social_media_app/features/news-feed/domain/repository/repository.dart';

class PostRepositoryImpl implements PostRepository {
  final GraphQLDataSource _graphQLDataSource;
  final FirebaseStorageDataSource _firebaseStorageDataSource;
  PostRepositoryImpl(this._graphQLDataSource, this._firebaseStorageDataSource);

  @override
  Future<Either<Failure, List<NewsFeedItemModel>>> getNewsFeedPosts(
      String userId) {
    return _graphQLDataSource.getNewsFeed(userId);
  }

  @override
  Future<Either<Failure, List<UserModel>>> getUsersToFollow(String userId) {
    return _graphQLDataSource.getUsersRecommendation(userId);
  }

  @override
  Future<Either<Failure, NewsFeedItemEntity>> createPost(
      CreatePostItemParams createPostItemParams) async {
    try {
      List<Future<String>> futures = [];
      for (var element in createPostItemParams.filePaths) {
        futures.add(_firebaseStorageDataSource.uploadFile(
            userId: createPostItemParams.postedBy, filePath: element));
      }
      var urls = await Future.wait(futures);
      log(urls.toString());
      return await _graphQLDataSource.createPost(
          createPostModel: CreatePostModel(
              postTitle: createPostItemParams.postTitle,
              postDescription: createPostItemParams.postDescription,
              postedBy: createPostItemParams.postedBy,
              taggedMembers: createPostItemParams.taggedMembers,
              urls: urls));
    } catch (e) {
      return Left(OtherFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> followUser(
      UserActionParams userActionParams) async {
    return _graphQLDataSource.followUser(
        userActionModel: UserActionModel(
            selfId: userActionParams.selfId,
            targetUserId: userActionParams.targetUserId));
  }

  @override
  Future<Either<Failure, bool>> unfollowUser(
      UserActionParams userActionParams) async {
    return _graphQLDataSource.unfollowUser(
        userActionModel: UserActionModel(
            selfId: userActionParams.selfId,
            targetUserId: userActionParams.targetUserId));
  }

  @override
  Future<Either<Failure, UserModel>> getUserDetails(String userId) {
    return _graphQLDataSource.getUserDetails(userId);
  }

  @override
  Future<Either<Failure, bool>> editUser(
      {required String userId,
      String? displayPicturePath,
      required EditUserEntity editUserEntity}) async {
    var editModel = EditUserModel.fromEntity(editUserEntity);
    if (displayPicturePath != null) {
      var url = await _firebaseStorageDataSource.uploadFile(
          userId: userId, filePath: displayPicturePath);
      editModel.displayPicture = url;
    }
    return _graphQLDataSource.editUser(
        userId: userId, editUserModel: editModel);
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getFollowerList(String userId) {
    return _graphQLDataSource.getFollowerList(userId);
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getFollowingList(String userId) {
    return _graphQLDataSource.getFollowingList(userId);
  }
}
