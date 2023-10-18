part of 'follower_list_bloc.dart';

@immutable
sealed class FollowerListEvent {}

class GetFollowerList extends FollowerListEvent {
  final String userId;

  GetFollowerList(this.userId);
}
