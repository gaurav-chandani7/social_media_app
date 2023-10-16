import 'package:dartz/dartz.dart';
import 'package:social_media_app/core/error/failure.dart';
import 'package:social_media_app/core/usecase/usecase.dart';

class GetNewsFeedUseCase implements UseCase<List, String> {
  @override
  Future<Either<Failure, List>> call(String params) {
    // TODO: implement call
    throw UnimplementedError();
  }
}
