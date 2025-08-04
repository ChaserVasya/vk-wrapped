import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/features/utils/bloc/safe_bloc.dart';
import 'package:front/internal/di/di.dart';
import 'package:front/ui/blocs/settings_bloc/settings_bloc.dart';
import 'package:front/ui/widgets/loading_widget.dart';
import 'package:front/ui/screens/token_setup_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _tokenController = TextEditingController();

  @override
  void dispose() {
    _tokenController.dispose();
    super.dispose();
  }

  Widget _buildTokenStatus(SettingsState state) {
    switch (state) {
      case SettingsState$TokenConfigured(hasToken: final hasToken):
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              hasToken ? '✅ Токен настроен' : '❌ Токен не настроен',
              style: TextStyle(color: hasToken ? Colors.green : Colors.red),
            ),
            if (hasToken) ...[
              const SizedBox(height: 8),
              const Text(
                'Токен сохранен в приложении',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ],
        );
      case SettingsState$Loading():
        return const Row(
          children: [
            SizedBox(width: 16, height: 16, child: LoadingWidget()),
            SizedBox(width: 8),
            Text('Проверка токена...'),
          ],
        );
      default:
        return const Text('Статус токена неизвестен');
    }
  }

  Widget _buildCacheStatus(SettingsState state) {
    switch (state) {
      case SettingsState$CacheStatus(isCleared: final isCleared):
        return Text(
          isCleared ? '✅ Кэш очищен' : '📦 Кэш содержит данные',
          style: TextStyle(color: isCleared ? Colors.green : Colors.blue),
        );
      case SettingsState$Loading():
        return const Row(
          children: [
            SizedBox(width: 16, height: 16, child: LoadingWidget()),
            SizedBox(width: 8),
            Text('Очистка кэша...'),
          ],
        );
      default:
        return const Text('Статус кэша неизвестен');
    }
  }

  Widget _buildCurrentData(SettingsState state) {
    switch (state) {
      case SettingsState$CurrentData(
        hasToken: final hasToken,
        currentToken: final currentToken,
        clientId: final clientId,
      ):
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Текущие настройки:',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Client ID: $clientId', style: const TextStyle(fontSize: 12)),
            if (hasToken && currentToken != null) ...[
              const SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Токен: $currentToken',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: currentToken));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Токен скопирован')),
                      );
                    },
                    icon: const Icon(Icons.copy, size: 16),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ],
          ],
        );
      case SettingsState$Loading():
        return const Row(
          children: [
            SizedBox(width: 16, height: 16, child: LoadingWidget()),
            SizedBox(width: 8),
            Text('Загрузка данных...'),
          ],
        );
      default:
        return const Text('Данные не загружены');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = getIt<SettingsBloc>();
        // Загружаем текущие данные при создании экрана
        bloc.add(const SettingsEvent.loadCurrentData());
        return bloc;
      },
      child: EffectListener<SettingsBloc, SettingsEffect>(
        listener: (context, effect) {
          switch (effect) {
            case SettingsEffect$TokenCleared():
              _showSnackBar(context, 'Токен удален');
            case SettingsEffect$TokenSaved():
              _showSnackBar(context, 'Токен сохранен!');
            case SettingsEffect$CacheCleared():
              _showSnackBar(context, 'Кэш очищен');
            case SettingsEffect$DataExported():
              _showSnackBar(context, 'Данные экспортированы');
            case SettingsEffect$NoDataToExport():
              _showSnackBar(
                context,
                'Нет данных для экспорта. Сначала загрузите музыку.',
              );
            case SettingsEffect$ShowTokenDialog(hasToken: final hasToken):
              _showTokenDialog(context, hasToken);
            case SettingsEffect$Error(message: final message):
              _showSnackBar(context, 'Ошибка: $message');
          }
        },
        child: Scaffold(
          appBar: AppBar(title: const Text('Настройки')),
          body: BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, state) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Секция токена
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'VK API Токен',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            _buildTokenStatus(state),
                            const SizedBox(height: 8),
                            _buildCurrentData(state),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: state is SettingsState$Loading
                                        ? null
                                        : () {
                                            context.read<SettingsBloc>().add(
                                              const SettingsEvent.checkTokenStatus(),
                                            );
                                          },
                                    child: const Text('Проверить статус'),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: state is SettingsState$Loading
                                        ? null
                                        : () {
                                            context.read<SettingsBloc>().add(
                                              const SettingsEvent.clearToken(),
                                            );
                                          },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                    ),
                                    child: const Text('Очистить'),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: state is SettingsState$Loading
                                    ? null
                                    : () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const TokenSetupScreen(),
                                          ),
                                        );
                                      },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white,
                                ),
                                child: const Text('Настроить токен'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Секция кэша
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Кэш данных',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Кэшированные данные включают:',
                              style: TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              '• Список треков',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            const Text(
                              '• Статистика прослушивания',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            const Text(
                              '• Информация об артистах',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 8),
                            _buildCacheStatus(state),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: state is SettingsState$Loading
                                    ? null
                                    : () {
                                        _showCacheClearDialog(context);
                                      },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                  foregroundColor: Colors.white,
                                ),
                                child: const Text('Очистить кэш'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Секция экспорта
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Экспорт данных',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Экспортируйте ваши данные в JSON файл для анализа или резервного копирования.',
                              style: TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Экспортируемые данные:',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              '• Список треков',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            const Text(
                              '• Статистика прослушивания',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            const Text(
                              '• Информация об артистах',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: state is SettingsState$Loading
                                    ? null
                                    : () {
                                        context.read<SettingsBloc>().add(
                                          const SettingsEvent.exportData(),
                                        );
                                      },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white,
                                ),
                                child: const Text('Экспортировать данные'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _showTokenDialog(BuildContext context, bool hasToken) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(hasToken ? 'Токен найден' : 'Токен не найден'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!hasToken) ...[
              const Text('Введите токен VK API:'),
              const SizedBox(height: 8),
              TextField(
                controller: _tokenController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Токен',
                ),
              ),
            ] else ...[
              const Text('Токен уже сохранен.'),
              const SizedBox(height: 8),
              const Text('Хотите заменить его?'),
              const SizedBox(height: 8),
              TextField(
                controller: _tokenController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Новый токен',
                ),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              if (_tokenController.text.isNotEmpty) {
                context.read<SettingsBloc>().add(
                  SettingsEvent.saveToken(_tokenController.text),
                );
                _tokenController.clear();
              }
              Navigator.of(context).pop();
            },
            child: const Text('Сохранить'),
          ),
        ],
      ),
    );
  }

  void _showCacheClearDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Очистить кэш'),
        content: const Text(
          'Вы уверены, что хотите очистить кэш? Это удалит все сохраненные данные и потребует повторной загрузки.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<SettingsBloc>().add(
                const SettingsEvent.clearCache(),
              );
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Очистить'),
          ),
        ],
      ),
    );
  }
}
