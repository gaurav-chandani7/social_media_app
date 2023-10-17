part of 'news_feed_bloc.dart';

@immutable
sealed class NewsFeedEvent {}

class FetchNewsFeed extends NewsFeedEvent {
  final String userId;

  FetchNewsFeed(this.userId);
}
