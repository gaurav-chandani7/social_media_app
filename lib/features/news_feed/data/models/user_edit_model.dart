import 'dart:convert';

import 'package:social_media_app/features/news_feed/domain/entities/user_action/edit_user_params.dart';

class EditUserModel extends EditUserEntity {
  EditUserModel({
    String? firstName,
    String? lastName,
    String? username,
    String? email,
    String? bio,
    String? displayPicture,
  }) : super(
            firstName: firstName,
            lastName: lastName,
            username: username,
            email: email,
            bio: bio,
            displayPicture: displayPicture);

  factory EditUserModel.fromEntity(EditUserEntity editUserEntity) {
    return EditUserModel(
        firstName: editUserEntity.firstName,
        lastName: editUserEntity.lastName,
        username: editUserEntity.username,
        email: editUserEntity.email,
        bio: editUserEntity.bio,
        displayPicture: editUserEntity.displayPicture);
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'email': email,
      'bio': bio,
      'displayPicture': displayPicture,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'UserEditModel(firstName: $firstName, lastName: $lastName, username: $username, email: $email, bio: $bio, displayPicture: $displayPicture)';
  }
}
