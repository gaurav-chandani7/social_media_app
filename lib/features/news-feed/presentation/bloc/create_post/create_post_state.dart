part of 'create_post_bloc.dart';

@immutable
sealed class CreatePostState {
  final List<String>? urls;

  const CreatePostState({this.urls});
}

final class CreatePostInitial extends CreatePostState {}

final class ImagesAttached extends CreatePostState {
  const ImagesAttached({required super.urls});
}

final class PublishLoading extends ImagesAttached {
  const PublishLoading({required super.urls});
}

final class PublishSuccess extends ImagesAttached {
  const PublishSuccess({required super.urls});
}
