import 'package:dartz/dartz.dart';
import 'package:social_media_app/core/error/failure.dart';
import 'package:social_media_app/core/usecase/usecase_abstract.dart';
import 'package:social_media_app/features/authentication/domain/entities/entities.dart';
import 'package:social_media_app/features/authentication/domain/repository/repository.dart';

class RegisterUseCase implements UseCase<UserLoginInfo, RegisterParams> {
  final AuthRepository _repo;
  RegisterUseCase(this._repo);
  @override
  Future<Either<Failure, UserLoginInfo>> call(RegisterParams params) =>
      _repo.register(params);
}

class RegisterParams {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String? username;
  final String? bio;
  RegisterParams(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.password,
      this.bio,
      this.username});
}
