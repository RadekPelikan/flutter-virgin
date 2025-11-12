import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessageingBackgroundHandler(RemoteMessage message) async {
  await NotificationService.instance.setupFlutterNotifications();
  await NotificationService.instance.showNotification(message);
}

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final _messaging = FirebaseMessaging.instance;
  final _localNotifications = FlutterLocalNotificationsPlugin();
  bool _isFlutterLocalNotificationInitialized = false;

  static const _highImportanceChannelId = "high_importance_channel";
  static const _highImportanceChannelName = "High Importance Notifications";
  static const _notificationIcon = '@mipmap/ic_launcher';

  static const _subscribedTopics = <Topic>{};

  Future<void> initialize() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessageingBackgroundHandler);

    await _requestPermission();

    await _setupMessageHandlers();

    await _subsribeTopics([Topic.Chat, Topic.Offer]);

    final token = await _messaging.getToken();
    print("FCM Token: $token");
  }

  Future<void> setupFlutterNotifications() async {
    if (_isFlutterLocalNotificationInitialized) {
      return;
    }

    const channel = AndroidNotificationChannel(
      _highImportanceChannelId,
      _highImportanceChannelName,
      description: "This channel is used for imprtant notifications.",
      importance: Importance.high,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);

    const initializationSettigsAndroid = AndroidInitializationSettings(
      _notificationIcon,
    );

    final initializationSettings = InitializationSettings(
      android: initializationSettigsAndroid,
    );

    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {},
    );

    _isFlutterLocalNotificationInitialized = true;
  }

  Future<void> showNotification(RemoteMessage message) async {
    final notification = message.notification;
    final android = message.notification?.android;
    if (notification != null && android != null) {
      await _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _highImportanceChannelId,
            _highImportanceChannelName,
            channelDescription:
                "This channel is used for imprtant notifications.",
            importance: Importance.high,
            priority: Priority.high,
            icon: _notificationIcon,
          ),
        ),
        payload: message.data.toString(),
      );
    }
  }

  Future<void> subsribeTopic(Topic topic) async {
    if (_subscribedTopics.contains(topic)) return;
    await _messaging.subscribeToTopic(topic.Code);
  }

  Future<void> _subsribeTopics(List<Topic> topics) async {
    for (var topic in topics) {
      await subsribeTopic(topic);
    }
  }

  Future<void> _requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
      announcement: false,
      carPlay: false,
      criticalAlert: false,
    );

    print("Permission status: ${settings.authorizationStatus}");
  }

  Future<void> _setupMessageHandlers() async {
    // Foregroudn message
    FirebaseMessaging.onMessage.listen((message) {
      showNotification(message);
    });

    // Background message
    FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgorundMessage);

    // Opened app
    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _handleBackgorundMessage(initialMessage);
    }
  }

  void _handleBackgorundMessage(RemoteMessage message) {
    if (message.data['type'] == 'chat') {
      // open chat screen
    }
  }
}

enum Topic {
  Offer(Code: "Offer"),
  Chat(Code: "Chat");

  const Topic({required this.Code});

  final String Code;
}
