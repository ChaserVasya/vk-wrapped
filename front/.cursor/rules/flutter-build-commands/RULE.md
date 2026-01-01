---
description: "Extract Flutter build parameters from Android Studio .run.xml configuration files"
alwaysApply: true
---

# Правило автоматического формирования Flutter команд из конфигурационных файлов

## Основное требование

**ВСЕГДА использовать параметры из конфигурационных файлов Android Studio при формировании команд Flutter**

## Применение правила

### Обязательно анализировать

- ✅ **Файлы `.run_*/*.run.xml`** - конфигурации запуска Android Studio
- ✅ **Параметр `additionalArgs`** - дополнительные аргументы для Flutter
- ✅ **Параметр `buildFlavor`** - flavor для сборки
- ✅ **Параметр `filePath`** - target файл для запуска
- ✅ **Файл `env.json`** - переменные окружения

### Алгоритм формирования команд

1. **Найти конфигурационный файл** - `.run_*/*.run.xml`
2. **Извлечь параметры:**
   - `additionalArgs` → добавить в команду
   - `buildFlavor` → `--flavor`
   - `filePath` → `--target`
3. **Сформировать команду Flutter** с извлеченными параметрами

## Примеры правильного использования

### ✅ Правильно - на основе конфигурации

**Конфигурация `.run_prod/main prod.run.xml`:**

```xml
<option name="additionalArgs" value="--dart-define-from-file=env.json" />
<option name="buildFlavor" value="prod" />
<option name="filePath" value="$PROJECT_DIR$/lib/main_prod.dart" />
```

**Сформированная команда:**

```bash
fvm flutter build apk --target lib/main_prod.dart --flavor prod --debug --dart-define-from-file=env.json
```

### ❌ Неправильно - без анализа конфигурации

```bash
fvm flutter build apk --flavor prod --debug  # Отсутствуют важные параметры
```

## Поддерживаемые конфигурации

- **main dev.run.xml** - dev конфигурация
- **main prod.run.xml** - production конфигурация  
- **main fitness1c.run.xml** - fitness1c конфигурация

## Автоматическое определение

**При упоминании flavor или конфигурации:**

- `prod` → использовать `.run_prod/main prod.run.xml`
- `dev` → использовать `.run_dev/main dev.run.xml`
- `fitness1c` → использовать `.run_fitness1c/main fitness1c.run.xml`

## Приоритет

**ВЫСОКИЙ ПРИОРИТЕТ** - всегда анализировать конфигурационные файлы перед формированием Flutter команд.

## Исключения

Нет исключений - конфигурационные файлы должны использоваться всегда для обеспечения корректности сборки.
