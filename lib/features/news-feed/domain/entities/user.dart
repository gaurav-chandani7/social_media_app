class UserEntity {
  final String id;
  final String firstName;
  final String lastName;
  final String? username;
  final String? bio;
  final String? displayPicture;
  final String? createdAt;

  const UserEntity(
      {required this.id,
      required this.firstName,
      required this.lastName,
      this.username,
      this.bio,
      this.displayPicture,
      this.createdAt});
}
