import 'package:flutter/material.dart';
import 'package:front/domain/exceptions/app_exception.dart';
import 'package:gap/gap.dart';

class ErrorStateWidget extends StatelessWidget {
  final AppException error;
  final VoidCallback? onRefresh;

  const ErrorStateWidget(this.error, {super.key, this.onRefresh});

  @override
  Widget build(BuildContext context) {
    // Проверяем, является ли ошибка NoTokenException
    final isNoTokenError =
        error.toString().toLowerCase().contains('token') ||
        error.toString().toLowerCase().contains('токен');

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isNoTokenError ? Icons.vpn_key : Icons.error,
              size: 64,
              color: isNoTokenError ? Colors.orange : Colors.red,
            ),
            const Gap(16),
            Text(
              isNoTokenError ? 'Токен не настроен' : 'Ошибка загрузки',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const Gap(8),
            Text(
              isNoTokenError
                  ? 'Для просмотра треков необходимо настроить VK токен'
                  : error.toString(),
              style: const TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const Gap(24),
            if (isNoTokenError) ...[
              ElevatedButton.icon(
                onPressed: () async {
                  // Переходим в настройки
                  await Navigator.of(context).pushNamed('/settings');
                  // После возвращения делаем ещё одну попытку
                  if (context.mounted && onRefresh != null) {
                    onRefresh!();
                  }
                },
                icon: const Icon(Icons.settings),
                label: const Text('Настроить токен'),
              ),
            ] else ...[
              ElevatedButton.icon(
                onPressed: onRefresh,
                icon: const Icon(Icons.refresh),
                label: const Text('Повторить'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
