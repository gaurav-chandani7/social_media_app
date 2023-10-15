part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class Loading extends AuthState {}

final class Success extends AuthState {
  final String? data;
  Success(this.data);
}

final class Failure extends AuthState {
  final String message;
  Failure(this.message);
}
