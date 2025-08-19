import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:front/domain/repositories/audio_repository.dart';
import 'package:front/domain/services/remote_config_service.dart';
import 'package:front/internal/di/di.dart';
import 'package:front/ui/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Показываем нативный splash экран
  FlutterNativeSplash.preserve(widgetsBinding: WidgetsBinding.instance);

  // Инициализируем Firebase
  await Firebase.initializeApp();

  await configureDependencies();

  // Инициализируем Remote Config
  final remoteConfigService = getIt<RemoteConfigService>();
  await remoteConfigService.init();

  // Запускаем обновление фотографий артистов в фоне
  _initArtistPhotosUpdate();

  // Скрываем нативный splash экран
  FlutterNativeSplash.remove();

  runApp(const VkWrappedApp());
}

/// Инициализирует обновление фотографий артистов в фоновом режиме
void _initArtistPhotosUpdate() {
  // Запускаем в фоне, чтобы не блокировать запуск приложения
  Future.microtask(() async {
    try {
      final audioRepository = getIt<AudioRepository>();
      await audioRepository.updateArtistPhotosInBackground();
    } catch (e) {
      print('[ERROR] Failed to initialize artist photos update: $e');
    }
  });
}

// VkWrappedApp теперь определен в app.dart
