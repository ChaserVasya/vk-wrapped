import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:front/domain/exceptions/app_exception.dart';
import 'package:front/ui/routes/app_router.dart';

class ErrorStateWidget extends StatelessWidget {
  const ErrorStateWidget(this.error, {super.key, this.onRefresh});

  final Object error;
  final VoidCallback? onRefresh;

  @override
  Widget build(BuildContext context) {
    // Проверяем, является ли ошибка NoTokenException
    final isNoTokenError = error is NoTokenException;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isNoTokenError ? Icons.vpn_key : Icons.error_outline,
            size: 64,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            isNoTokenError ? 'Требуется авторизация' : 'Произошла ошибка',
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            isNoTokenError
                ? 'Для получения данных необходимо войти в VK'
                : error.toString(),
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          if (isNoTokenError) ...[
            ElevatedButton(
              onPressed: () async {
                // Переходим в настройки
                await context.router.push(const SettingsRoute());
                // После возвращения делаем ещё одну попытку
                if (context.mounted && onRefresh != null) {
                  onRefresh!();
                }
              },
              child: const Text('Настроить токен'),
            ),
          ] else if (onRefresh != null) ...[
            ElevatedButton(
              onPressed: onRefresh,
              child: const Text('Повторить'),
            ),
          ],
        ],
      ),
    );
  }
}
