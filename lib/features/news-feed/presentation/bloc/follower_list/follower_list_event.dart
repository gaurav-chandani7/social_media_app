part of 'follower_list_bloc.dart';

@immutable
sealed class FollowerListEvent {}

class GetFollowingList extends FollowerListEvent {
  final String userId;

  GetFollowingList(this.userId);
}

class GetFollowerList extends FollowerListEvent {
  final String userId;

  GetFollowerList(this.userId);
}
