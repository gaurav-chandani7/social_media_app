import 'package:dartz/dartz.dart';

import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/news_feed/domain/domain.dart';

class CreatePostUseCase
    extends UseCase<NewsFeedItemEntity, CreatePostItemParams> {
  final PostRepository _repo;
  CreatePostUseCase(
    this._repo,
  );
  @override
  Future<Either<Failure, NewsFeedItemEntity>> call(
          CreatePostItemParams params) =>
      _repo.createPost(params);
}
