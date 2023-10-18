import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/dependencies_injection.dart';
import 'package:social_media_app/features/authentication/presentation/cubit/cubit.dart';
import 'package:social_media_app/features/news_feed/presentation/bloc/user_profile/user_profile_bloc.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = sl<UserProfileBloc>();
    bloc.add(GetUserDetails(context.read<AuthCubit>().state.data!.userId));
    return BlocProvider(
      create: (context) => bloc,
      child: Parent(
          appBar: AppBar(
            title: const Text("My Profile"),
            actions: [
              IconButton(
                  onPressed: () =>
                      context.pushNamed(Routes.editMyProfile.name, extra: bloc),
                  icon: const Icon(Icons.edit))
            ],
          ),
          child: _buildBody(bloc)),
    );
  }

  _buildBody(UserProfileBloc bloc) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: BlocBuilder(
          bloc: bloc,
          builder: (context, UserProfileState state) {
            if (state is UserProfileLoading) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            if (state is UserProfileLoaded) {
              var userInfo = state.userInfo!;
              return Stack(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            padding: const EdgeInsets.all(0.5),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black45),
                                borderRadius: BorderRadius.circular(5)),
                            child: (userInfo.displayPicture != null &&
                                    userInfo.displayPicture!.isNotEmpty)
                                ? Image.network(
                                    userInfo.displayPicture!,
                                    fit: BoxFit.contain,
                                  )
                                : const Icon(Icons.dnd_forwardslash),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${userInfo.firstName} ${userInfo.lastName}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              ),
                              Text(
                                "${userInfo.username}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black54),
                              ),
                              Text(
                                "${userInfo.email}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black54),
                              ),
                              Text(
                                "${userInfo.bio}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () =>
                                context.pushNamed(Routes.followerList.name),
                            child: Column(
                              children: [
                                Text("${userInfo.followerCount ?? 0}"),
                                const Text("Followers")
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () =>
                                context.pushNamed(Routes.followingList.name),
                            child: Column(
                              children: [
                                Text("${userInfo.followingCount ?? 0}"),
                                const Text("Following")
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: TextButton(
                      child: const Text(
                        "Logout",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      onPressed: () => context.read<AuthCubit>().logout(),
                    ),
                  )
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
