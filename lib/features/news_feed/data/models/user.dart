import 'package:social_media_app/features/news_feed/domain/entities/entities.dart';

class UserModel extends UserEntity {
  const UserModel({
    required String id,
    required String firstName,
    required String lastName,
    String? username,
    String? email,
    String? bio,
    String? displayPicture,
    String? createdAt,
    int? followerCount,
    int? followingCount,
  }) : super(
            id: id,
            firstName: firstName,
            lastName: lastName,
            username: username,
            email: email,
            bio: bio,
            displayPicture: displayPicture,
            createdAt: createdAt,
            followerCount: followerCount,
            followingCount: followingCount);

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
        id: map['id'] ?? '',
        firstName: map['firstName'] ?? '',
        lastName: map['lastName'] ?? '',
        username: map['username'],
        email: map['email'],
        bio: map['bio'],
        displayPicture: map['displayPicture'],
        createdAt: map['createdAt'],
        followerCount: map['followerCount'],
        followingCount: map['followingCount']);
  }

  @override
  String toString() {
    return 'UserModel(id: $id, firstName: $firstName, lastName: $lastName, username: $username, email: $email, bio: $bio, displayPicture: $displayPicture, createdAt: $createdAt, followerCount: $followerCount, followingCount: $followingCount)';
  }
}
