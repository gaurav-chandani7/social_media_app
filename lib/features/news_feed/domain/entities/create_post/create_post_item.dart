class CreatePostItemParams {
  String postTitle;
  String? postDescription;
  String postedBy;
  List<String> taggedMembers;
  List<String> filePaths;
  CreatePostItemParams({
    required this.postTitle,
    this.postDescription,
    required this.postedBy,
    required this.taggedMembers,
    required this.filePaths
  });

  factory CreatePostItemParams.initial() => CreatePostItemParams(postTitle: '', postDescription: '', postedBy: '', taggedMembers: [], filePaths: []);
}
