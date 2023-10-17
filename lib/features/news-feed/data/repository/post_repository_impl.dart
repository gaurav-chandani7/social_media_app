import 'dart:developer';

import 'package:dartz/dartz.dart';

import 'package:social_media_app/core/error/failure.dart';
import 'package:social_media_app/features/news-feed/data/data_sources/data_sources.dart';
import 'package:social_media_app/features/news-feed/data/data_sources/firebase_storage_data_source.dart';
import 'package:social_media_app/features/news-feed/data/models/create_post.dart';
import 'package:social_media_app/features/news-feed/data/models/models.dart';
import 'package:social_media_app/features/news-feed/domain/entities/create_post/create_post_item.dart';
import 'package:social_media_app/features/news-feed/domain/entities/news_feed_item.dart';
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
}
