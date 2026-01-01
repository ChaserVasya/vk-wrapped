---
description: "Dart Disposable interface for resource cleanup in injectable classes"
alwaysApply: false
---

# Правило использования интерфейса Disposable

## Определение

**Disposable** - это интерфейс из библиотеки `injectable`, который предоставляет метод `onDispose()` для освобождения ресурсов при уничтожении объекта.

## Основные принципы

### Когда использовать Disposable

- ✅ **Классы с ресурсами для освобождения** - StreamSubscription, BehaviorSubject, Timer и т.д.
- ✅ **Классы без наследования** - которые не наследуются от классов с dispose методами
- ✅ **Сервисы и репозитории** - которые управляют ресурсами
- ✅ **Композитные классы** - которые содержат другие disposable компоненты

### Когда НЕ использовать Disposable

- ❌ **Классы, наследующиеся от Bloc/Cubit** - они dispose-ятся в BlocProvider
- ❌ **Классы, наследующиеся от StatefulWidget** - dispose-ятся автоматически
- ❌ **Компоненты, используемые в композиции** - dispose-ятся родительским классом
- ❌ **Классы без ресурсов** - нечего освобождать

## Алгоритм принятия решения

1. **Есть ли ресурсы для освобождения?**
   - Нет → НЕ использовать Disposable
   - Да → переходим к шагу 2

2. **Наследуется ли от класса с dispose?**
   - Да → НЕ использовать Disposable (уже dispose-ится)
   - Нет → переходим к шагу 3

3. **Используется ли в композиции?**
   - Да → НЕ использовать Disposable (dispose-ится родителем)
   - Нет → ✅ Использовать Disposable

## Примеры правильного использования

### ✅ Правильно - класс с ресурсами

```dart
@injectable
class NotificationManager implements Disposable {
  final _subs = <StreamSubscription>[];
  final _controller = BehaviorSubject<int>();

  @override
  Future<void> onDispose() async {
    await Future.wait([for (final sub in _subs) sub.cancel()]);
    await _controller.close();
  }
}
```

### ✅ Правильно - композитный класс

```dart
@injectable
class CompositeManager implements Disposable {
  final StateManager _stateManager;
  final DisplayManager _displayManager;
  final _subs = <StreamSubscription>[];

  @override
  Future<void> onDispose() async {
    await Future.wait([for (final sub in _subs) sub.cancel()]);
    _stateManager.dispose(); // Компонент dispose-ится родителем
  }
}
```

### ❌ Неправильно - Bloc (уже dispose-ится)

```dart
class MyBloc extends Bloc<MyEvent, MyState> implements Disposable { // НЕ НУЖНО
  @override
  Future<void> onDispose() async { // НЕ НУЖНО
    // BlocProvider автоматически dispose-ит
  }
}
```

### ❌ Неправильно - компонент в композиции

```dart
@injectable
class StateManager implements Disposable { // НЕ НУЖНО
  final _controller = BehaviorSubject<int>();

  @override
  Future<void> onDispose() async { // НЕ НУЖНО
    await _controller.close();
  }
}

// Вместо этого:
@injectable
class StateManager {
  final _controller = BehaviorSubject<int>();

  void dispose() { // Простой метод
    _controller.close();
  }
}
```

## Приоритет

**ВЫСОКИЙ ПРИОРИТЕТ** - всегда проверять необходимость Disposable интерфейса перед его использованием.

## Исключения

Нет исключений - правила должны соблюдаться всегда для предотвращения дублирования dispose логики.
