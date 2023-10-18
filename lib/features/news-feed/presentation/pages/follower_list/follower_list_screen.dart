import 'package:flutter/material.dart';
import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/news-feed/presentation/widgets/follower_list_widget.dart';
import 'package:social_media_app/features/news-feed/presentation/widgets/following_list_widget.dart';

class FollowerListScreen extends StatefulWidget {
  const FollowerListScreen({super.key, required this.tabIndex});

  final int tabIndex;

  @override
  State<FollowerListScreen> createState() => _FollowerListScreenState();
}

class _FollowerListScreenState extends State<FollowerListScreen> {
  List<Widget> tabBarChildren = [];
  @override
  void initState() {
    super.initState();
    tabBarChildren = [
      const FollowerListWidget(),
      const FollowingListWidget()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
      appBar: AppBar(),
      child: DefaultTabController(
          length: 2,
          initialIndex: widget.tabIndex,
          child: Column(
            children: [
              const TabBar(labelColor: Colors.black, tabs: [
                Tab(
                  text: "Followers",
                ),
                Tab(
                  text: "Following",
                )
              ]),
              Expanded(child: TabBarView(children: tabBarChildren)),
            ],
          )),
    );
  }
}
