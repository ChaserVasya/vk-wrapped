import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:front/internal/di/di.dart';
import 'package:front/ui/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Показываем нативный splash экран
  FlutterNativeSplash.preserve(widgetsBinding: WidgetsBinding.instance);

  await configureDependencies();

  // Скрываем нативный splash экран
  FlutterNativeSplash.remove();

  runApp(const VkWrappedApp());
}

// VkWrappedApp теперь определен в app.dart
