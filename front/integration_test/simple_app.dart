import 'package:flutter/material.dart';
import 'package:front/internal/di/di.dart';
import 'package:front/ui/screens/detailed_statistics_screen.dart';
import 'package:front/ui/screens/home_screen.dart';
import 'package:front/ui/screens/settings_screen.dart';
import 'package:front/ui/screens/statistics_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Добавляем таймаут для инициализации зависимостей
  try {
    await configureDependencies().timeout(const Duration(seconds: 10));
  } catch (e) {
    print('Warning: Failed to configure dependencies: $e');
    // Продолжаем без DI в случае ошибки
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VK Wrapped',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4C75A3)),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/statistics': (context) => const StatisticsScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/detailed-statistics': (context) =>
            const DetailedStatisticsScreen(tracks: []),
      },
    );
  }
}
