import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:study_hub/core/di/injection.dart';
import 'package:study_hub/main.dart';
import 'core/config/env_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EnvConfig.initialize(Environment.prod);
  await configureDependencies();
  runApp(const MyApp());
  
  
  
  // Add these lines to style system UI to show the battery section transparent
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Makes status bar transparent
    ),
  );
}
