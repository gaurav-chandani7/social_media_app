import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app/features/features.dart';
import 'package:social_media_app/features/news-feed/domain/usecases/follower_list/get_following_list.dart';

part 'following_list_event.dart';
part 'following_list_state.dart';

class FollowingListBloc extends Bloc<FollowingListEvent, FollowingListState> {
  FollowingListBloc(this._getFollowingListUseCase)
      : super(FollowingListInitial()) {
    on<GetFollowingList>((event, emit) async {
      emit(FollowingListLoading());
      final data = await _getFollowingListUseCase(event.userId);
      data.fold((l) => emit(FollowingListInitial()),
          (r) => emit(FollowingListLoaded(followingList: r)));
    });
  }
  final GetFollowingListUseCase _getFollowingListUseCase;
}