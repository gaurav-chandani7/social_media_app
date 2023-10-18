import 'package:dartz/dartz.dart';
import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/news_feed/domain/domain.dart';

class GetFollowingListUseCase extends UseCase<List<UserEntity>, String> {
  final PostRepository _repo;

  GetFollowingListUseCase(this._repo);
  @override
  Future<Either<Failure, List<UserEntity>>> call(String params) =>
      _repo.getFollowingList(params);
}
