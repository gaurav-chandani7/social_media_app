import 'package:social_media_app/features/news_feed/data/models/models.dart';
import 'package:social_media_app/features/news_feed/domain/entities/entities.dart';

class NewsFeedItemModel extends NewsFeedItemEntity {
  String id;
  String postTitle;
  String? postDescription;
  String? postedBy;
  String? createdAt;
  List<String>? taggedMembers;
  List<String> urls;
  UserEntity authorDetails;
  NewsFeedItemModel({
    required this.id,
    required this.postTitle,
    this.postDescription,
    this.postedBy,
    this.createdAt,
    this.taggedMembers,
    required this.urls,
    required this.authorDetails,
  }) : super(
            id: id,
            postTitle: postTitle,
            postDescription: postDescription,
            postedBy: postedBy,
            createdAt: createdAt,
            taggedMembers: taggedMembers,
            authorDetails: authorDetails,
            urls: urls);

  factory NewsFeedItemModel.fromJson(Map<String, dynamic> map) {
    return NewsFeedItemModel(
      id: map['id'] ?? '',
      postTitle: map['postTitle'] ?? '',
      postDescription: map['postDescription'],
      postedBy: map['postedBy'],
      createdAt: map['createdAt'],
      taggedMembers: List<String>.from(map['taggedMembers']),
      urls: List<String>.from(map['urls']),
      authorDetails: UserModel.fromJson(map['authorDetails']),
    );
  }

  @override
  String toString() {
    return 'NewsFeedItemModel(id: $id, postTitle: $postTitle, postDescription: $postDescription, postedBy: $postedBy, createdAt: $createdAt, taggedMembers: $taggedMembers, urls: $urls, authorDetails: $authorDetails)';
  }
}
