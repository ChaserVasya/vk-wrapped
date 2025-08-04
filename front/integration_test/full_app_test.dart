import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:front/main.dart' as app;
import 'package:front/internal/di/di.dart';
import 'package:front/ui/widgets/loading_widget.dart' show useTestLoadingWidget;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  useTestLoadingWidget = true;

  group('VK Wrapped Full App Test', () {
    setUp(() {
      // Сбрасываем DI контейнер перед каждым тестом
      getIt.reset();
    });

    testWidgets('Should navigate through all screens and test functionality', (
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

        // Если видим экран детальной статистики или текст "loading", выходим из цикла
        if (find.text('Детальная статистика').evaluate().isNotEmpty ||
            find.text('loading').evaluate().isNotEmpty) {
          break;
        }
      }

      // Проверяем что мы либо на экране детальной статистики, либо видим "loading"
      expect(
        find.text('Детальная статистика').evaluate().isNotEmpty ||
            find.text('loading').evaluate().isNotEmpty,
        isTrue,
      );

      // Возвращаемся на главный экран
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pump(const Duration(seconds: 2));

      // Проверяем что мы вернулись на главный экран
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

      // Возвращаемся на главный экран
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pump(const Duration(seconds: 2));

      // Проверяем что мы вернулись на главный экран
      expect(find.text('VK Wrapped'), findsOneWidget);
    });

    testWidgets('Should test settings functionality', (tester) async {
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

      // Переходим в настройки
      await tester.tap(find.text('Настроить VK токен'));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Проверяем элементы настроек
      expect(find.text('Настройки'), findsOneWidget);
      expect(find.text('VK токен'), findsOneWidget);
      expect(find.text('Кэш'), findsOneWidget);

      // Проверяем что есть поля для ввода токена
      final tokenFields = find.byType(TextFormField);
      expect(tokenFields, findsWidgets);

      // Проверяем кнопки действий
      final actionButtons = find.byType(ElevatedButton);
      expect(actionButtons, findsWidgets);
    });

    testWidgets('Should test statistics refresh functionality', (tester) async {
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

      // Нажимаем кнопку обновления если есть
      final refreshButton = find.byIcon(Icons.refresh);
      if (refreshButton.evaluate().isNotEmpty) {
        await tester.tap(refreshButton);
        await tester.pumpAndSettle(const Duration(seconds: 3));
      }

      // Проверяем что приложение не упало
      expect(find.text('Статистика'), findsOneWidget);
    });
  });
}
