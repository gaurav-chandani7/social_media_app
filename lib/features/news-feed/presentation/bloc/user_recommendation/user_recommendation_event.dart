part of 'user_recommendation_bloc.dart';

@immutable
sealed class UserRecommendationEvent {}

class GetUserRList extends UserRecommendationEvent {
  final String userId;
  GetUserRList({
    required this.userId,
  });
}
