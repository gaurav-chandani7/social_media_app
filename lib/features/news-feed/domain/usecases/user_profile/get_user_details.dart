import 'package:dartz/dartz.dart';
import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/news-feed/domain/domain.dart';

class GetUserDetailsUseCase extends UseCase<UserEntity, String> {
  final PostRepository _repo;

  GetUserDetailsUseCase(this._repo);
  @override
  Future<Either<Failure, UserEntity>> call(String params) =>
      _repo.getUserDetails(params);
}
