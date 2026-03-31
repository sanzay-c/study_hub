import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:study_hub/core/di/injection.dart';
import 'package:study_hub/core/notification/notification_service.dart';
import 'package:study_hub/main.dart';
import 'core/config/env_config.dart';

void main() async {
  // Ensure Flutter bindings are initialized before any async operation
  WidgetsFlutterBinding.ensureInitialized(); 

  // 1. Firebase Initialize
  await Firebase.initializeApp();

  // 2. Initialize environment configuration for 'dev' (development) environment
  await EnvConfig.initialize(Environment.dev); 

  // 3. Setup dependency injection
  await configureDependencies();

  // 4. Push Notifications Initialize
  await PushNotificationService.initialize();

  // Run the app by passing the root widget (MyApp)
  runApp(const MyApp()); 
}