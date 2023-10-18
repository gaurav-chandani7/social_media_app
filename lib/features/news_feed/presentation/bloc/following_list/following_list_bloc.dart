import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app/features/news_feed/domain/domain.dart';

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
    on<UnfollowActionPerformed>((event, emit) async {
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
