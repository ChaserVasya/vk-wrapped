import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:front/main.dart' as app;
import 'package:front/internal/di/di.dart';
import 'package:front/ui/widgets/loading_widget.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  useTestLoadingWidget = true;

  group('VK Wrapped Loading Test', () {
    setUp(() {
      // Сбрасываем DI контейнер перед каждым тестом
      getIt.reset();
    });

    testWidgets('Should replace LoadingWidget with TestLoadingWidget', (
      tester,
    ) async {
      // Запускаем реальное приложение
      app.main();

      // Ждем с таймаутом
      await tester.pump();

      // Ждем максимум 5 секунд для инициализации
      int attempts = 0;
      while (attempts < 10) {
        await tester.pump(const Duration(milliseconds: 500));
        attempts++;

        // Если видим главный экран, выходим из цикла
        if (find.text('VK Wrapped').evaluate().isNotEmpty) {
          break;
        }
      }

      // Проверяем что мы на главном экране
      expect(find.text('VK Wrapped'), findsOneWidget);

      // Переходим на экран статистики
      await tester.tap(find.text('Посмотреть статистику'));

      // Ждем с таймаутом
      attempts = 0;
      while (attempts < 10) {
        await tester.pump(const Duration(milliseconds: 500));
        attempts++;

        // Если видим экран статистики или текст "loading", выходим из цикла
        if (find.text('Статистика').evaluate().isNotEmpty ||
            find.text('loading').evaluate().isNotEmpty) {
          break;
        }
      }

      // Проверяем что мы либо на экране статистики, либо видим "loading"
      expect(
        find.text('Статистика').evaluate().isNotEmpty ||
            find.text('loading').evaluate().isNotEmpty,
        isTrue,
      );
    });

    testWidgets('Should handle loading states with mock widget', (
      tester,
    ) async {
      // Запускаем реальное приложение
      app.main();

      // Ждем с таймаутом
      await tester.pump();

      // Ждем максимум 5 секунд для инициализации
      int attempts = 0;
      while (attempts < 10) {
        await tester.pump(const Duration(milliseconds: 500));
        attempts++;

        // Если видим главный экран, выходим из цикла
        if (find.text('VK Wrapped').evaluate().isNotEmpty) {
          break;
        }
      }

      // Проверяем что мы на главном экране
      expect(find.text('VK Wrapped'), findsOneWidget);

      // Переходим в настройки
      await tester.tap(find.text('Настроить VK токен'));

      // Ждем с таймаутом
      attempts = 0;
      while (attempts < 10) {
        await tester.pump(const Duration(milliseconds: 500));
        attempts++;

        // Если видим экран настроек или текст "loading", выходим из цикла
        if (find.text('Настройки').evaluate().isNotEmpty ||
            find.text('loading').evaluate().isNotEmpty) {
          break;
        }
      }

      // Проверяем что мы либо на экране настроек, либо видим "loading"
      expect(
        find.text('Настройки').evaluate().isNotEmpty ||
            find.text('loading').evaluate().isNotEmpty,
        isTrue,
      );
    });
  });
}
