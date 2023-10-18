part of 'news_feed_bloc.dart';

@immutable
sealed class NewsFeedEvent {}

class FetchNewsFeed extends NewsFeedEvent {
  final String userId;

  FetchNewsFeed(this.userId);
}

class RefreshNewsFeed extends NewsFeedEvent {
  final String userId;
  final Function refreshCompleted;

  RefreshNewsFeed({required this.userId, required this.refreshCompleted});
}
