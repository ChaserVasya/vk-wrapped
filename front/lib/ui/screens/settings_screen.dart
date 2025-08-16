import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/features/state_management/common_states.dart';
import 'package:front/features/utils/bloc/safe_bloc.dart';
import 'package:front/internal/di/di.dart';
import 'package:front/ui/blocs/settings_bloc/settings_bloc.dart';
import 'package:front/ui/routes/app_router.dart';
import 'package:front/ui/widgets/extensions.dart';
import 'package:front/ui/widgets/loading_widget.dart';
import 'package:front/ui/widgets/safe_listeners.dart';
import 'package:gap/gap.dart';

@RoutePage()
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
                context.showSnackBar('Токен удален');
              case SettingsEffect$TokenSaved():
                context.showSnackBar('Токен сохранен!');
              case SettingsEffect$CacheCleared():
                context.showSnackBar('Кэш очищен');
              case SettingsEffect$DataExported():
                context.showSnackBar('Данные экспортированы');
              case SettingsEffect$NoDataToExport():
                context.showSnackBar(
                  'Нет данных для экспорта. Сначала загрузите музыку.',
                );
            }
          },
        ),
      ],
      child: child,
    );
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
      case CommonStateData(data: final data):
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data.hasToken ? '✅ Токен настроен' : '❌ Токен не настроен',
              style: TextStyle(
                color: data.hasToken ? Colors.green : Colors.red,
              ),
            ),
            if (data.hasToken) ...[
              const Gap(8),
              const Text(
                'Токен сохранен в приложении',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ],
        );
      case CommonStateLoading():
        return const Row(
          children: [
            SizedBox(width: 16, height: 16, child: LoadingWidget()),
            Gap(8),
            Text('Загрузка...'),
          ],
        );
      case CommonStateError():
        return const Text('Ошибка загрузки статуса токена');
    }
  }

  Widget _buildCacheStatus(SettingsState state) {
    switch (state) {
      case CommonStateData(data: final data):
        return Text(
          data.isCacheCleared ? '✅ Кэш очищен' : '📦 Кэш содержит данные',
          style: TextStyle(
            color: data.isCacheCleared ? Colors.green : Colors.blue,
          ),
        );
      case CommonStateLoading():
        return const Row(
          children: [
            SizedBox(width: 16, height: 16, child: LoadingWidget()),
            Gap(8),
            Text('Загрузка...'),
          ],
        );
      case CommonStateError():
        return const Text('Ошибка загрузки статуса кэша');
    }
  }

  Widget _buildCurrentData(SettingsState state) {
    switch (state) {
      case CommonStateData(data: final data):
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Текущие настройки:',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const Gap(8),
            Text(
              'Client ID: ${data.clientId}',
              style: const TextStyle(fontSize: 12),
            ),
            if (data.hasToken && data.currentToken != null) ...[
              const Gap(4),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Токен: ${data.currentToken}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Clipboard.setData(
                        ClipboardData(text: data.currentToken!),
                      );
                      context.showSnackBar('Токен скопирован');
                    },
                    icon: const Icon(Icons.copy, size: 16),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const Gap(8),
              Builder(
                builder: (context) {
                  final expiresAt = data.tokenExpiresAt;
                  final now = DateTime.now();
                  if (expiresAt == null) {
                    return const Text(
                      'Срок действия: бессрочный (expires_in=0)',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    );
                  }
                  final isExpired = expiresAt.isBefore(now);
                  final left = expiresAt.difference(now);
                  final leftText = left.isNegative
                      ? 'Истёк'
                      : 'Осталось примерно: ${left.inHours} ч ${left.inMinutes.remainder(60)} мин';
                  return Row(
                    children: [
                      Icon(
                        isExpired ? Icons.warning_amber : Icons.schedule,
                        size: 16,
                        color: isExpired ? Colors.red : Colors.grey,
                      ),
                      const Gap(6),
                      Expanded(
                        child: Text(
                          isExpired
                              ? 'Токен истёк.'
                              : 'Истекает: ${expiresAt.toLocal()} ($leftText)',
                          style: TextStyle(
                            fontSize: 12,
                            color: isExpired ? Colors.red : Colors.grey,
                          ),
                        ),
                      ),
                      if (isExpired) ...[
                        const Gap(8),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () async {
                            await context.router.push(const TokenSetupRoute());
                            if (!context.mounted) return;
                            context.read<SettingsBloc>().add(
                              const SettingsEvent.loadCurrentData(),
                            );
                          },
                          child: const Text('Обновить токен'),
                        ),
                      ],
                    ],
                  );
                },
              ),
            ],
          ],
        );
      case CommonStateLoading():
        return const Row(
          children: [
            SizedBox(width: 16, height: 16, child: LoadingWidget()),
            Gap(8),
            Text('Загрузка данных...'),
          ],
        );
      case CommonStateError():
        return const Text('Ошибка загрузки данных');
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
            onPressed: () => context.router.pop(),
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<SettingsBloc>().add(
                const SettingsEvent.clearCache(),
              );
              context.router.pop();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Очистить'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final defaults = ElevatedButtonTheme.of(context);
    final primary = ColorScheme.of(context).onPrimary;
    return Scaffold(
      appBar: AppBar(title: const Text('Настройки')),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButtonTheme(
              data: ElevatedButtonThemeData(
                style: defaults.style?.merge(
                  ElevatedButton.styleFrom(foregroundColor: primary),
                ),
              ),
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
                                  onPressed: state is CommonStateLoading
                                      ? null
                                      : () {
                                          context.read<SettingsBloc>().add(
                                            const SettingsEvent.clearToken(),
                                          );
                                        },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
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
                              onPressed: state is CommonStateLoading
                                  ? null
                                  : () async {
                                      await context.router.push(
                                        const TokenSetupRoute(),
                                      );
                                      context.read<SettingsBloc>().add(
                                        const SettingsEvent.loadCurrentData(),
                                      );
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
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
                              onPressed: state is CommonStateLoading
                                  ? null
                                  : () {
                                      _showCacheClearDialog(context);
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
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
                              onPressed: state is CommonStateLoading
                                  ? null
                                  : () {
                                      context.read<SettingsBloc>().add(
                                        const SettingsEvent.exportData(),
                                      );
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
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
            ),
          );
        },
      ),
    );
  }
}
