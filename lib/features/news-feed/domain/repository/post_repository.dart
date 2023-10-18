import 'package:dartz/dartz.dart';
import 'package:social_media_app/core/error/failure.dart';
import 'package:social_media_app/features/news-feed/domain/entities/create_post/create_post_item.dart';
import 'package:social_media_app/features/news-feed/domain/entities/entities.dart';
import 'package:social_media_app/features/news-feed/domain/entities/user_action/edit_user_params.dart';
import 'package:social_media_app/features/news-feed/domain/entities/user_action/user_action_params.dart';

abstract class PostRepository {
  Future<Either<Failure, List<NewsFeedItemEntity>>> getNewsFeedPosts(
      String userId);
  Future<Either<Failure, List<UserEntity>>> getUsersToFollow(String userId);
  Future<Either<Failure, NewsFeedItemEntity>> createPost(
      CreatePostItemParams createPostItemParams);
  Future<Either<Failure, bool>> followUser(UserActionParams userActionParams);
  Future<Either<Failure, bool>> unfollowUser(UserActionParams userActionParams);
  Future<Either<Failure, UserEntity>> getUserDetails(String userId);
  Future<Either<Failure, bool>> editUser(
      {required String userId,
      String? displayPicturePath,
      required EditUserEntity editUserEntity});
  Future<Either<Failure, List<UserEntity>>> getFollowerList(String userId);
  Future<Either<Failure, List<UserEntity>>> getFollowingList(String userId);
}
