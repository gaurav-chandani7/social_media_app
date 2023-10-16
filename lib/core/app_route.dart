import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/dependencies_injection.dart';
import 'package:social_media_app/features/features.dart';
import 'package:social_media_app/features/news-feed/presentation/pages/news_feed_screen.dart';
import 'package:social_media_app/utils/utils.dart';

enum Routes {
  root("/"),

  splash("/splash"),

  newsFeed("/newsFeed"),
  myProfile("/newsFeed/myProfile"),

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
        redirect: (context, state) => Routes.newsFeed.path,
      ),
      GoRoute(
        path: Routes.splash.path,
        name: Routes.splash.name,
        builder: (context, state) => const Parent(),
      ),
      GoRoute(
        path: Routes.newsFeed.path,
        name: Routes.newsFeed.name,
        builder: (context, state) => const NewsFeedScreen(),
      ),
      GoRoute(
        path: Routes.myProfile.path,
        name: Routes.myProfile.name,
        builder: (context, state) => Builder(builder: (context) {
          var appState = context.read<AuthCubit>().state;
          log(appState.data.toString());
          return Container(
            color: Colors.amber.shade300,
            child: Center(
              child: TextButton(
                child: const Text("Logout"),
                onPressed: () => context.read<AuthCubit>().logout(),
              ),
            ),
          );
        }),
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
    refreshListenable: GoRouterRefreshStream(sl<AuthCubit>().stream),
    redirect: (context, state) {
      log("${context.read<AuthCubit>().state.runtimeType} | ${context.read<AuthCubit>().state.data} | ${state.location}");

      bool isLoginPage = state.location == Routes.login.path ||
          state.location == Routes.register.path;

      if (context.read<AuthCubit>().state is FetchingSession) {
        return Routes.splash.path;
      }

      if (isLoginPage) {
        if (context.read<AuthCubit>().state.isLoggedIn) {
          return Routes.newsFeed.path;
        }
        if (!context.read<AuthCubit>().state.isLoggedIn) {
          return state.location;
        }
      }

      if (!isLoginPage) {
        if (!context.read<AuthCubit>().state.isLoggedIn) {
          return Routes.login.path;
        }
        if (context.read<AuthCubit>().state.isLoggedIn) {
          if (state.location.startsWith(Routes.newsFeed.path)) {
            return state.location;
          }
          return Routes.newsFeed.path;
        }
      }

      return Routes.splash.path;

      //When user logs out
      // if (context.read<AuthCubit>().state is Success) {
      //   if (!context.read<AuthCubit>().state.isLoggedIn) {
      //     return state.location == Routes.register.path
      //         ? Routes.register.path
      //         : Routes.login.path;
      //   }
      //   if (context.read<AuthCubit>().state.isLoggedIn) {
      //     return Routes.dashboard.path;
      //   }
      // }
      // return null;

      // bool isLoginPage = state.location == Routes.login.path ||
      //     state.location == Routes.register.path;
      // if (context.read<AuthCubit>().state is FetchingSession) {
      //   return Routes.splash.path;
      // }
      // //Not logged in
      // if (!context.read<AuthCubit>().state.isLoggedIn) {
      //   return isLoginPage ? state.location : Routes.login.path;
      // }
      // if (isLoginPage && context.read<AuthCubit>().state.isLoggedIn) {
      //   return Routes.dashboard.path;
      // }
      // return Routes.dashboard.path;
    },
  );
}
