import 'package:dartz/dartz.dart';
import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/news-feed/domain/domain.dart';

class GetNewsFeedUseCase implements UseCase<List<NewsFeedItemEntity>, String> {
  final PostRepository _repo;

  GetNewsFeedUseCase(this._repo);
  @override
  Future<Either<Failure, List<NewsFeedItemEntity>>> call(String params) =>
      _repo.getNewsFeedPosts(params);
}
