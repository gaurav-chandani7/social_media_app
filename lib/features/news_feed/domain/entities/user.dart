class UserEntity {
  final String id;
  final String firstName;
  final String lastName;
  final String? username;
  final String? email;
  final String? bio;
  final String? displayPicture;
  final String? createdAt;
  final int? followerCount;
  final int? followingCount;

  const UserEntity(
      {required this.id,
      required this.firstName,
      required this.lastName,
      this.username,
      this.email,
      this.bio,
      this.displayPicture,
      this.createdAt,
      this.followerCount,
      this.followingCount});
}
