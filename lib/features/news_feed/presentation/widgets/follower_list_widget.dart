import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/dependencies_injection.dart';
import 'package:social_media_app/features/authentication/presentation/cubit/cubit.dart';
import 'package:social_media_app/features/news_feed/presentation/bloc/follower_list/follower_list_bloc.dart';

class FollowerListWidget extends StatefulWidget {
  const FollowerListWidget({super.key});

  @override
  State<FollowerListWidget> createState() => _FollowerListWidgetState();
}

class _FollowerListWidgetState extends State<FollowerListWidget>
    with AutomaticKeepAliveClientMixin {
  var bloc = sl<FollowerListBloc>();
  @override
  void initState() {
    super.initState();
    final userId = context.read<AuthCubit>().state.data!.userId;
    bloc.add(GetFollowerList(userId));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => bloc,
      child: BlocBuilder(
          bloc: bloc,
          builder: (context, state) {
            if (state is FollowerListLoaded) {
              var userList = state.followerList!;
              return ListView.separated(
                  itemBuilder: (context, index) => ListTile(
                        onTap: () {},
                        leading: LayoutBuilder(builder: (context, constraints) {
                          return Container(
                            height: constraints.maxHeight,
                            width: constraints.maxHeight,
                            decoration: BoxDecoration(
                                color: Colors.black87,
                                borderRadius: BorderRadius.circular(5),
                                border: const Border.fromBorderSide(
                                    BorderSide(color: Colors.grey))),
                            child: Image.network(
                              userList[index].displayPicture ??
                                  defaultDisplayPicture,
                              fit: BoxFit.contain,
                            ),
                          );
                        }),
                        title: Text(
                            "${userList[index].firstName} ${userList[index].lastName}"),
                        subtitle: Text("${userList[index].bio}"),
                      ),
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: userList.length);
            }
            if (state is FollowerListLoading) {
              return const CircularProgressIndicator.adaptive();
            }
            return const SizedBox();
          }),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
