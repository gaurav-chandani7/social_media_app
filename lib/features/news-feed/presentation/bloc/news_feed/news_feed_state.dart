part of 'news_feed_bloc.dart';

@immutable
sealed class NewsFeedState {
  final List<NewsFeedItemEntity>? data;
  final String? errorMessage;

  const NewsFeedState({this.data, this.errorMessage});
}

class NewsFeedInitial extends NewsFeedState {}

class NewsFeedLoading extends NewsFeedState {}

class NewsFeedSuccess extends NewsFeedState {
  const NewsFeedSuccess({super.data});
}

class NewsFeedFailure extends NewsFeedState {}
