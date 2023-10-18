part of 'user_profile_bloc.dart';

@immutable
sealed class UserProfileEvent {}

class GetUserDetails extends UserProfileEvent {
  final String userId;

  GetUserDetails(this.userId);
}

class EditProfileEvent extends UserProfileEvent {
  final EditUserParams editUserParams;
  EditProfileEvent({
    required this.editUserParams,
  });
}

class PickImage extends UserProfileEvent {
  final Function(String?) pickedImageCallback;
  PickImage({
    required this.pickedImageCallback,
  });
}
