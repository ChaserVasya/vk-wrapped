---
description: "Dart/Flutter code style: const/final usage, $ naming conventions, and Bloc patterns"
alwaysApply: false
---

# Code Style Guidelines for Mobi Trainer Client

## Variable Declaration Rules

### Const vs Final Usage

**ПРАВИЛО:** Если конструктор `const`, то переменная ДОЛЖНА быть `const`

- ✅ **Правильно:** `const converter = NotificationConverter();`
- ❌ **Неправильно:** `final converter = const NotificationConverter();`

### Type Inference Preference

**ПРАВИЛО:** Предпочитать неявную типизацию (type inference)

- ✅ **Правильно:** `const converter = NotificationConverter();`
- ❌ **Неправильно:** `const NotificationConverter converter = const NotificationConverter();`

### Algorithm for Variable Declaration

1. **Конструктор const?** → переменная `const`
2. **Конструктор не const?** → переменная `final`
3. **Тип можно вывести?** → не указывать тип
4. **Тип нельзя вывести?** → указать тип

### Examples

```dart
// ✅ Правильно
const converter = NotificationConverter();
final service = Service(dependency);
final list = <String>[];

// ❌ Неправильно  
const NotificationConverter converter = const NotificationConverter();
final Service service = Service(dependency);
```

## CRITICAL: Always Apply These Rules

- **These rules apply to ALL code modifications** - no exceptions
- **Even during urgent bug fixes or migrations** - rules must be followed
- **Even for "temporary" or "work-in-progress" code** - rules must be followed
- **Review ALL variable declarations before finalizing code changes**

## Использование `$` в декларациях

Основная цель: Во многих классах, например, связанных с Bloc, приходится иметь вербозный префикс. `$` помогает улучшить читаемость.

1. Смысловые части в составных названиях отделяются от "технической" части с помощью  `$`.
   * Пример: `VisitorInfoState$DataState`
2. Равноценные слова в составных названиях параметров разделяются с помощью `$`.<span style="color:dimgray;">
   (Нестандартно, но почему бы и нет?)</span>
   * Пример: `ensure$Service$StartDT$Location`
3. В начале названий, которые публичны из-за ограничений синтаксиса dart. И их не следует использовать без особого повода.
   * Пример: `$LocationScope3`.

## Декларация публичных union подклассов

Допустим, декларация `union` класса  имеет `Название_union_класса`. Тогда, подклассы следует именовать как `Название_union_класса$смысловой_суффикс`.

Пример: `VisitorInfoState$DataState`

Это требуется потому что `union`классы используются в `switch(instance)`, и возможна путанница среди кучи всяких DataState ненужных Bloc.

**Если нет необходимости делать подклассы публичными, следует оставить приватные имена, т.е просто `смысловой_суффикс`, чтобы не засорять пространство имён и сохранить единую точку доступа к конструкторам.**

## Bloc

Хэндлер в `on` должен содержать только смысловую часть евента.

Пример: `on<ScheduleEditorEvent$ScheduleParamsEditingIsStarted>(_onScheduleParamsEditingStarted);`

Декларация коллбэка должна иметь стиль

```dart
SomeType _onScheduleParamsEditingStarted(
  название_евента event,
  Emitter<ScheduleEditorState> emit,
) {}
```

Запрещено использовать freezed sealed состояния блоков через is. Только через switch.

```dart
BlocBuilder<Bloc, BlocState>(
    builder:(context,state){
        switch(state){
            case BlocState$DataState:
              return _DataStateWidget(state);
            case BlocState$LoadingState:
              return _LoadingStateWidget();
            case ...
        }
    }
)
```

Аналогично со всеми остальными sealed классами: Effect, Event.

Определения Effect, Event, State классов должны находиться в отдельных файлах:

- Effect - в *_effect.dart
- State - в *_state.dart
- Event - в *_event.dart
