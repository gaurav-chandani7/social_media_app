import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media_app/core/core.dart';

class NewsFeedScreen extends StatelessWidget {
  const NewsFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Parent(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => context.pushNamed(Routes.myProfile.name),
              icon: Icon(Icons.person_pin_outlined))
        ],
      ),
      child: SizedBox(),
    );
  }
}
