import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:front/domain/exceptions/app_exception.dart';
import 'package:front/ui/routes/app_router.dart';
import 'package:front/ui/widgets/network_debug_info_tile.dart';
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
                  : error.constructMessageInUI(context, error),
              style: const TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),

            const Gap(24),
            if (isNoTokenError) ...[
              ElevatedButton.icon(
                onPressed: () async {
                  // Переходим в настройки
                  await context.router.push(const SettingsRoute());
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
            // Добавляем дебаг информацию для всех ошибок
            if (!isNoTokenError) ...[
              const Gap(16),
              NetworkDebugInfoTile(error: error),
            ],
          ],
        ),
      ),
    );
  }
}
