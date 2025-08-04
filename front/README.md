# Front

Эта папка содержит Dart скрипты для работы с VK API и базой данных.

## Архитектура

### Lib классы (для использования в приложении)

- **`lib/token_generator.dart`** - `TokenGenerator.generateTokenUrl()` - генерирует URL для получения VK токена
- **`lib/vk_api_client.dart`** - `VkApiClient(token)` - клиент для работы с VK API
- **`lib/database_client.dart`** - `DatabaseClient.getDatabaseData()` - получает данные из YDB

### Bin скрипты (для тестирования)

- **`bin/token_generator.dart`** - тестирует генерацию токена
- **`bin/database_client.dart`** - тестирует получение данных из базы
- **`bin/vk_audio_client.dart`** - тестирует работу с VK API

## Использование в приложении

```dart
import 'package:front/lib/token_generator.dart';
import 'package:front/lib/vk_api_client.dart';
import 'package:front/lib/track_sessions_client.dart';

// Генерация токена
final tokenUrl = TokenGenerator.generateTokenUrl();

// Работа с VK API
final client = VkApiClient('your_token');
final audio = await client.getSingleAudioById('123456_789012');

// Работа с базой данных
final data = await DatabaseClient.getDatabaseData();
```

## Тестирование

### Token Generator
```bash
fvm dart run bin/token_generator.dart
```
Генерирует ссылку для получения VK Personal Token.

### Database Client
```bash
fvm dart run bin/track_sessions_client.dart
```
Получает данные из Yandex Database через TypeScript скрипт.

**Требования:**
- Node.js и npm установлены
- Папка `../yandex-cloud/functions` с `package.json`
- Валидный `YDB_TOKEN` в `../yandex-cloud/functions/.local.env`

### VK Audio Client
```bash
fvm dart run bin/vk_audio_client.dart
```
Тестирует работу с VK API для получения информации об аудио.

**Для использования:**
1. Получите токен через `fvm dart run bin/token_generator.dart`
2. Откройте ссылку в браузере и авторизуйтесь
3. Скопируйте токен из URL (после `access_token=` и до `&`)
4. Замените `your_user_token_here` в `bin/vk_audio_client.dart` на ваш токен

## Автономность

Все bin скрипты автономны и не зависят от других частей проекта:
- ✅ Не читают внешние файлы конфигурации
- ✅ Содержат инструкции по настройке
- ✅ Показывают понятные ошибки
- ✅ Могут работать независимо

## Получение VK токена

1. Запустите генератор токенов:
   ```bash
   fvm dart run bin/token_generator.dart
   ```

2. Перейдите по ссылке и авторизуйтесь в VK

3. Скопируйте токен из адресной строки браузера (после `access_token=` и до `&`)

4. Используйте токен в коде приложения

## Архитектура

- **Lib классы** - для использования в основном приложении
- **Bin скрипты** - для тестирования функциональности
- **Автономность** - скрипты не зависят от других частей проекта
- **TypeScript** - для работы с YDB (использует официальный SDK)
- **Dart** - для клиентской части и отображения данных
- **JSON** - для обмена данными между TypeScript и Dart
- **VK API** - для получения информации об аудио треках 
