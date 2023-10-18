import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:social_media_app/features/features.dart';
import 'package:social_media_app/features/news-feed/data/data_sources/firebase_storage_data_source.dart';
import 'package:social_media_app/features/news-feed/domain/usecases/follower_list/get_follower_list.dart';
import 'package:social_media_app/features/news-feed/domain/usecases/follower_list/get_following_list.dart';
import 'package:social_media_app/features/news-feed/domain/usecases/user_profile/edit_user.dart';
import 'package:social_media_app/features/news-feed/domain/usecases/user_profile/get_user_details.dart';
import 'package:social_media_app/features/news-feed/presentation/bloc/create_post/create_post_bloc.dart';
import 'package:social_media_app/features/news-feed/presentation/bloc/follower_list/follower_list_bloc.dart';
import 'package:social_media_app/features/news-feed/presentation/bloc/following_list/following_list_bloc.dart';
import 'package:social_media_app/features/news-feed/presentation/bloc/user_profile/user_profile_bloc.dart';
import 'package:social_media_app/features/news-feed/presentation/bloc/user_recommendation/user_recommendation_bloc.dart';
import 'core/core.dart';

GetIt sl = GetIt.instance;

Future<void> serviceLocator() async {
  sl.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  sl.registerLazySingleton<GraphQLClient>(() => GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(),
      defaultPolicies: defaultGraphQlPolicy));
  sl.registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance);
  _dataSources();
  _repositories();
  _useCase();
  _cubit();
}

void _dataSources() {
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<GraphQLCreateUserDataSource>(
      () => GraphQLCreateUserDataSourceImpl(sl()));
  sl.registerLazySingleton<GraphQLDataSource>(
      () => GraphQLDataSourceImpl(sl()));
  sl.registerLazySingleton<FirebaseStorageDataSource>(
      () => FirebaseStorageDataSourceImpl(sl()));
}

void _repositories() {
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<PostRepository>(
      () => PostRepositoryImpl(sl(), sl()));
}

void _useCase() {
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => CheckLoggedInAndGetDetailsUseCase(sl()));

  sl.registerLazySingleton(() => GetNewsFeedUseCase(sl()));
  sl.registerLazySingleton(() => CreatePostUseCase(sl()));
  sl.registerLazySingleton(() => GetUsersRecommendationUseCase(sl()));
  sl.registerFactory(() => FollowUserUseCase(sl()));
  sl.registerFactory(() => UnfollowUserUseCase(sl()));
  sl.registerFactory(() => GetUserDetailsUseCase(sl()));
  sl.registerFactory(() => EditUserUseCase(sl()));
  sl.registerFactory(() => GetFollowerListUseCase(sl()));
  sl.registerFactory(() => GetFollowingListUseCase(sl()));
}

void _cubit() {
  sl.registerLazySingleton(() => AuthCubit(sl(), sl(), sl()));
  sl.registerFactory(() => RegisterCubit(sl()));

  sl.registerFactory(() => NewsFeedBloc(sl()));
  sl.registerFactory(() => CreatePostBloc(sl()));
  sl.registerFactory(() => UserRecommendationBloc(sl(), sl(), sl()));
  sl.registerFactory(() => UserProfileBloc(sl(), sl()));
  sl.registerFactory(() => FollowerListBloc(sl()));
  sl.registerFactory(() => FollowingListBloc(sl()));
}
