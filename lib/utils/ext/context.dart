import 'dart:developer';

import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  // Future<dynamic> goTo(String routeName, {Object? args}) =>
  //     Navigator.pushNamed(this, routeName, arguments: args);

  // Future<dynamic> goToReplace(String routeName, {Object? args}) =>
  //     Navigator.pushReplacementNamed(this, routeName, arguments: args);

  // Future<dynamic> goToClearStack(String routeName, Object? args) =>
  //     Navigator.pushNamedAndRemoveUntil(this, routeName, (route) => false,
  //         arguments: args);

  Future<void> showLoading() => showDialog(
        context: this,
        barrierDismissible: false,
        builder: (c) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Material(
              color: Colors.transparent,
              child: Center(
                child: Container(
                  // decoration: BoxDecoration(
                  //   color: Theme.of(this).extension<LzyctColors>()!.background,
                  //   borderRadius: BorderRadius.circular(Dimens.cornerRadius),
                  // ),
                  // margin: EdgeInsets.symmetric(horizontal: Dimens.space30),
                  // padding: EdgeInsets.all(Dimens.space24),
                  child: const CircularProgressIndicator.adaptive(),
                ),
              ),
            ),
          );
        },
      );

  void dismiss() {
    try {
      Navigator.pop(this);
    } catch (_) {
      log(_.toString());
    }
  }
}
