import 'package:dartz/dartz.dart';
import 'package:social_media_app/core/error/failure.dart';
import 'package:social_media_app/features/news-feed/domain/entities/create_post/create_post_item.dart';
import 'package:social_media_app/features/news-feed/domain/entities/entities.dart';

abstract class PostRepository {
  Future<Either<Failure, List<NewsFeedItemEntity>>> getNewsFeedPosts(String userId);
  Future<Either<Failure, List<UserEntity>>> getUsersToFollow(String userId);
  Future<Either<Failure, NewsFeedItemEntity>> createPost(CreatePostItemParams createPostItemParams);
}
