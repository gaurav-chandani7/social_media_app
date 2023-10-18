part of 'following_list_bloc.dart';

@immutable
sealed class FollowingListState {
  final List<UserEntity>? followingList;

  const FollowingListState({this.followingList});
}

final class FollowingListInitial extends FollowingListState {}

final class FollowingListLoading extends FollowingListState {}

final class FollowingListLoaded extends FollowingListState {
  const FollowingListLoaded({required super.followingList});
}

final class BottomUnfollowDialogVisible extends FollowingListLoaded {
  final String targetUserId;
  const BottomUnfollowDialogVisible(
      {required this.targetUserId, required super.followingList});
}

final class BottomUnfollowDialogDismissed extends FollowingListLoaded {
  const BottomUnfollowDialogDismissed({required super.followingList});
}
