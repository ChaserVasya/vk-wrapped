import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', 'US'), Locale('ru', 'RU')],
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4C75A3)),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF4C75A3),
          foregroundColor: Colors.white,
          centerTitle: false,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(50),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
          ),
        ),
        textTheme: const TextTheme(
          bodySmall: TextStyle(fontSize: 12, color: Colors.grey),
          titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          headlineSmall: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        // Улучшенная поддержка эмоджи через fontFamilyFallback
        fontFamilyFallback: const [
          'Noto Color Emoji',
          'Apple Color Emoji',
          'Segoe UI Emoji',
          'Android Emoji',
        ],
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(color: Colors.grey[400]),
        ),
      ),
      routerConfig: _router.config(),
    );
  }
}
