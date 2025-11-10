import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppStateWidget extends InheritedNotifier<AppState> {
  const AppStateWidget({
    super.key,
    required AppState notifier,
    required Widget child,
  }) : super(notifier: notifier, child: child);

  static AppState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<AppStateWidget>()!
        .notifier!;
  }
}

class AppState extends ChangeNotifier {
  int count = 0;
  Timer? timer;

  void increment() {
    count++;
    notifyListeners();
  }

  void startTimer() {
    stopTimer();
    if (kDebugMode) {
      print("Start timer!");
    }
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      increment();
          notifyListeners();

    });
  }

  void stopTimer() {
    if (kDebugMode) {
      print("Stop timer!");
    }
    timer?.cancel();
    timer = null;
    notifyListeners();
  }
}
