import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app/core/error/failure.dart';
import 'package:social_media_app/features/authentication/domain/usecases/usecases.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this._registerUseCase) : super(RegisterInitial());

  final RegisterUseCase _registerUseCase;

  Future<void> register(RegisterParams registerParams) async {
    emit(RegisterLoading());
    final data = await _registerUseCase(registerParams);
    data.fold((l) {
      if (l is ServerFailure) {
        emit(RegisterFailure(l.message ?? ""));
      }
      emit(RegisterFailure("Something went wrong"));
    }, (r) => emit(RegisterSuccess(r.token)));
  }
}
