import 'package:dartz/dartz.dart';

import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/news-feed/domain/domain.dart';
import 'package:social_media_app/features/news-feed/domain/entities/create_post/create_post_item.dart';

class CreatePostUseCase
    extends UseCase<NewsFeedItemEntity, CreatePostItemParams> {
  PostRepository _repo;
  CreatePostUseCase(
    this._repo,
  );
  @override
  Future<Either<Failure, NewsFeedItemEntity>> call(
          CreatePostItemParams params) =>
      _repo.createPost(params);
}
