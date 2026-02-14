import 'package:flutter/material.dart';
import 'package:study_hub/core/di/injection.dart';
import 'package:study_hub/main.dart';
import 'core/config/env_config.dart';

void main() async {
  // Ensure Flutter bindings are initialized before any async operation
  WidgetsFlutterBinding.ensureInitialized(); 

  // Initialize environment configuration for 'dev' (development) environment
  await EnvConfig.initialize(Environment.dev); 

  // Setup dependency injection
  await configureDependencies();

  // Run the app by passing the root widget (MyApp)
  runApp(const MyApp()); 
}