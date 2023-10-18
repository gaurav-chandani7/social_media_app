import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app/features/news-feed/domain/entities/entities.dart';
import 'package:social_media_app/features/news-feed/domain/entities/user_action/edit_user_params.dart';
import 'package:social_media_app/features/news-feed/domain/usecases/user_profile/edit_user.dart';
import 'package:social_media_app/features/news-feed/domain/usecases/user_profile/get_user_details.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  UserProfileBloc(this._getUserDetailsUseCase, this._editUserUseCase)
      : super(UserProfileInitial()) {
    on<GetUserDetails>((event, emit) async {
      emit(UserProfileLoading());
      final data = await _getUserDetailsUseCase(event.userId);
      data.fold((l) => emit(UserProfileFailure()),
          (r) => emit(UserProfileLoaded(userInfo: r)));
    });
    on<EditProfileEvent>((event, emit) async {
      emit(EditProfileLoading(userInfo: state.userInfo));
      final data = await _editUserUseCase(event.editUserParams);
      data.fold((l) => emit(EditProfileFailure(userInfo: state.userInfo)),
          (r) => emit(EditProfileCompleted(userInfo: state.userInfo)));
    });
    on<PickImage>((event, emit) async {
      try {
        var res = await FilePicker.platform.pickFiles(type: FileType.image);
        if (res != null) {
          log(res.files.length.toString());
          event.pickedImageCallback(res.files.first.path);
        } else {
          event.pickedImageCallback(null);
        }
      } catch (e) {
        log(e.toString());
      }
    });
  }
  final GetUserDetailsUseCase _getUserDetailsUseCase;
  final EditUserUseCase _editUserUseCase;
}
