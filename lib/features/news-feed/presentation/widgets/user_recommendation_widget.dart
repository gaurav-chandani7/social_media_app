import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/dependencies_injection.dart';
import 'package:social_media_app/features/authentication/presentation/cubit/cubit.dart';
import 'package:social_media_app/features/news-feed/presentation/bloc/user_recommendation/user_recommendation_bloc.dart';

class UsersRecommendationWidget extends StatefulWidget {
  const UsersRecommendationWidget({super.key});

  @override
  State<UsersRecommendationWidget> createState() =>
      _UsersRecommendationWidgetState();
}

class _UsersRecommendationWidgetState extends State<UsersRecommendationWidget> {
  var bloc = sl<UserRecommendationBloc>();
  @override
  void initState() {
    super.initState();
    bloc.add(
        GetUserRList(userId: context.read<AuthCubit>().state.data!.userId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocBuilder(
        bloc: bloc,
        builder: (context, state) {
          if (state is UserRecommendationLoaded) {
            var data = state.data!;
            return SizedBox(
              height: 250,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    child: Text(
                      "Users to follow",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: state.data!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Expanded(
                                      flex: 65,
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: const Border.fromBorderSide(
                                                BorderSide(
                                                    color: Colors.grey))),
                                        child: (data[index].displayPicture !=
                                                    null &&
                                                data[index]
                                                    .displayPicture!
                                                    .isNotEmpty)
                                            ? Image.network(
                                                data[index].displayPicture!,
                                                fit: BoxFit.contain,
                                              )
                                            : const Icon(
                                                Icons.dnd_forwardslash),
                                      )),
                                  Expanded(
                                    flex: 35,
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                            "${data[index].firstName} ${data[index].lastName}"),
                                        ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.zero,
                                                visualDensity:
                                                    VisualDensity.comfortable),
                                            child: const Text("Follow"))
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )),
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
