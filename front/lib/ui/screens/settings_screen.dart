import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/features/utils/bloc/safe_bloc.dart';
import 'package:front/features/utils/bloc/safe_listeners.dart';
import 'package:front/internal/di/di.dart';
import 'package:front/ui/blocs/settings_bloc/settings_bloc.dart';
import 'package:front/ui/screens/token_setup_screen.dart';
import 'package:front/ui/widgets/loading_widget.dart';
import 'package:gap/gap.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _Providers(child: _Listeners(child: _View()));
  }
}

class _Providers extends StatelessWidget {
  const _Providers({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<SettingsBloc>()..add(const SettingsEvent.loadCurrentData()),
      child: child,
    );
  }
}

class _Listeners extends StatelessWidget {
  const _Listeners({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        ShowErrorSafeListener<SettingsBloc>(),
        EffectListener<SettingsBloc, SettingsEffect>(
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

              case SettingsEffect$Error(message: final message):
                _showSnackBar(context, 'Ошибка: $message');
            }
          },
        ),
      ],
      child: child,
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}

class _View extends StatefulWidget {
  const _View();

  @override
  State<_View> createState() => _ViewState();
}

class _ViewState extends State<_View> {
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
              const Gap(8),
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
            Gap(8),
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
            Gap(8),
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
            const Gap(8),
            Text('Client ID: $clientId', style: const TextStyle(fontSize: 12)),
            if (hasToken && currentToken != null) ...[
              const Gap(4),
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
            Gap(8),
            Text('Загрузка данных...'),
          ],
        );
      default:
        return const Text('Данные не загружены');
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        const Gap(8),
                        _buildTokenStatus(state),
                        const Gap(8),
                        _buildCurrentData(state),
                        const Gap(16),
                        Row(
                          children: [
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
                        const Gap(8),
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
                const Gap(16),

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
                        const Gap(8),
                        const Text(
                          'Кэшированные данные включают:',
                          style: TextStyle(fontSize: 14),
                        ),
                        const Gap(4),
                        Text(
                          '• Список треков',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          '• Статистика прослушивания',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          '• Информация об артистах',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const Gap(8),
                        _buildCacheStatus(state),
                        const Gap(16),
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
                const Gap(16),

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
                        const Gap(8),
                        const Text(
                          'Экспортируйте ваши данные в JSON файл для анализа или резервного копирования.',
                          style: TextStyle(fontSize: 14),
                        ),
                        const Gap(8),

                        const Gap(16),
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
    );
  }
}
