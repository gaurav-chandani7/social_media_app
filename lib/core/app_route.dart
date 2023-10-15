import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media_app/dependencies_injection.dart';
import 'package:social_media_app/features/features.dart';
import 'package:social_media_app/utils/utils.dart';

enum Routes {
  root("/"),

  dashboard("/dashboard"),

  login("/auth/login"),
  register("/auth/register");

  const Routes(this.path);

  final String path;
}

class AppRoute {
  static late BuildContext context;

  AppRoute.setStream(BuildContext ctx) {
    context = ctx;
  }

  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: Routes.root.path,
        name: Routes.root.name,
        redirect: (context, state) => Routes.dashboard.path,
      ),
      GoRoute(
        path: Routes.dashboard.path,
        name: Routes.dashboard.name,
        builder: (context, state) => Container(
          color: Colors.amber.shade300,
        ),
      ),
      GoRoute(
        path: Routes.login.path,
        name: Routes.login.name,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: Routes.register.path,
        name: Routes.register.name,
        builder: (context, state) => BlocProvider(
          create: (context) => sl<RegisterCubit>(),
          child: const RegisterScreen(),
        ),
      )
    ],
    initialLocation: Routes.root.path,
    routerNeglect: true,
    debugLogDiagnostics: kDebugMode,
    refreshListenable: GoRouterRefreshStream(context.read<AuthCubit>().stream),
    redirect: (context, state) {
      final bool isLoginPage = state.matchedLocation == Routes.login.path ||
          state.matchedLocation == Routes.register.path;
      if (AuthRemoteDataSourceImpl.loggedInUser == null) {
        return isLoginPage ? null : Routes.login.path;
      }

      if (isLoginPage && AuthRemoteDataSourceImpl.loggedInUser != null) {
        return Routes.root.path;
      }

      return null;
    },
  );
}
