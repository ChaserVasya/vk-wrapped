---
description: "Dart testing guidelines: mock centralization, test structure, stream testing, best practices"
alwaysApply: false
---

# Правила тестирования и моков для Mobi Trainer Client

## Основные принципы

### Структура файлов тестов

**Unit-тесты конкретных классов ДОЛЖНЫ следовать принципу зеркальной структуры**

- ✅ **Тот же путь + суффикс `_test`** - для связи с тестируемым объектом
- ✅ **Зеркальная структура папок** - тест в той же иерархии что и основной файл
- ✅ **Импорт из основного файла** - для прямого тестирования

### Примеры правильной структуры

✅ **Правильно - зеркальная структура:**

```
lib/
  domain/
    use_cases/
      birthday_use_case.dart
      get_client_code_from_nfc_use_case.dart

test/
  domain/
    use_cases/
      birthday_use_case_test.dart
      get_client_code_from_nfc_use_case_test.dart
```

### Централизованное создание моков

**ВСЕ моки ДОЛЖНЫ создаваться в файле `test/all.dart`**

- ✅ **Единая точка создания моков** - все моки в одном месте
- ✅ **Использование `@GenerateNiceMocks`** - для автоматической генерации
- ✅ **Импорт моков из `all.mocks.dart`** - в тестовых файлах
- ❌ **Создание моков в отдельных файлах тестов** - запрещено
- ❌ **Дублирование моков** - недопустимо

### Алгоритм добавления новых моков

1. **Добавить в `test/all.dart`** - новый `MockSpec<ClassName>()`
2. **Запустить генерацию** - `fvm dart run build_runner build`
3. **Импортировать из `all.mocks.dart`** - в тестовом файле
4. **Использовать готовый мок** - без создания в тесте

### Примеры правильного использования

✅ **Правильно - добавление в all.dart:**

```dart
@GenerateNiceMocks([
  // Существующие моки...
  MockSpec<NewService>(), // Новый мок
])
void _annotationAnchor() {}
```

✅ **Правильно - использование в тесте:**

```dart
import 'package:mobi_trainer/test/all.mocks.dart';

void main() {
  late MockNewService mockService;

  setUp(() {
    mockService = MockNewService();
  });
}
```

❌ **Неправильно - создание в тесте:**

```dart
@GenerateMocks([NewService]) // НЕ СОЗДАВАТЬ ЗДЕСЬ
void main() {
  // ...
}
```

## Инициализация моков в тестах

### ЗАПРЕТ дублирования инициализации моков

**НЕ создавать моки в каждом тесте отдельно**

❌ **Неправильно - дублирование:**

```dart
void main() {
  group('Test group 1', () {
    test('Test 1', () {
      final mockService = MockService(); // ПЛОХО
      final mockLogger = MockLogger();   // ПЛОХО
      // ...
    });
  });
}
```

✅ **Правильно - централизованная инициализация:**

```dart
void main() {
  late MockService mockService;
  late MockLogger mockLogger;

  setUp(() {
    mockService = MockService();
    mockLogger = MockLogger();
  });

  group('Test group 1', () {
  test('Test 1', () {
      // Используем mockService и mockLogger
    });
  });
}
```

## Приоритет

**ВЫСОКИЙ ПРИОРИТЕТ** - всегда использовать централизованное создание моков и зеркальную структуру тестов.

## Исключения

Нет исключений - правила должны соблюдаться всегда для поддержания чистоты тестовой базы.
