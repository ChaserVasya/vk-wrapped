import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:front/main.dart' as app;
import 'package:front/internal/di/di.dart';
import 'package:front/ui/widgets/loading_widget.dart' show useTestLoadingWidget;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  useTestLoadingWidget = true;

  group('VK Wrapped Final Integration Test', () {
    setUp(() {
      // Сбрасываем DI контейнер перед каждым тестом
      getIt.reset();
    });

    testWidgets('Should navigate through all screens and handle data loading', (
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

      print('✅ App initialized');

      // 1. Проверяем главный экран
      expect(find.text('VK Wrapped').evaluate().isNotEmpty, isTrue);
      expect(find.text('Посмотреть статистику').evaluate().isNotEmpty, isTrue);
      expect(find.text('Настроить VK токен').evaluate().isNotEmpty, isTrue);

      print('✅ Home screen elements found');

      // 2. Переходим на экран статистики
      await tester.tap(find.text('Посмотреть статистику'));
      await tester.pump(const Duration(seconds: 1));

      print('✅ Navigated to statistics screen');

      // Ждем загрузки данных
      await tester.pump(const Duration(seconds: 5));

      // Проверяем состояние экрана статистики
      final loadingText = find.text('loading');
      final errorText = find.text('Ошибка загрузки данных');
      final emptyText = find.text('Нет данных для анализа');
      final trackCards = find.byType(Card);

      print('=== STATISTICS SCREEN STATE ===');
      print('Loading text found: ${loadingText.evaluate().isNotEmpty}');
      print('Error text found: ${errorText.evaluate().isNotEmpty}');
      print('Empty text found: ${emptyText.evaluate().isNotEmpty}');
      print('Track cards found: ${trackCards.evaluate().length}');

      // Проверяем что экран показывает какое-то состояние (не пустой)
      expect(
        errorText.evaluate().isNotEmpty ||
            emptyText.evaluate().isNotEmpty ||
            trackCards.evaluate().isNotEmpty,
        isTrue,
        reason:
            'Statistics screen should show some state (error, empty, or data)',
      );

      // 3. Возвращаемся на главный экран и переходим на экран настроек
      await tester.pageBack();
      await tester.pump(const Duration(seconds: 1));

      await tester.tap(find.text('Настроить VK токен'));
      await tester.pump(const Duration(seconds: 1));

      print('✅ Navigated to settings screen');

      // Ждем загрузки данных на экране настроек
      await tester.pump(const Duration(seconds: 3));

      // Проверяем элементы экрана настроек
      expect(find.text('Настройки').evaluate().isNotEmpty, isTrue);

      // Проверяем что есть какие-то элементы на экране (не пустой экран)
      final hasAnyText = find.byType(Text).evaluate().isNotEmpty;
      expect(
        hasAnyText,
        isTrue,
        reason: 'Settings screen should have some text elements',
      );

      print('✅ Settings screen elements found');

      // 4. Возвращаемся на главный экран
      await tester.pageBack();
      await tester.pump(const Duration(seconds: 1));

      print('✅ Returned to home screen');

      // Проверяем что мы на главном экране
      expect(find.text('VK Wrapped').evaluate().isNotEmpty, isTrue);

      print('✅ Final integration test completed successfully');
    });
  });
}
