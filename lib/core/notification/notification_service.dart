import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:study_hub/features/auth/domain/repo/auth_repo.dart';
import 'package:study_hub/core/di/injection.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  
  // Firebase initialize garnu bhanda pahile backgrounds ma message aunda yo run hunchha
  print("Handling a background message: ${message.messageId}");
}

class PushNotificationService {
  static final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  /// The ID of the chat currently being viewed by the user. 
  /// Notifications for this chat will be silenced while the app is in foreground.
  static String? currentChatId;

  static Future<void> initialize() async {
    // 1. Request Permissions
    await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,

    );

    // 2. Setup Local Notifications (Android Foreground ko lagi)
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description: 'This channel is used for important notifications.',
      importance: Importance.max,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings iosSettings = DarwinInitializationSettings();
    const InitializationSettings initSettings =
        InitializationSettings(android: androidSettings, iOS: iosSettings);

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (details) {
        // Notification click garda yaha logic halne
        print("Local notification clicked!");
      },
    );

    // 3. Foreground message listener
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print("🔔 DEBUG: Foreground message received: ${message.notification?.title}");
      print("📦 DEBUG: Message Data: ${message.data}");

      final String? senderId = message.data['sender_id'];
      final String? chatId = message.data['group_id'] ?? message.data['room_id'];

      // 1. Skip if it's our own message (Self-Notification fix)
      final currentUser = await getIt<AuthRepo>().getCurrentUser();
      if (senderId != null && senderId == currentUser?.id) {
        print("⏭️ DEBUG: Skipping self-notification");
        return;
      }

      // 2. Skip if we are already viewing this chat
      if (chatId != null && chatId == currentChatId) {
        print("⏭️ DEBUG: Already in this chat, skipping notification");
        return;
      }

      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null) {
        _localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              importance: Importance.max,
              priority: Priority.high,
              icon: android?.smallIcon ?? '@mipmap/ic_launcher',
            ),
          ),
        );
      } else {
        print("⚠️ DEBUG: Received a 'Silent' data message (no notification block)");
      }
    });

    // 4. App background ma hunda notification click garda
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("Notification clicked and app opened from background!");
    });

    // 5. App terminated hunda notification click garda
    RemoteMessage? initialMessage = await _fcm.getInitialMessage();
    if (initialMessage != null) {
      print("App opened from terminated state via notification!");
    }
  }

  static Future<String?> getToken() async {
    return await _fcm.getToken();
  }

  // Demo ko lagi fake notification dekhaune
  static Future<void> showTestNotification() async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformDetails = NotificationDetails(android: androidDetails);

    await _localNotifications.show(
      0,
      "Demo: New Message!",
      "This is how your notification will look when a message arrives.",
      platformDetails,
    );
  }
}

