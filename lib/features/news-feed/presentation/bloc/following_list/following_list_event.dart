part of 'following_list_bloc.dart';

@immutable
sealed class FollowingListEvent {}

class GetFollowingList extends FollowingListEvent {
  final String userId;

  GetFollowingList(this.userId);
}

class ShowUnfollowDialog extends FollowingListEvent {
  final String targetUserId;

  ShowUnfollowDialog(this.targetUserId);
}

class UnfollowTap extends FollowingListEvent {
  final String selfId;
  final String targetUserId;
  UnfollowTap({
    required this.selfId,
    required this.targetUserId,
  });
}
