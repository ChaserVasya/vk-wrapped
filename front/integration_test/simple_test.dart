import 'package:flutter_test/flutter_test.dart';
import 'package:front/internal/di/di.dart';
import 'package:front/main.dart' as app;
import 'package:front/ui/widgets/loading_widget.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  useTestLoadingWidget = true;

  group('VK Wrapped Simple Integration Test', () {
    setUp(() {
      // Сбрасываем DI контейнер перед каждым тестом
      getIt.reset();
    });

    testWidgets('Should show main screen and navigate', (tester) async {
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

      // Проверяем основные элементы
      expect(find.text('Посмотреть статистику'), findsOneWidget);
      expect(find.text('Детальная статистика'), findsOneWidget);
      expect(find.text('Настроить VK токен'), findsOneWidget);
    });

    testWidgets('Should handle loading states', (tester) async {
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

      // Переходим на экран статистики
      await tester.tap(find.text('Посмотреть статистику'));

      // Ждем с таймаутом
      attempts = 0;
      while (attempts < 10) {
        await tester.pump(const Duration(milliseconds: 500));
        attempts++;

        // Если видим экран статистики или загрузку, выходим из цикла
        if (find.text('Статистика').evaluate().isNotEmpty ||
            find.byType(LoadingWidget).evaluate().isNotEmpty) {
          break;
        }
      }

      // Проверяем что мы либо на экране статистики, либо видим загрузку
      expect(
        find.text('Статистика').evaluate().isNotEmpty ||
            find.byType(LoadingWidget).evaluate().isNotEmpty,
        isTrue,
      );
    });
  });
}
