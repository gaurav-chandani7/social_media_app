import 'package:dartz/dartz.dart';

import 'package:social_media_app/core/error/failure.dart';
import 'package:social_media_app/core/usecase/usecase.dart';
import 'package:social_media_app/features/news-feed/news_feed.dart';

class GetUsersRecommendationUseCase extends UseCase<List<UserEntity>, String> {
  final PostRepository _repo;
  GetUsersRecommendationUseCase(
    this._repo,
  );
  @override
  Future<Either<Failure, List<UserEntity>>> call(String params) =>
      _repo.getUsersToFollow(params);
}
