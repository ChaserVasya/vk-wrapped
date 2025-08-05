import 'package:flutter/material.dart';
import 'package:front/domain/services/first_launch_service.dart';
import 'package:front/internal/di/di.dart';
import 'package:front/ui/routes/app_router.dart';

class VkWrappedApp extends StatefulWidget {
  const VkWrappedApp({super.key});

  @override
  State<VkWrappedApp> createState() => _VkWrappedAppState();
}

class _VkWrappedAppState extends State<VkWrappedApp> {
  final _router = AppRouter();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkFirstLaunch();
  }

  Future<void> _checkFirstLaunch() async {
    final firstLaunchService = getIt<FirstLaunchService>();
    final isFirstLaunch = await firstLaunchService.isFirstLaunch();

    if (mounted) {
      setState(() {
        _isLoading = false;
      });

      if (isFirstLaunch) {
        // Показываем Intro страницу при первом запуске
        await _router.push(const IntroRoute());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const MaterialApp(
        home: Scaffold(body: Center(child: CircularProgressIndicator())),
      );
    }

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
      ),
      routerConfig: _router.config(),
    );
  }
}
