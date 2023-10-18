part of 'follower_list_bloc.dart';

@immutable
sealed class FollowerListState {
  final List<UserEntity>? followerList;
  const FollowerListState({this.followerList});
}

final class FollowerListInitial extends FollowerListState {}

final class FollowerListLoading extends FollowerListState {}

final class FollowerListLoaded extends FollowerListState {
  const FollowerListLoaded({super.followerList});
}
