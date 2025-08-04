import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/features/utils/bloc/safe_bloc.dart';
import 'package:front/internal/di/di.dart';
import 'package:front/ui/blocs/home_bloc/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeBloc>(),
      child: EffectListener<HomeBloc, HomeEffect>(
        listener: (context, effect) {
          switch (effect) {
            case HomeEffect$TokenSaved():
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Токен сохранен!')));
            case HomeEffect$TokenError(message: final message):
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Ошибка: $message')));
            case HomeEffect$ShowTokenDialog():
              _showTokenDialog(context);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('VK Wrapped'),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  Navigator.of(context).pushNamed('/settings');
                },
              ),
            ],
          ),
          body: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.music_note, size: 64),
                    const SizedBox(height: 16),
                    const Text(
                      'Добро пожаловать в VK Wrapped!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Анализируем вашу музыкальную историю',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/statistics');
                      },
                      icon: const Icon(Icons.analytics),
                      label: const Text('Посмотреть статистику'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/detailed-statistics');
                      },
                      icon: const Icon(Icons.bar_chart),
                      label: const Text('Детальная статистика'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/settings');
                      },
                      icon: const Icon(Icons.vpn_key),
                      label: const Text('Настроить VK токен'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
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

  void _showTokenDialog(BuildContext context) {
    final tokenController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('VK Токен'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Для работы приложения необходим VK Personal Token.'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                // TODO: Добавить url_launcher
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Откройте ссылку в браузере')),
                );
              },
              child: const Text('Получить токен'),
            ),
            const SizedBox(height: 16),
            const Text('После получения токена вставьте его в поле ниже:'),
            const SizedBox(height: 8),
            TextField(
              controller: tokenController,
              decoration: const InputDecoration(
                labelText: 'VK Personal Token',
                hintText: 'Вставьте токен сюда',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (token) {
                context.read<HomeBloc>().add(HomeEvent.saveToken(token));
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Закрыть'),
          ),
        ],
      ),
    );
  }
}
