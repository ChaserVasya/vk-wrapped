import 'package:flutter/material.dart';
import 'package:front/internal/di/di.dart';
import 'package:front/ui/screens/home_screen.dart';
import 'package:front/ui/screens/settings_screen.dart';
import 'package:front/ui/screens/statistics_screen.dart';
import 'package:front/ui/screens/tracks_list_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const VkWrappedApp());
}

class VkWrappedApp extends StatelessWidget {
  const VkWrappedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/tracks': (context) => const TracksListScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/statistics': (context) => const StatisticsScreen(),
      },
    );
  }
}
