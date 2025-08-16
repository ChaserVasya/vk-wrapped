import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:front/domain/exceptions/app_exception.dart';
import 'package:front/ui/widgets/error_state.dart';

void main() {
  group('ErrorStateWidget', () {
    testWidgets('Should show authorization message for NoTokenException', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ErrorStateWidget(const NoTokenException(), onRefresh: () {}),
          ),
        ),
      );

      expect(find.text('Требуется авторизация'), findsOneWidget);
      expect(
        find.text(
          'Токен истёк/не одобрен. Перейдите в настройки и введите новый.',
        ),
        findsOneWidget,
      );
      expect(find.text('Перейти в настройки'), findsOneWidget);
    });

    testWidgets('Should show error message for other exceptions', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ErrorStateWidget(
              const AppException('Test error'),
              onRefresh: () {},
            ),
          ),
        ),
      );

      expect(find.text('Произошла ошибка'), findsOneWidget);
      expect(find.text('AppException: Test error'), findsOneWidget);
      expect(find.text('Повторить'), findsOneWidget);
    });

    testWidgets('Should show debug info for AppException', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ErrorStateWidget(
              const AppException('Test error'),
              onRefresh: () {},
            ),
          ),
        ),
      );

      expect(find.text('Информация для отладки'), findsOneWidget);
      expect(find.byIcon(Icons.copy), findsOneWidget);
    });

    testWidgets('Should show different icons for different exceptions', (
      tester,
    ) async {
      // Test NoTokenException
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ErrorStateWidget(const NoTokenException(), onRefresh: () {}),
          ),
        ),
      );

      expect(find.byIcon(Icons.vpn_key), findsOneWidget);

      // Test other exception
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ErrorStateWidget(
              const AppException('Test error'),
              onRefresh: () {},
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });

    testWidgets('Should not show debug info for non-AppException errors', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ErrorStateWidget(Exception('Test error'), onRefresh: () {}),
          ),
        ),
      );

      expect(find.text('Информация для отладки'), findsNothing);
      expect(find.byIcon(Icons.copy), findsNothing);
    });
  });
}
