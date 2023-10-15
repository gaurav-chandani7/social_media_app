import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app/core/error/failure.dart';
import 'package:social_media_app/features/authentication/authentication.dart';


part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._loginUseCase, this._logoutUseCase)
      : super(Loading());

  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;

  Future<void> login(LoginParams loginParams) async {
    emit(Loading());
    final data = await _loginUseCase(loginParams);

    data.fold((l) {
      if (l is ServerFailure) {
        emit(Failure(l.message ?? ""));
      }
    }, (r) => emit(Success(r.token)));
  }

  Future<void> logout() async {
    emit(Loading());
    final data = await _logoutUseCase(null);
    data.fold((l) {
      if (l is ServerFailure) {
        emit(Failure(l.message ?? ""));
      }
      emit(Failure("Something went wrong."));
    }, (r) => emit(Success(null)));
  }
}
