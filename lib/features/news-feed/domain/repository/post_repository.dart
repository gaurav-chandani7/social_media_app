import 'package:dartz/dartz.dart';
import 'package:social_media_app/core/error/failure.dart';
import 'package:social_media_app/features/news-feed/domain/entities/create_post/create_post_item.dart';
import 'package:social_media_app/features/news-feed/domain/entities/entities.dart';
import 'package:social_media_app/features/news-feed/domain/entities/user_action/user_action_params.dart';

abstract class PostRepository {
  Future<Either<Failure, List<NewsFeedItemEntity>>> getNewsFeedPosts(
      String userId);
  Future<Either<Failure, List<UserEntity>>> getUsersToFollow(String userId);
  Future<Either<Failure, NewsFeedItemEntity>> createPost(
      CreatePostItemParams createPostItemParams);
  Future<Either<Failure, bool>> followUser(UserActionParams userActionParams);
  Future<Either<Failure, bool>> unfollowUser(UserActionParams userActionParams);
}
