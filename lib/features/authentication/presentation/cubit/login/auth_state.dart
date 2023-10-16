part of 'auth_cubit.dart';

@immutable
sealed class AuthState {
  final UserLoginInfo? data;
  const AuthState({this.data});

  bool get isLoggedIn => data != null;
}

final class AuthInitial extends AuthState {}

final class Loading extends AuthState {}

final class Success extends AuthState {
  // final UserLoginInfo? data;
  const Success({super.data});
}

final class Failure extends AuthState {
  final String message;
  const Failure(this.message);
}

final class FetchingSession extends AuthState {}
