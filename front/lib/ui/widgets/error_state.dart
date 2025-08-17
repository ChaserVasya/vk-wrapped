import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:front/domain/exceptions/app_exception.dart';
import 'package:front/ui/routes/app_router.dart';
import 'package:front/ui/widgets/extensions.dart';
import 'package:gap/gap.dart';

class ErrorStateWidget extends StatelessWidget {
  const ErrorStateWidget(this.error, {super.key, this.onRefresh});

  final Object error;
  final VoidCallback? onRefresh;

  Future<void> copyToClipboard(String text, BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (!context.mounted) return;
    context.showSnackBar('Скопировано');
  }

  @override
  Widget build(BuildContext context) {
    final isNoTokenError =
        error is NoTokenException || error is VkAuthFailedException;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isNoTokenError ? Icons.vpn_key : Icons.error_outline,
              size: 64,
              color: Colors.grey,
            ),
            const Gap(16),
            Text(
              isNoTokenError ? 'Требуется авторизация' : 'Произошла ошибка',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const Gap(8),
            Text(
              isNoTokenError
                  ? 'Токен истёк/не одобрен. Перейдите в настройки и введите новый.'
                  : error.toString(),
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const Gap(16),
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
                child: const Text('Перейти в настройки'),
              ),
            ] else ...[
              if (onRefresh != null)
                ElevatedButton(
                  onPressed: () => onRefresh?.call(),
                  child: const Text('Повторить'),
                ),
              const Gap(16),
              if (error is AppException) ...[
                Builder(
                  builder: (context) {
                    final appException = error as AppException;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ExpansionTile(
                            collapsedShape: const Border(),
                            visualDensity: VisualDensity.compact,
                            title: const Text('Информация для отладки'),
                            expandedCrossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              if (appException.originalError != null)
                                Text(
                                  appException.originalError.toString(),
                                  style: const TextStyle(fontSize: 16),
                                ),
                              if (appException.st != null) ...[
                                const Gap(8),
                                const Text(
                                  'Stack Trace:',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Gap(4),
                                Text(
                                  appException.st.toString(),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'monospace',
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            copyToClipboard(appException.debugJson, context);
                          },
                          icon: const Icon(Icons.copy),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
