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
