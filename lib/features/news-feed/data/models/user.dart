import 'package:social_media_app/features/news-feed/domain/entities/entities.dart';

class UserModel extends UserEntity {
  String id;
  String firstName;
  String lastName;
  String? username;
  String? bio;
  String? displayPicture;
  String? createdAt;
  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.username,
    this.bio,
    this.displayPicture,
    this.createdAt,
  }) : super(
            id: id,
            firstName: firstName,
            lastName: lastName,
            username: username,
            bio: bio,
            displayPicture: displayPicture,
            createdAt: createdAt);

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      username: map['username'],
      bio: map['bio'],
      displayPicture: map['displayPicture'],
      createdAt: map['createdAt'],
    );
  }

  @override
  String toString() {
    return 'UserModel(id: $id, firstName: $firstName, lastName: $lastName, username: $username, bio: $bio, displayPicture: $displayPicture, createdAt: $createdAt)';
  }
}
