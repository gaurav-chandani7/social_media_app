import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/dependencies_injection.dart';
import 'package:social_media_app/features/authentication/presentation/cubit/cubit.dart';
import 'package:social_media_app/features/news-feed/presentation/bloc/following_list/following_list_bloc.dart';

class FollowingListWidget extends StatefulWidget {
  const FollowingListWidget({super.key});

  @override
  State<FollowingListWidget> createState() => _FollowingListWidgetState();
}

class _FollowingListWidgetState extends State<FollowingListWidget>
    with AutomaticKeepAliveClientMixin {
  var bloc = sl<FollowingListBloc>();
  @override
  void initState() {
    super.initState();
    final userId = context.read<AuthCubit>().state.data!.userId;
    bloc.add(GetFollowingList(userId));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => bloc,
      child: BlocBuilder(
          bloc: bloc,
          builder: (context, state) {
            if (state is FollowingListLoaded) {
              var userList = state.followingList!;
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
            if (state is FollowingListLoading) {
              return const CircularProgressIndicator.adaptive();
            }
            return const SizedBox();
          }),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
