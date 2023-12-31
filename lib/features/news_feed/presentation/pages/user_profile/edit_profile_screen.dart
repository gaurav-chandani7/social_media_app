import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/news_feed/news_feed.dart';
import 'package:social_media_app/utils/utils.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var userProfilebloc = context.read<UserProfileBloc>();
    var userInfo = userProfilebloc.state.userInfo!;
    EditUserParams editUserParams = EditUserParams(userId: userInfo.id);
    final GlobalKey<FormState> formKey = GlobalKey();
    final ValueNotifier<String?> imagePathNotifier = ValueNotifier(null);
    return Parent(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        actions: [
          IconButton(
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {
                  if (imagePathNotifier.value != null) {
                    editUserParams.displayPicturePath = imagePathNotifier.value;
                  }
                  formKey.currentState?.save();
                  userProfilebloc
                      .add(EditProfileEvent(editUserParams: editUserParams));
                }
                log(editUserParams.toString());
              },
              icon: const Icon(Icons.check))
        ],
      ),
      child: BlocListener(
        bloc: userProfilebloc,
        listener: (context, state) {
          if (state is EditProfileLoading) {
            context.showLoading();
          } else if (state is EditProfileCompleted) {
            context.dismiss();
            context.pop();
          } else if (state is EditProfileFailure) {
            context.dismiss();
          }
        },
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  userProfilebloc.add(PickImage(
                    pickedImageCallback: (path) {
                      if (path != null) {
                        imagePathNotifier.value = path;
                      }
                    },
                  ));
                },
                child: IntrinsicWidth(
                  child: Stack(
                    children: [
                      Container(
                          height: 200,
                          width: 200,
                          padding: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.8),
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(5)),
                          child: ValueListenableBuilder<String?>(
                            valueListenable: imagePathNotifier,
                            builder: (context, imagePath, child) {
                              if (imagePath != null && imagePath.isNotEmpty) {
                                return Image.file(
                                  File(imagePath),
                                  fit: BoxFit.contain,
                                );
                              }
                              return Image.network(
                                userInfo.displayPicture ??
                                    defaultDisplayPicture,
                                fit: BoxFit.contain,
                              );
                            },
                          )),
                      const Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  const Expanded(flex: 35, child: Text("First Name*")),
                  Expanded(
                    flex: 65,
                    child: TextFormField(
                      initialValue: userInfo.firstName,
                      onSaved: (newValue) {
                        if (userInfo.firstName != newValue) {
                          editUserParams.firstName = newValue;
                        }
                      },
                      validator: (value) =>
                          requiredValidator(value, "First name"),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Expanded(flex: 35, child: Text("Last Name*")),
                  Expanded(
                    flex: 65,
                    child: TextFormField(
                      initialValue: userInfo.lastName,
                      onSaved: (newValue) {
                        if (userInfo.lastName != newValue) {
                          editUserParams.lastName = newValue;
                        }
                      },
                      validator: (value) =>
                          requiredValidator(value, "Last name"),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Expanded(flex: 35, child: Text("Bio")),
                  Expanded(
                    flex: 65,
                    child: TextFormField(
                      initialValue: userInfo.bio,
                      onSaved: (newValue) {
                        if (userInfo.bio != newValue) {
                          editUserParams.bio = newValue;
                        }
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
