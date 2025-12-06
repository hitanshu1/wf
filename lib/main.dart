import 'package:flutter/material.dart';
import 'package:kuick_workflow/src/app.dart';

import 'package:kuick_workflow/src/config/env/kuick_env.dart';
import 'package:kuick_workflow/src/core/di/service_locator.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await kuickEnv.load(fileName: ".env.dev");
  await di.setupServiceLocator();
  runApp(const MyApp());
}
