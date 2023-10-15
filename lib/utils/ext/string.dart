import 'package:flutter/material.dart';

extension StringExtension on String {
  void toToastError(BuildContext context) {
    final message = isEmpty ? "error" : this;

    dismissAllToast(context);

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  dismissAllToast(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
  }
}
