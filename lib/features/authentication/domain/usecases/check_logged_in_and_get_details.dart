import 'package:dartz/dartz.dart';
import 'package:social_media_app/core/error/failure.dart';
import 'package:social_media_app/core/usecase/usecase_abstract.dart';
import 'package:social_media_app/features/authentication/domain/entities/entities.dart';
import 'package:social_media_app/features/authentication/domain/repository/repository.dart';

class CheckLoggedInAndGetDetailsUseCase extends UseCase<UserLoginInfo, void> {
  final AuthRepository _repo;

  CheckLoggedInAndGetDetailsUseCase(this._repo);
  @override
  Future<Either<Failure, UserLoginInfo>> call(void params) async =>
      _repo.checkLoggedInAndGetDetails();
}
