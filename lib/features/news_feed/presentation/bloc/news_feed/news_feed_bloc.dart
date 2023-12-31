import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app/features/news_feed/domain/entities/entities.dart';

import 'package:social_media_app/features/news_feed/domain/usecases/usecases.dart';

part 'news_feed_event.dart';
part 'news_feed_state.dart';

class NewsFeedBloc extends Bloc<NewsFeedEvent, NewsFeedState> {
  NewsFeedBloc(
    this._getNewsFeedUseCase,
  ) : super(NewsFeedInitial()) {
    on<FetchNewsFeed>((event, emit) async {
      emit(NewsFeedLoading());
      final data = await _getNewsFeedUseCase(event.userId);
      data.fold((l) => emit(NewsFeedFailure()), (r) {
        log(r.toString());
        emit(NewsFeedSuccess(data: r));
      });
    });
    on<RefreshNewsFeed>((event, emit) async {
      final data = await _getNewsFeedUseCase(event.userId);
      data.fold((l) => null, (r) async {
        event.refreshCompleted();
        emit(NewsFeedSuccess(data: r));
      });
    });
  }
  final GetNewsFeedUseCase _getNewsFeedUseCase;
}
