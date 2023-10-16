import 'package:dartz/dartz.dart';
import 'package:social_media_app/core/error/failure.dart';
import 'package:social_media_app/features/authentication/domain/usecases/usecases.dart';

import '../entities/entities.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserLoginInfo>> login(LoginParams loginParams);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, UserLoginInfo>> register(
      RegisterParams registerParams);
  Future<Either<Failure, UserLoginInfo>> checkLoggedInAndGetDetails();
}
