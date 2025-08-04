import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:front/internal/di/di.dart';
import 'package:front/main.dart' as app;
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('VK Wrapped Real App Integration Test', () {
    setUp(() {
      // Сбрасываем DI контейнер перед каждым тестом
      getIt.reset();
    });

    testWidgets('Should navigate through all screens', (tester) async {
      // Запускаем реальное приложение
      app.main();

      // Ждем с таймаутом и обрабатываем загрузку
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

      // Переходим на экран статистики
      await tester.tap(find.text('Посмотреть статистику'));

      // Ждем с таймаутом
      attempts = 0;
      while (attempts < 10) {
        await tester.pump(const Duration(milliseconds: 500));
        attempts++;

        // Если видим экран статистики, выходим из цикла
        if (find.text('Статистика').evaluate().isNotEmpty) {
          break;
        }
      }

      // Проверяем что мы на экране статистики
      expect(find.text('Статистика'), findsOneWidget);

      // Возвращаемся на главный экран
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pump(const Duration(seconds: 2));

      // Проверяем что мы вернулись на главный экран
      expect(find.text('VK Wrapped'), findsOneWidget);

      // Переходим на экран детальной статистики
      await tester.tap(find.text('Детальная статистика'));

      // Ждем с таймаутом
      attempts = 0;
      while (attempts < 10) {
        await tester.pump(const Duration(milliseconds: 500));
        attempts++;

        // Если видим экран детальной статистики, выходим из цикла
        if (find.text('Детальная статистика').evaluate().isNotEmpty) {
          break;
        }
      }

      // Проверяем что мы на экране детальной статистики
      expect(find.text('Детальная статистика'), findsOneWidget);

      // Возвращаемся на главный экран
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pump(const Duration(seconds: 2));

      // Проверяем что мы вернулись на главный экран
      expect(find.text('VK Wrapped'), findsOneWidget);

      // Переходим в настройки
      await tester.tap(find.text('Настройки'));

      // Ждем с таймаутом
      attempts = 0;
      while (attempts < 10) {
        await tester.pump(const Duration(milliseconds: 500));
        attempts++;

        // Если видим экран настроек, выходим из цикла
        if (find.text('Настройки').evaluate().isNotEmpty) {
          break;
        }
      }

      // Проверяем что мы в настройках
      expect(find.text('Настройки'), findsOneWidget);

      // Возвращаемся на главный экран
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pump(const Duration(seconds: 2));

      // Проверяем что мы вернулись на главный экран
      expect(find.text('VK Wrapped'), findsOneWidget);
    });

    testWidgets('Should handle settings configuration', (tester) async {
      // Запускаем реальное приложение
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Переходим в настройки
      await tester.tap(find.text('Настройки'));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Проверяем элементы настроек
      expect(find.text('Настройки'), findsOneWidget);
      expect(find.text('VK токен'), findsOneWidget);
      expect(find.text('Кэш'), findsOneWidget);
    });

    testWidgets('Should handle statistics refresh', (tester) async {
      // Запускаем реальное приложение
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Переходим на экран статистики
      await tester.tap(find.text('Посмотреть статистику'));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Нажимаем кнопку обновления если есть
      final refreshButton = find.byIcon(Icons.refresh);
      if (refreshButton.evaluate().isNotEmpty) {
        await tester.tap(refreshButton);
        await tester.pumpAndSettle(const Duration(seconds: 3));
      }

      // Проверяем что приложение не упало
      expect(find.text('Статистика'), findsOneWidget);
    });

    testWidgets('Should find all main UI elements', (tester) async {
      // Запускаем реальное приложение
      app.main();

      // Ждем с таймаутом и обрабатываем загрузку
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

      // Проверяем основные элементы главной страницы
      expect(find.text('VK Wrapped'), findsOneWidget);
      expect(find.text('Посмотреть статистику'), findsOneWidget);
      expect(find.text('Детальная статистика'), findsOneWidget);
      expect(find.text('Настроить VK токен'), findsOneWidget);
    });
  });
}
