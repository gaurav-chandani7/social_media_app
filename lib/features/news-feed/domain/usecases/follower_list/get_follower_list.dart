import 'package:dartz/dartz.dart';
import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/news-feed/domain/domain.dart';

class GetFollowerListUseCase extends UseCase<List<UserEntity>, String> {
  final PostRepository _repo;

  GetFollowerListUseCase(this._repo);
  @override
  Future<Either<Failure, List<UserEntity>>> call(String params) =>
      _repo.getFollowerList(params);
}
