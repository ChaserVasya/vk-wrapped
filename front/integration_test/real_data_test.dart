import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:front/internal/di/di.dart';
import 'package:front/main.dart' as app;
import 'package:front/ui/widgets/loading_widget.dart' show useTestLoadingWidget;
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  useTestLoadingWidget = true;

  group('VK Wrapped Real Data Test', () {
    setUp(() {
      // Сбрасываем DI контейнер перед каждым тестом
      getIt.reset();
    });

    testWidgets('Should load real data from backend', (tester) async {
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

      // Ждем загрузки данных
      attempts = 0;
      while (attempts < 20) {
        await tester.pump(const Duration(milliseconds: 1000));
        attempts++;

        // Если видим данные или ошибку, выходим из цикла
        if (find.text('Статистика').evaluate().isNotEmpty) {
          // Проверяем что мы не в состоянии бесконечной загрузки
          final loadingText = find.text('loading');
          final errorText = find.text('Ошибка');
          final emptyText = find.text('Нет данных для анализа');
          final trackCards = find.byType(Card);

          if (loadingText.evaluate().isNotEmpty) {
            print('Still loading... attempt $attempts');
            continue;
          }

          if (errorText.evaluate().isNotEmpty) {
            print('Error occurred: ${errorText.evaluate().first.widget}');
            break;
          }

          if (emptyText.evaluate().isNotEmpty) {
            print('No data available');
            break;
          }

          if (trackCards.evaluate().isNotEmpty) {
            print('Data loaded successfully');
            break;
          }
        }
      }

      // Проверяем что мы не в бесконечной загрузке
      final loadingText = find.text('loading');
      if (loadingText.evaluate().isNotEmpty) {
        print('WARNING: Still in loading state after 20 seconds');
        // Это не должно происходить в реальном приложении
        expect(loadingText.evaluate().isEmpty, isTrue);
      }
    });

    testWidgets('Should handle backend connection errors gracefully', (
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

      // Переходим на экран статистики
      await tester.tap(find.text('Посмотреть статистику'));

      // Ждем обработки ошибки
      attempts = 0;
      while (attempts < 15) {
        await tester.pump(const Duration(milliseconds: 1000));
        attempts++;

        // Если видим ошибку или данные, выходим из цикла
        if (find.text('Ошибка').evaluate().isNotEmpty ||
            find.text('Нет данных для анализа').evaluate().isNotEmpty ||
            find.byType(Card).evaluate().isNotEmpty) {
          break;
        }
      }

      // Проверяем что приложение не зависло в загрузке
      final loadingText = find.text('loading');
      if (loadingText.evaluate().isNotEmpty) {
        print('WARNING: App stuck in loading state');
        // В реальном приложении это должно обрабатываться
        expect(loadingText.evaluate().isEmpty, isTrue);
      }
    });
  });
}
