import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/dependencies_injection.dart';
import 'package:social_media_app/features/authentication/presentation/cubit/cubit.dart';
import 'package:social_media_app/features/news-feed/presentation/bloc/bloc.dart';
import 'package:social_media_app/features/news-feed/presentation/widgets/user_recommendation_widget.dart';
import 'package:social_media_app/features/news-feed/presentation/widgets/widgets.dart';

class NewsFeedScreen extends StatefulWidget {
  const NewsFeedScreen({super.key});

  @override
  State<NewsFeedScreen> createState() => _NewsFeedScreenState();
}

class _NewsFeedScreenState extends State<NewsFeedScreen> {
  var bloc = sl<NewsFeedBloc>();
  late String userId;
  var userRecommendationKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    userId = context.read<AuthCubit>().state.data!.userId;
    bloc.add(FetchNewsFeed(userId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => bloc,
        child: Parent(
          appBar: AppBar(
            title: const Text("News feed"),
            actions: [
              IconButton(
                  onPressed: () => context.pushNamed(Routes.myProfile.name),
                  icon: const Icon(Icons.person_pin_outlined))
            ],
          ),
          child: _buildBody(),
          floatingButton: FloatingActionButton(
            onPressed: () {
              context.pushNamed(Routes.createPost.name);
            },
            child: const Icon(Icons.add),
          ),
        ));
  }

  _buildBody() {
    return BlocBuilder(
      bloc: bloc,
      builder: (context, state) {
        if (state is NewsFeedLoading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
        if (state is NewsFeedSuccess) {
          return RefreshIndicator(
            onRefresh: () {
              var completer = Completer();
              bloc.add(RefreshNewsFeed(
                  userId: userId,
                  refreshCompleted: () {
                    userRecommendationKey = GlobalKey();
                    completer.complete();
                  }));
              return completer.future;
            },
            child: ListView.separated(
              itemCount: state.data!.length + 1,
              itemBuilder: (context, index) => index == 0
                  ? UsersRecommendationWidget(
                      key: userRecommendationKey,
                    )
                  : NewsFeedItemWidget(
                      newsFeedItemEntity: state.data![index - 1]),
              separatorBuilder: (context, index) => const Divider(),
            ),
          );
        }
        if (state is NewsFeedFailure) {
          return const Center(
            child: Text("Error"),
          );
        }
        return const SizedBox();
      },
    );
  }
}
