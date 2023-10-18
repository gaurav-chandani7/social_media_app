part of 'following_list_bloc.dart';

@immutable
sealed class FollowingListEvent {}

class GetFollowingList extends FollowingListEvent {
  final String userId;

  GetFollowingList(this.userId);
}
