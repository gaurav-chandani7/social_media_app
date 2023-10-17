part of 'user_recommendation_bloc.dart';

@immutable
sealed class UserRecommendationState {
  final List<UserEntity>? data;

  const UserRecommendationState({this.data});
}

final class UserRecommendationInitial extends UserRecommendationState {}

final class UserRecommendationLoading extends UserRecommendationState {}

final class UserRecommendationLoaded extends UserRecommendationState {
  const UserRecommendationLoaded({required super.data});
}
