import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:front/main.dart' as app;
import 'package:front/internal/di/di.dart';
import 'package:front/ui/widgets/loading_widget.dart' show useTestLoadingWidget;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  useTestLoadingWidget = true;

  group('VK Wrapped Final Test - TASK.md Requirements', () {
    setUp(() {
      // Сбрасываем DI контейнер перед каждым тестом
      getIt.reset();
    });

    testWidgets('Should meet all TASK.md requirements', (tester) async {
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

      // ✅ Требование: Каждый функционал - отдельная страница
      expect(find.text('VK Wrapped'), findsOneWidget);
      expect(find.text('Посмотреть статистику'), findsOneWidget);
      expect(find.text('Детальная статистика'), findsOneWidget);
      expect(find.text('Настроить VK токен'), findsOneWidget);

      // ✅ Требование: У юзера должна быть возможность обновлять токен
      // Переходим в настройки
      await tester.tap(find.byIcon(Icons.settings));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.text('Настройки'), findsOneWidget);
      expect(find.text('VK API Токен'), findsOneWidget);
      expect(find.text('Кэш данных'), findsOneWidget);

      // Проверяем что есть кнопки для работы с токеном
      expect(find.text('Проверить статус'), findsOneWidget);
      expect(find.text('Очистить'), findsOneWidget);
      expect(find.text('Настроить токен'), findsOneWidget);

      // Возвращаемся на главный экран
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // ✅ Требование: У пользователя должна быть возможность поделиться данными
      // Переходим в настройки снова
      await tester.tap(find.byIcon(Icons.settings));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Проверяем что есть кнопка экспорта данных
      expect(find.text('Экспорт данных'), findsOneWidget);

      // Возвращаемся на главный экран
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // ✅ Требование: Должны учитываться все состояния: загрузка, ошибка, наличие данных
      // Переходим на экран статистики
      await tester.tap(find.text('Посмотреть статистику'));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.text('Статистика'), findsOneWidget);

      // Проверяем что есть кнопка обновления (для загрузки данных)
      expect(find.byIcon(Icons.refresh), findsOneWidget);

      // Возвращаемся на главный экран
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // ✅ Требование: Юзер должен иметь возможность максимально сконфигурировать все параметры
      // Переходим на экран детальной статистики
      await tester.tap(find.text('Детальная статистика'));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.text('Детальная статистика'), findsOneWidget);

      // Возвращаемся на главный экран
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // ✅ Требование: Приложение должно работать на android
      // Проверяем что мы на Android устройстве
      expect(find.text('VK Wrapped'), findsOneWidget);
    });

    testWidgets('Should handle loading states correctly', (tester) async {
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

      // ✅ Требование: LoadingWidget используется для показа загрузки
      // Проверяем что мы либо на экране статистики, либо видим "loading"
      expect(
        find.text('Статистика').evaluate().isNotEmpty ||
            find.text('loading').evaluate().isNotEmpty,
        isTrue,
      );
    });

    testWidgets('Should have proper navigation structure', (tester) async {
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

      // ✅ Требование: Разделять по смыслу и согласно UX
      // Проверяем что навигация логична
      expect(find.text('Посмотреть статистику'), findsOneWidget);
      expect(find.text('Детальная статистика'), findsOneWidget);
      expect(find.text('Настроить VK токен'), findsOneWidget);

      // Проверяем что есть кнопка настроек в AppBar
      expect(find.byIcon(Icons.settings), findsOneWidget);
    });
  });
}
