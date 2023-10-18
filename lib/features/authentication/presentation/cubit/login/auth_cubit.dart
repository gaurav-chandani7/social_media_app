import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app/core/error/failure.dart';
import 'package:social_media_app/features/authentication/authentication.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._loginUseCase, this._logoutUseCase,
      this._checkLoggedInAndGetDetailsUseCase)
      : super(AuthInitial()) {
    checkLoggedInSession();
  }

  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;
  final CheckLoggedInAndGetDetailsUseCase _checkLoggedInAndGetDetailsUseCase;

  Future<void> login(LoginParams loginParams) async {
    emit(Loading());
    final data = await _loginUseCase(loginParams);

    data.fold((l) {
      if (l is ServerFailure) {
        emit(Failure(l.message ?? ""));
      }
    }, (r) => emit(Success(data: r)));
  }

  Future<void> logout() async {
    emit(Loading());
    final data = await _logoutUseCase(null);
    data.fold((l) {
      if (l is ServerFailure) {
        emit(Failure(l.message ?? ""));
      }
      emit(const Failure("Something went wrong."));
    }, (r) => emit(AuthInitial()));
  }

  Future checkLoggedInSession() async {
    emit(FetchingSession());
    final data = await _checkLoggedInAndGetDetailsUseCase(null);
    data.fold((l) => emit(AuthInitial()), (r) => emit(Success(data: r)));
  }
}
