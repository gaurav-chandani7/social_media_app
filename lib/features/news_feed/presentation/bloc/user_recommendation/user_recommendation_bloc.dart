import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app/features/news_feed/domain/domain.dart';

part 'user_recommendation_event.dart';
part 'user_recommendation_state.dart';

class UserRecommendationBloc
    extends Bloc<UserRecommendationEvent, UserRecommendationState> {
  UserRecommendationBloc(this._getUsersRecommendationUseCase,
      this._followUserUseCase, this._unfollowUserUseCase)
      : super(UserRecommendationInitial()) {
    on<GetUserRList>((event, emit) async {
      emit(UserRecommendationLoading());
      final data = await _getUsersRecommendationUseCase(event.userId);
      data.fold((l) => emit(const UserRecommendationLoaded(data: [])),
          (r) => emit(UserRecommendationLoaded(data: r)));
    });
    on<FollowTap>((event, emit) async {
      emit(UserRecommendationFollowButtonLoading(
          data: state.data,
          followedUsers: state.followedUsers,
          targetUserId: event.targetUserId));
      final res = await _followUserUseCase(UserActionParams(
          selfId: event.selfId, targetUserId: event.targetUserId));
      res.fold(
          (l) => emit(UserRecommendationLoaded(
              data: state.data, followedUsers: state.followedUsers)), (r) {
        if (r) {
          if (state.followedUsers == null) {
            List<String> list = [event.targetUserId];
            emit(UserRecommendationLoaded(
                data: state.data, followedUsers: list));
            return;
          } else {
            state.followedUsers?.add(event.targetUserId);
          }
        }
        emit(UserRecommendationLoaded(
            data: state.data, followedUsers: state.followedUsers));
      });
    });
    on<UnfollowTap>((event, emit) async {
      emit(UserRecommendationFollowButtonLoading(
          data: state.data,
          followedUsers: state.followedUsers,
          targetUserId: event.targetUserId));
      final res = await _unfollowUserUseCase(UserActionParams(
          selfId: event.selfId, targetUserId: event.targetUserId));
      res.fold(
          (l) => emit(UserRecommendationLoaded(
              data: state.data, followedUsers: state.followedUsers)), (r) {
        if (state.followedUsers?.contains(event.targetUserId) ?? false) {
          state.followedUsers?.remove(event.targetUserId);
        }
        emit(UserRecommendationLoaded(
            data: state.data, followedUsers: state.followedUsers));
      });
    });
  }
  final GetUsersRecommendationUseCase _getUsersRecommendationUseCase;
  final FollowUserUseCase _followUserUseCase;
  final UnfollowUserUseCase _unfollowUserUseCase;
}
