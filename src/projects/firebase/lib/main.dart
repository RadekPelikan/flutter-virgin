import 'dart:async';

import 'package:app/firebase_options.dart';
import 'package:app/services/notification_service.dart';
import 'package:app/state/app_state.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService.instance.initialize();

  final appState = AppState();

  runApp(AppStateWidget(notifier: appState, child: MainApp()));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    final appState = AppStateWidget.of(context);

    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min, // shrink horizontally
            children: [
              Text(
                'Clicks: ${appState.count}',
                textScaler: TextScaler.linear(4),
              ),
              Text(
                'Timer is ${appState.timer?.isActive == true ? "running" : "stoppped"}',
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  if (kDebugMode) {
                    print("Increment click!");
                  }
                  appState.increment();
                },
                child: const Text("Increment"),
              ),
              TimerButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class TimerButton extends StatelessWidget {
  const TimerButton({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppStateWidget.of(context);

    return Container(
      child: appState.timer?.isActive == true
          ? ElevatedButton(
              onPressed: appState.stopTimer,
              child: Text("Stop Timer"),
            )
          : ElevatedButton(
              onPressed: appState.startTimer,
              child: Text("Start Timer"),
            ),
    );
  }
}
