import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/dependencies_injection.dart';
import 'package:social_media_app/features/authentication/authentication.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await serviceLocator();
  runApp(const SocialMediaApp());
}

class SocialMediaApp extends StatelessWidget {
  const SocialMediaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthCubit>(),
      child: Builder(builder: (context) {
        AppRoute.setStream(context);
        return MaterialApp.router(
          routerConfig: AppRoute.router,
        );
      }),
    );
  }
}
