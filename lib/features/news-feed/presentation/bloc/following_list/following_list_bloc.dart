import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app/features/features.dart';
import 'package:social_media_app/features/news-feed/domain/entities/user_action/user_action_params.dart';
import 'package:social_media_app/features/news-feed/domain/usecases/follower_list/get_following_list.dart';

part 'following_list_event.dart';
part 'following_list_state.dart';

class FollowingListBloc extends Bloc<FollowingListEvent, FollowingListState> {
  FollowingListBloc(this._getFollowingListUseCase, this._unfollowUserUseCase)
      : super(FollowingListInitial()) {
    on<GetFollowingList>((event, emit) async {
      emit(FollowingListLoading());
      final data = await _getFollowingListUseCase(event.userId);
      data.fold((l) => emit(FollowingListInitial()),
          (r) => emit(FollowingListLoaded(followingList: r)));
    });
    on<ShowUnfollowDialog>((event, emit) => emit(BottomUnfollowDialogVisible(
        targetUserId: event.targetUserId, followingList: state.followingList)));
    on<UnfollowTap>((event, emit) async {
      emit(BottomUnfollowDialogDismissed(followingList: state.followingList));
      final data = await _unfollowUserUseCase(UserActionParams(
          selfId: event.selfId, targetUserId: event.targetUserId));
      data.fold((l) => null, (r) {
        if (r) {
          add(GetFollowingList(event.selfId));
        }
      });
    });
  }
  final GetFollowingListUseCase _getFollowingListUseCase;
  final UnfollowUserUseCase _unfollowUserUseCase;
}
