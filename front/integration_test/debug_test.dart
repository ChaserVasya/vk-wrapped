import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:front/internal/di/di.dart';
import 'package:front/main.dart' as app;
import 'package:front/ui/widgets/loading_widget.dart' show useTestLoadingWidget;
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  useTestLoadingWidget = true;

  group('VK Wrapped Debug Test', () {
    setUp(() {
      // Сбрасываем DI контейнер перед каждым тестом
      getIt.reset();
    });

    testWidgets('Should debug loading issue on statistics screen', (
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
      await tester.pump(const Duration(seconds: 2));

      print('✅ Navigated to statistics screen');

      // Детально анализируем состояние экрана
      for (int i = 0; i < 3; i++) {
        await tester.pump(const Duration(seconds: 2));

        // Проверяем все возможные состояния
        final loadingText = find.text('loading');
        final errorText = find.text('Ошибка');
        final emptyText = find.text('Нет данных для анализа');
        final trackCards = find.byType(Card);
        final refreshButton = find.byIcon(Icons.refresh);

        print('=== Attempt ${i + 1} ===');
        print('Loading text found: ${loadingText.evaluate().isNotEmpty}');
        print('Error text found: ${errorText.evaluate().isNotEmpty}');
        print('Empty text found: ${emptyText.evaluate().isNotEmpty}');
        print('Track cards found: ${trackCards.evaluate().length}');
        print('Refresh button found: ${refreshButton.evaluate().isNotEmpty}');

        // Если видим ошибку, выводим её текст
        if (errorText.evaluate().isNotEmpty) {
          final errorWidget = errorText.evaluate().first.widget as Text;
          print('ERROR TEXT: ${errorWidget.data}');
        }

        // Если видим пустое состояние, выводим текст
        if (emptyText.evaluate().isNotEmpty) {
          final emptyWidget = emptyText.evaluate().first.widget as Text;
          print('EMPTY TEXT: ${emptyWidget.data}');
        }

        // Если видим ошибку или данные, выходим
        if (errorText.evaluate().isNotEmpty ||
            emptyText.evaluate().isNotEmpty ||
            trackCards.evaluate().isNotEmpty) {
          print('✅ Final state reached');
          break;
        }
      }

      // Финальная проверка
      final loadingText = find.text('loading');
      final errorText = find.text('Ошибка');
      final emptyText = find.text('Нет данных для анализа');
      final trackCards = find.byType(Card);

      print('=== FINAL STATE ===');
      print('Still loading: ${loadingText.evaluate().isNotEmpty}');
      print('Has error: ${errorText.evaluate().isNotEmpty}');
      print('Is empty: ${emptyText.evaluate().isNotEmpty}');
      print('Has tracks: ${trackCards.evaluate().isNotEmpty}');

      // Проверяем что мы не в бесконечной загрузке
      if (loadingText.evaluate().isNotEmpty) {
        print('❌ WARNING: Still in loading state after 30 seconds');
        expect(loadingText.evaluate().isEmpty, isTrue);
      }
    });
  });
}
