import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/dependencies_injection.dart';
import 'package:social_media_app/features/authentication/authentication.dart';
import 'package:social_media_app/features/news_feed/domain/entities/create_post/create_post_item.dart';
import 'package:social_media_app/features/news_feed/presentation/bloc/create_post/create_post_bloc.dart';
import 'package:social_media_app/utils/utils.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final bloc = sl<CreatePostBloc>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final CreatePostItemParams createPostItemParams =
      CreatePostItemParams.initial();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: Parent(
        appBar: AppBar(
          title: const Text("Add new Post"),
        ),
        child: SafeArea(
            child: BlocListener(
                bloc: bloc,
                listener: (context, CreatePostState state) {
                  if (state is PublishLoading) {
                    context.showLoading();
                  } else if (state is PublishSuccess) {
                    context.dismiss();
                    log("Publish success UI");
                    context.pop();
                  }
                },
                child: Stack(
                  children: [
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                  hintText: "Post title*"),
                              validator: (val) =>
                                  requiredValidator(val, "Post Title"),
                              onSaved: (newValue) {
                                if (newValue != null) {
                                  createPostItemParams.postTitle = newValue;
                                }
                              },
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  hintText: "Post description"),
                              onSaved: (newValue) => createPostItemParams
                                  .postDescription = newValue,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            BlocBuilder(
                              bloc: bloc,
                              builder: (context, CreatePostState state) {
                                if (state is ImagesAttached) {
                                  return Stack(
                                    children: [
                                      Container(
                                        color: Colors.black,
                                        child: Image.file(
                                          File(state.urls!.first),
                                          height: 300,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      Positioned(
                                        top: 5,
                                        right: 5,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 7),
                                          decoration: BoxDecoration(
                                              color: Colors.white60,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Icon(
                                                Icons.filter_sharp,
                                                size: 20,
                                              ),
                                              Text("${state.urls!.length}"),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                }
                                return GestureDetector(
                                  onTap: () => bloc.add(PickImages()),
                                  child: SizedBox(
                                    height: 300,
                                    child: Container(
                                      color: Colors.grey,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 100, vertical: 40),
                                      child: const Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.upload),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text("Pick Image")
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                          ],
                        )),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton(
                        child: const Text("Publish"),
                        onPressed: () {
                          String userId =
                              context.read<AuthCubit>().state.data!.userId;
                          if (_formKey.currentState?.validate() ?? false) {
                            _formKey.currentState?.save();
                            if (bloc.state is! ImagesAttached) {
                              "Image/s required to create Post"
                                  .toToastError(context);
                            } else {
                              createPostItemParams.postedBy = userId;
                              bloc.add(PublishPost(
                                  createPostItemParams: createPostItemParams));
                            }
                          }
                        },
                      ),
                    )
                  ],
                ))),
      ),
    );
  }
}
