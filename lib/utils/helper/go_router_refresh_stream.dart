import 'dart:async';

import 'package:flutter/foundation.dart';

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((event) {
      notifyListeners();
    });
  }

  late final StreamSubscription<dynamic> _subscription;
  // bool skipNotifications = false;

  // Future<void> delay() async {
  //   await Future.delayed(const Duration(seconds: 2));
  //   if (!skipNotifications) {
  //       notifyListeners();
  //   }
  // }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
