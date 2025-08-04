import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:front/internal/di/di.dart';
import 'package:front/main.dart' as app;
import 'package:front/ui/widgets/loading_widget.dart' show useTestLoadingWidget;
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  useTestLoadingWidget = true;

  group('VK Wrapped Basic Functionality Test', () {
    setUp(() {
      // Сбрасываем DI контейнер перед каждым тестом
      getIt.reset();
    });

    testWidgets('Should show main screen with all navigation options', (
      tester,
    ) async {
      // Запускаем реальное приложение
      app.main();

      // Ждем с таймаутом
      await tester.pump();

      // Ждем максимум 10 секунд для инициализации
      int attempts = 0;
      while (attempts < 20) {
        await tester.pump(const Duration(milliseconds: 500));
        attempts++;

        // Если видим главный экран, выходим из цикла
        if (find.text('VK Wrapped').evaluate().isNotEmpty) {
          break;
        }
      }

      // Проверяем что мы на главном экране
      expect(find.text('VK Wrapped'), findsOneWidget);

      // Проверяем основные элементы главной страницы
      expect(find.text('Посмотреть статистику'), findsOneWidget);
      expect(find.text('Детальная статистика'), findsOneWidget);
      expect(find.text('Настроить VK токен'), findsOneWidget);

      // Проверяем что есть кнопка настроек в AppBar
      expect(find.byIcon(Icons.settings), findsOneWidget);
    });

    testWidgets('Should navigate to settings screen', (tester) async {
      // Запускаем реальное приложение
      app.main();

      // Ждем с таймаутом
      await tester.pump();

      // Ждем максимум 10 секунд для инициализации
      int attempts = 0;
      while (attempts < 20) {
        await tester.pump(const Duration(milliseconds: 500));
        attempts++;

        // Если видим главный экран, выходим из цикла
        if (find.text('VK Wrapped').evaluate().isNotEmpty) {
          break;
        }
      }

      // Переходим в настройки через кнопку в AppBar
      await tester.tap(find.byIcon(Icons.settings));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Проверяем что мы на экране настроек
      expect(find.text('Настройки'), findsOneWidget);
      expect(find.text('VK API Токен'), findsOneWidget);
      expect(find.text('Кэш данных'), findsOneWidget);
    });

    testWidgets('Should navigate to statistics screen', (tester) async {
      // Запускаем реальное приложение
      app.main();

      // Ждем с таймаутом
      await tester.pump();

      // Ждем максимум 10 секунд для инициализации
      int attempts = 0;
      while (attempts < 20) {
        await tester.pump(const Duration(milliseconds: 500));
        attempts++;

        // Если видим главный экран, выходим из цикла
        if (find.text('VK Wrapped').evaluate().isNotEmpty) {
          break;
        }
      }

      // Переходим на экран статистики
      await tester.tap(find.text('Посмотреть статистику'));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Проверяем что мы на экране статистики
      expect(find.text('Статистика'), findsOneWidget);

      // Проверяем что есть кнопка обновления
      expect(find.byIcon(Icons.refresh), findsOneWidget);
    });

    testWidgets('Should navigate to detailed statistics screen', (
      tester,
    ) async {
      // Запускаем реальное приложение
      app.main();

      // Ждем с таймаутом
      await tester.pump();

      // Ждем максимум 10 секунд для инициализации
      int attempts = 0;
      while (attempts < 20) {
        await tester.pump(const Duration(milliseconds: 500));
        attempts++;

        // Если видим главный экран, выходим из цикла
        if (find.text('VK Wrapped').evaluate().isNotEmpty) {
          break;
        }
      }

      // Переходим на экран детальной статистики
      await tester.tap(find.text('Детальная статистика'));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Проверяем что мы на экране детальной статистики
      expect(find.text('Детальная статистика'), findsOneWidget);
    });

    testWidgets('Should test loading states', (tester) async {
      // Запускаем реальное приложение
      app.main();

      // Ждем с таймаутом
      await tester.pump();

      // Ждем максимум 10 секунд для инициализации
      int attempts = 0;
      while (attempts < 20) {
        await tester.pump(const Duration(milliseconds: 500));
        attempts++;

        // Если видим главный экран, выходим из цикла
        if (find.text('VK Wrapped').evaluate().isNotEmpty) {
          break;
        }
      }

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
  });
}
