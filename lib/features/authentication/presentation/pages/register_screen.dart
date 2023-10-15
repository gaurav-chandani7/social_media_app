import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/authentication/authentication.dart';
import 'package:social_media_app/features/authentication/presentation/cubit/register/register_cubit.dart';
import 'package:social_media_app/utils/utils.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Parent(
      child: SafeArea(
        child: BlocListener<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state is RegisterLoading) {
              context.showLoading();
            }
            if (state is RegisterSuccess) {
              context.dismiss();
            }
            if (state is RegisterFailure) {
              context.dismiss();
              state.message.toToastError(context);
            }
          },
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Expanded(
                  flex: 15,
                  child: Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: SizedBox(
                      height: 50,
                      child: Text(
                        "Sign up & connect with world!",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 85,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Column(
                          children: [
                            TextFormField(
                              controller: _firstNameController,
                              decoration: const InputDecoration(
                                hintText: 'First name*',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.name,
                              textCapitalization: TextCapitalization.words,
                              autofillHints: const [AutofillHints.givenName],
                              validator: (val) =>
                                  requiredValidator(val, "First name"),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _lastNameController,
                              decoration: const InputDecoration(
                                hintText: 'Last name*',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.name,
                              textCapitalization: TextCapitalization.words,
                              autofillHints: const [AutofillHints.familyName],
                              validator: (val) =>
                                  requiredValidator(val, "Last name"),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _usernameController,
                              decoration: const InputDecoration(
                                hintText: 'Username',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.name,
                              autofillHints: const [AutofillHints.username],
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _bioController,
                              decoration: const InputDecoration(
                                hintText: 'Bio',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.sentences,
                              autofillHints: const [AutofillHints.jobTitle],
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _emailController,
                              decoration: const InputDecoration(
                                hintText: 'Email*',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              autofillHints: const [AutofillHints.email],
                              validator: emailFieldValidator,
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                hintText: 'Password*',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) =>
                                  value != null && value.isNotEmpty
                                      ? null
                                      : 'Password Required',
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    context.read<RegisterCubit>().register(
                                        RegisterParams(
                                            firstName:
                                                _firstNameController.text,
                                            lastName: _lastNameController.text,
                                            email: _emailController.text,
                                            password: _passwordController.text,
                                            bio: _bioController.text,
                                            username:
                                                _usernameController.text));
                                  }
                                },
                                child: const Text("Sign Up"),
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: SizedBox(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Already Registered?"),
                                TextButton(
                                    onPressed: () =>
                                        context.pushReplacementNamed(
                                            Routes.login.name),
                                    child: const Text("Login Here")),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String? Function(String?, String) requiredValidator = (value, fieldName) {
  if (value != null && value.isNotEmpty) {
    return null;
  }
  return "$fieldName Required";
};

String? Function(String?) emailFieldValidator = (value) {
  if (value != null && value.isNotEmpty) {
    if (!validateEmail(value)) {
      return "Enter a Valid email";
    }
  } else {
    return "Email Required";
  }
  return null;
};

bool validateEmail(String value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);
  return (!regex.hasMatch(value)) ? false : true;
}
