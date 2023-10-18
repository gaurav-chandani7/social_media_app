import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/dependencies_injection.dart';
import 'package:social_media_app/features/authentication/presentation/cubit/cubit.dart';
import 'package:social_media_app/features/news-feed/presentation/bloc/following_list/following_list_bloc.dart';
import 'package:social_media_app/utils/utils.dart';

class FollowingListWidget extends StatefulWidget {
  const FollowingListWidget({super.key});

  @override
  State<FollowingListWidget> createState() => _FollowingListWidgetState();
}

class _FollowingListWidgetState extends State<FollowingListWidget>
    with AutomaticKeepAliveClientMixin {
  late String userId;
  var bloc = sl<FollowingListBloc>();
  @override
  void initState() {
    super.initState();
    userId = context.read<AuthCubit>().state.data!.userId;
    bloc.add(GetFollowingList(userId));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => bloc,
      child: BlocListener(
        bloc: bloc,
        listener: (context, state) {
          if (state is BottomUnfollowDialogVisible) {
            showModalBottomSheet(
                context: context,
                builder: (context) => SafeArea(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: InkWell(
                              onTap: () {
                                bloc.add(UnfollowTap(
                                    selfId: userId,
                                    targetUserId: state.targetUserId));
                              },
                              child: Container(
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 12),
                                child: const Text(
                                  "Unfollow",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ));
          }
          if (state is BottomUnfollowDialogDismissed) {
            context.dismiss();
          }
        },
        child: BlocBuilder(
            bloc: bloc,
            builder: (context, state) {
              if (state is FollowingListLoaded) {
                var userList = state.followingList!;
                return ListView.separated(
                    itemBuilder: (context, index) => ListTile(
                          onTap: () =>
                              bloc.add(ShowUnfollowDialog(userList[index].id)),
                          leading:
                              LayoutBuilder(builder: (context, constraints) {
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
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
