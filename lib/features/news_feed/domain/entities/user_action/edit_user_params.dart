class EditUserEntity {
  String? firstName;
  String? lastName;
  String? username;
  String? email;
  String? bio;
  String? displayPicture;
  EditUserEntity({
    this.firstName,
    this.lastName,
    this.username,
    this.email,
    this.bio,
    this.displayPicture,
  });

  @override
  String toString() {
    return 'EditUserEntity(firstName: $firstName, lastName: $lastName, username: $username, email: $email, bio: $bio, displayPicture: $displayPicture)';
  }
}

class EditUserParams extends EditUserEntity {
  String userId;
  String? displayPicturePath;
  EditUserParams(
      {required this.userId,
      this.displayPicturePath,
      super.firstName,
      super.lastName,
      super.username,
      super.email,
      super.bio,
      super.displayPicture});

  @override
  String toString() =>
      'EditUserParams(userId: $userId, displayPicturePath: $displayPicturePath, firstName: $firstName, lastName: $lastName, username: $username, email: $email, bio: $bio, displayPicture: $displayPicture)';
}
