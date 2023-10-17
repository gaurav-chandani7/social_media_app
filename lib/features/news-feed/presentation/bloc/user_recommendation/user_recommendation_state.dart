part of 'user_recommendation_bloc.dart';

@immutable
sealed class UserRecommendationState {
  final List<UserEntity>? data;
  final List<String>? followedUsers;

  const UserRecommendationState({this.data, this.followedUsers});
}

final class UserRecommendationInitial extends UserRecommendationState {}

final class UserRecommendationLoading extends UserRecommendationState {}

final class UserRecommendationLoaded extends UserRecommendationState {
  const UserRecommendationLoaded({required super.data, super.followedUsers});
}

final class UserRecommendationFollowButtonLoading
    extends UserRecommendationLoaded {
  final String targetUserId;
  const UserRecommendationFollowButtonLoading(
      {required super.data, super.followedUsers, required this.targetUserId});
}
