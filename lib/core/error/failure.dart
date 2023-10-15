abstract class Failure {
  const Failure();
}

class ServerFailure extends Failure {
  final String? message;
  const ServerFailure({this.message});
}

class NoDataFailure extends Failure {}

class CacheFailure extends Failure {}
