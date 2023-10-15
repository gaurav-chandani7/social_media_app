import 'package:dartz/dartz.dart';
import 'package:social_media_app/core/error/failure.dart';
import 'package:social_media_app/core/usecase/usecase.dart';
import 'package:social_media_app/features/authentication/domain/repository/repository.dart';

class LogoutUseCase implements UseCase<void, void> {
  final AuthRepository _repo;

  LogoutUseCase(this._repo);

  @override
  Future<Either<Failure, void>> call(void params) => _repo.logout();
}
