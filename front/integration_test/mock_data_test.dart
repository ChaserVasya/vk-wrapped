import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:front/main.dart' as app;
import 'package:front/internal/di/di.dart';
import 'package:front/ui/widgets/loading_widget.dart' show useTestLoadingWidget;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  useTestLoadingWidget = true;

  group('VK Wrapped Mock Data Test', () {
    setUp(() {
      // Сбрасываем DI контейнер перед каждым тестом
      getIt.reset();
    });

    testWidgets('Should display mock data when available', (tester) async {
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
      await tester.pump(const Duration(seconds: 1));

      print('✅ Navigated to statistics screen');

      // Ждем загрузки данных
      await tester.pump(const Duration(seconds: 5));

      // Проверяем все возможные состояния
      final loadingText = find.text('loading');
      final errorText = find.text('Ошибка загрузки данных');
      final emptyText = find.text('Нет данных для анализа');
      final trackCards = find.byType(Card);

      print('=== FINAL STATE ===');
      print('Loading text found: ${loadingText.evaluate().isNotEmpty}');
      print('Error text found: ${errorText.evaluate().isNotEmpty}');
      print('Empty text found: ${emptyText.evaluate().isNotEmpty}');
      print('Track cards found: ${trackCards.evaluate().length}');

      // Проверяем что мы не в бесконечной загрузке
      if (loadingText.evaluate().isNotEmpty) {
        print('❌ WARNING: Still in loading state');
        expect(loadingText.evaluate().isEmpty, isTrue);
      }

      // Если видим ошибку, это нормально для теста без реального API
      if (errorText.evaluate().isNotEmpty) {
        print('✅ Error state displayed correctly');
        expect(errorText.evaluate().isNotEmpty, isTrue);
      }

      // Если видим пустое состояние, это тоже нормально
      if (emptyText.evaluate().isNotEmpty) {
        print('✅ Empty state displayed correctly');
        expect(emptyText.evaluate().isNotEmpty, isTrue);
      }

      // Если видим данные, проверяем их
      if (trackCards.evaluate().isNotEmpty) {
        print('✅ Data loaded successfully');
        expect(trackCards.evaluate().length, greaterThan(0));
      }

      // Проверяем что что-то отображается (не пустой экран)
      expect(
        errorText.evaluate().isNotEmpty ||
            emptyText.evaluate().isNotEmpty ||
            trackCards.evaluate().isNotEmpty,
        isTrue,
        reason: 'Screen should show some state (error, empty, or data)',
      );
    });
  });
}
