import 'package:dartz/dartz.dart';
import 'package:social_media_app/core/error/failure.dart';
import 'package:social_media_app/features/authentication/domain/usecases/usecases.dart';

import '../entities/entities.dart';

abstract class AuthRepository {
  Future<Either<Failure, Login>> login(LoginParams loginParams);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, Login>> register(RegisterParams registerParams);
}
