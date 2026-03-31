import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:study_hub/core/di/injection.dart';
import 'package:study_hub/core/notification/notification_service.dart';
import 'package:study_hub/main.dart';
import 'core/config/env_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EnvConfig.initialize(Environment.staging);
  await configureDependencies();
  await PushNotificationService.initialize();
  runApp(const MyApp());
}