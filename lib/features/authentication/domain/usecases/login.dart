import 'package:dartz/dartz.dart';
import 'package:social_media_app/core/error/failure.dart';
import 'package:social_media_app/core/usecase/usecase_abstract.dart';
import 'package:social_media_app/features/authentication/domain/repository/auth_repository.dart';

import '../entities/entities.dart';

class LoginUseCase implements UseCase<UserLoginInfo, LoginParams> {
  final AuthRepository _repo;

  LoginUseCase(this._repo);

  @override
  Future<Either<Failure, UserLoginInfo>> call(LoginParams params) =>
      _repo.login(params);
}

class LoginParams {
  final String? email;
  final String? password;
  const LoginParams({this.email, this.password});
}
