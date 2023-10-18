part of 'user_profile_bloc.dart';

@immutable
sealed class UserProfileState {
  final UserEntity? userInfo;

  const UserProfileState({this.userInfo});
}

final class UserProfileInitial extends UserProfileState {}

final class UserProfileLoading extends UserProfileState {}

final class UserProfileLoaded extends UserProfileState {
  const UserProfileLoaded({required super.userInfo});
}

final class UserProfileFailure extends UserProfileState {}

final class EditProfileLoading extends UserProfileLoaded {
  const EditProfileLoading({required super.userInfo});
}

final class EditProfileCompleted extends UserProfileLoaded {
  const EditProfileCompleted({required super.userInfo});
}

final class EditProfileFailure extends UserProfileLoaded {
  const EditProfileFailure({required super.userInfo});
}
