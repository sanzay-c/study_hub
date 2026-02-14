import 'package:flutter/material.dart';
import 'package:study_hub/core/di/injection.dart';
import 'package:study_hub/main.dart';
import 'core/config/env_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EnvConfig.initialize(Environment.staging);
  await configureDependencies();
  runApp(const MyApp());
}