import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app/features/news-feed/domain/entities/entities.dart';
import 'package:social_media_app/features/news-feed/domain/usecases/usecases.dart';

part 'user_recommendation_event.dart';
part 'user_recommendation_state.dart';

class UserRecommendationBloc
    extends Bloc<UserRecommendationEvent, UserRecommendationState> {
  UserRecommendationBloc(this._getUsersRecommendationUseCase)
      : super(UserRecommendationInitial()) {
    on<GetUserRList>((event, emit) async {
      emit(UserRecommendationLoading());
      final data = await _getUsersRecommendationUseCase(event.userId);
      data.fold((l) => emit(const UserRecommendationLoaded(data: [])),
          (r) => emit(UserRecommendationLoaded(data: r)));
    });
  }
  final GetUsersRecommendationUseCase _getUsersRecommendationUseCase;
}
