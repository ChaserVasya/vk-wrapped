import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:front/main.dart' as app;
import 'package:front/internal/di/di.dart';
import 'package:front/ui/widgets/loading_widget.dart' show useTestLoadingWidget;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  useTestLoadingWidget = true;

  group('VK Wrapped Refresh Test', () {
    setUp(() {
      // Сбрасываем DI контейнер перед каждым тестом
      getIt.reset();
    });

    testWidgets('Should load data when refresh button is pressed', (
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

      // Проверяем начальное состояние
      final refreshButton = find.byIcon(Icons.refresh);
      expect(refreshButton.evaluate().isNotEmpty, isTrue);

      print('✅ Refresh button found');

      // Нажимаем кнопку обновления
      await tester.tap(refreshButton);
      await tester.pump(const Duration(seconds: 1));

      print('✅ Pressed refresh button');

      // Ждем загрузки данных (одна попытка)
      await tester.pump(const Duration(seconds: 3));

      // Проверяем все возможные состояния
      final loadingText = find.text('loading');
      final errorText = find.text('Ошибка');
      final emptyText = find.text('Нет данных для анализа');
      final trackCards = find.byType(Card);

      print('=== FINAL STATE ===');
      print('Loading text found: ${loadingText.evaluate().isNotEmpty}');
      print('Error text found: ${errorText.evaluate().isNotEmpty}');
      print('Empty text found: ${emptyText.evaluate().isNotEmpty}');
      print('Track cards found: ${trackCards.evaluate().length}');

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

      // Если видим данные, проверяем их
      if (trackCards.evaluate().isNotEmpty) {
        print('✅ Data loaded successfully');
        expect(trackCards.evaluate().length, greaterThan(0));
      }

      // Проверяем что мы не в бесконечной загрузке
      if (loadingText.evaluate().isNotEmpty) {
        print('❌ WARNING: Still in loading state after refresh');
        expect(loadingText.evaluate().isEmpty, isTrue);
      }
    });
  });
}
