import 'dart:convert';
import 'dart:io';

/// Сервис для работы с базой данных
class DatabaseService {
  static const String _functionsPath = '../yandex-cloud/functions';

  /// Получает данные из базы данных
  static Future<Map<String, dynamic>> getDatabaseData() async {
    try {
      // Запускаем TypeScript скрипт
      final result = await Process.run(
        'npm',
        ['run', 'read-db'],
        workingDirectory: _functionsPath,
        runInShell: true,
      );

      if (result.exitCode != 0) {
        // При ошибке ищем JSON в stderr
        try {
          final errorJson = _extractJsonFromOutput(result.stderr.toString());
          final errorData = jsonDecode(errorJson);

          if (errorData['error'] != null) {
            final statusCode = errorData['statusCode'] ?? 500;
            throw Exception(
              'Database error ($statusCode): ${errorData['error']}',
            );
          }
        } catch (e) {
          // Если не удалось распарсить JSON ошибки, попробуем в stdout
          try {
            final errorJson = _extractJsonFromOutput(result.stdout.toString());
            final errorData = jsonDecode(errorJson);

            if (errorData['error'] != null) {
              final statusCode = errorData['statusCode'] ?? 500;
              throw Exception(
                'Database error ($statusCode): ${errorData['error']}',
              );
            }
          } catch (e2) {
            // Если не удалось распарсить JSON ошибки
            throw Exception('TypeScript script failed: ${result.stderr}');
          }
        }
      }

      // При успехе ищем JSON в stdout
      final jsonString = _extractJsonFromOutput(result.stdout.toString());
      final jsonData = jsonDecode(jsonString);

      return jsonData;
    } catch (e) {
      throw Exception('Error fetching database data: $e');
    }
  }

  /// Извлекает JSON из вывода npm
  static String _extractJsonFromOutput(String output) {
    final lines = output.split('\n');

    // Ищем начало JSON (строку с {)
    int startIndex = -1;
    for (int i = lines.length - 1; i >= 0; i--) {
      final line = lines[i].trim();
      if (line.startsWith('{')) {
        startIndex = i;
        break;
      }
    }

    if (startIndex == -1) {
      throw Exception('No JSON start found in output');
    }

    // Собираем JSON из строк начиная с startIndex
    final jsonLines = lines
        .skip(startIndex)
        .takeWhile((line) => line.trim().isNotEmpty);
    final jsonString = jsonLines.join('\n');

    return jsonString;
  }
}
