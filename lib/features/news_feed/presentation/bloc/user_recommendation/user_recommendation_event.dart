part of 'user_recommendation_bloc.dart';

@immutable
sealed class UserRecommendationEvent {}

class GetUserRList extends UserRecommendationEvent {
  final String userId;
  GetUserRList({
    required this.userId,
  });
}

class FollowTap extends UserRecommendationEvent {
  final String selfId;
  final String targetUserId;
  FollowTap({
    required this.selfId,
    required this.targetUserId,
  });
}

class UnfollowTap extends UserRecommendationEvent {
  final String selfId;
  final String targetUserId;
  UnfollowTap({
    required this.selfId,
    required this.targetUserId,
  });
}
