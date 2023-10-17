part of 'create_post_bloc.dart';

@immutable
sealed class CreatePostEvent {}

class PublishPost extends CreatePostEvent {
  final CreatePostItemParams createPostItemParams;
  PublishPost({
    required this.createPostItemParams,
  });
}

class PickImages extends CreatePostEvent {}
