import 'package:dartz/dartz.dart';
import 'package:social_media_app/core/error/failure.dart';
import 'package:social_media_app/core/usecase/usecase.dart';
import 'package:social_media_app/features/news_feed/domain/domain.dart';

class UnfollowUserUseCase extends UseCase<bool, UserActionParams> {
  final PostRepository _repo;

  UnfollowUserUseCase(this._repo);
  @override
  Future<Either<Failure, bool>> call(UserActionParams params) =>
      _repo.unfollowUser(params);
}
