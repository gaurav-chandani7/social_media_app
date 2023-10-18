import 'dart:convert';

class CreatePostModel {
  final String postTitle;
  final String? postDescription;
  final String postedBy;
  final List<String> taggedMembers;
  final List<String> urls;
  CreatePostModel({
    required this.postTitle,
    this.postDescription,
    required this.postedBy,
    required this.taggedMembers,
    required this.urls,
  });

  Map<String, dynamic> toMap() {
    return {
      'postTitle': postTitle,
      'postDescription': postDescription,
      'postedBy': postedBy,
      'taggedMembers': taggedMembers,
      'urls': urls,
    };
  }

  factory CreatePostModel.fromMap(Map<String, dynamic> map) {
    return CreatePostModel(
      postTitle: map['postTitle'] ?? '',
      postDescription: map['postDescription'],
      postedBy: map['postedBy'] ?? '',
      taggedMembers: List<String>.from(map['taggedMembers']),
      urls: List<String>.from(map['urls']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CreatePostModel.fromJson(String source) =>
      CreatePostModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CreatePostModel(postTitle: $postTitle, postDescription: $postDescription, postedBy: $postedBy, taggedMembers: $taggedMembers, urls: $urls)';
  }
}
