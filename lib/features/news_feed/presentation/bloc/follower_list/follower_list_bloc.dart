import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app/features/news_feed/domain/entities/entities.dart';
import 'package:social_media_app/features/news_feed/domain/usecases/follower_following_list/get_follower_list.dart';

part 'follower_list_event.dart';
part 'follower_list_state.dart';

class FollowerListBloc extends Bloc<FollowerListEvent, FollowerListState> {
  FollowerListBloc(this._getFollowerListUseCase)
      : super(FollowerListInitial()) {
    on<GetFollowerList>((event, emit) async {
      emit(FollowerListLoading());
      final data = await _getFollowerListUseCase(event.userId);
      data.fold((l) => emit(FollowerListInitial()),
          (r) => emit(FollowerListLoaded(followerList: r)));
    });
  }
  final GetFollowerListUseCase _getFollowerListUseCase;
}
