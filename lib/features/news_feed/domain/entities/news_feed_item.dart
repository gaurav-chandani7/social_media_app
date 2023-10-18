import 'package:social_media_app/features/news_feed/domain/entities/user.dart';

class NewsFeedItemEntity {
  final String id;
  final String postTitle;
  final String? postDescription;
  final String? postedBy;
  final String? createdAt;
  final List<String>? taggedMembers;
  final List<String> urls;
  final UserEntity authorDetails;

  const NewsFeedItemEntity({
    required this.id,
    required this.postTitle,
    this.postDescription,
    this.postedBy,
    this.createdAt,
    this.taggedMembers,
    required this.urls,
    required this.authorDetails,
  });
}
