import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:front/internal/di/di.dart';
import 'package:front/ui/routes/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Показываем нативный splash экран
  FlutterNativeSplash.preserve(widgetsBinding: WidgetsBinding.instance);

  await configureDependencies();

  // Скрываем нативный splash экран
  FlutterNativeSplash.remove();

  runApp(const VkWrappedApp());
}

class VkWrappedApp extends StatelessWidget {
  const VkWrappedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'VK Wrapped',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4C75A3)),
        textTheme: const TextTheme(
          bodySmall: TextStyle(fontSize: 12, color: Colors.grey),
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(color: Colors.grey[400]),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
      ),
      routerConfig: AppRouter().config(),
    );
  }
}
