import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:study_hub/core/notification/notification_service.dart';
// Note: You must run `flutterfire configure` to generate this file!
// import 'package:study_hub/firebase_options.dart'; 
import 'package:flutter/services.dart';
import 'package:study_hub/core/di/injection.dart';
import 'package:study_hub/main.dart';
import 'core/config/env_config.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await EnvConfig.initialize(Environment.prod);
//   await configureDependencies();
//   runApp(const MyApp());

  
  
//   // Add these lines to style system UI to show the battery section transparent
//   SystemChrome.setSystemUIOverlayStyle(
//     const SystemUiOverlayStyle(
//       statusBarColor: Colors.transparent, // Makes status bar transparent
//     ),
//   );
// }


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 1. Firebase Initialize
  // Important: If you haven't generated firebase_options.dart, 
  // you'll need to pass the options manually or run the CLI.
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform, 
  );

  // 2. Dependency Injection & Env
  await EnvConfig.initialize(Environment.prod);
  await configureDependencies();

  // 3. Push Notifications Initialize
  await PushNotificationService.initialize();
  
  // Print token for debugging
  String? token = await PushNotificationService.getToken();
  print("---------- FCM TOKEN ----------");
  print(token);
  print("-------------------------------");

  runApp(const MyApp());

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
}