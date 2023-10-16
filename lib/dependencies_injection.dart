import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:social_media_app/features/features.dart';

GetIt sl = GetIt.instance;

Future<void> serviceLocator() async {
  sl.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  _dataSources();
  _repositories();
  _useCase();
  _cubit();
}

void _dataSources() {
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<GraphQLCreateUserDataSource>(
      () => GraphQLCreateUserDataSourceImpl());
}

void _repositories() {
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(sl(), sl()));
}

void _useCase() {
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => CheckLoggedInAndGetDetailsUseCase(sl()));
}

void _cubit() {
  sl.registerLazySingleton(() => AuthCubit(sl(), sl(), sl()));
  sl.registerFactory(() => RegisterCubit(sl()));
}
