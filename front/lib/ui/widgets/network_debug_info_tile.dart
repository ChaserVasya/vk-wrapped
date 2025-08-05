import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:front/domain/exceptions/app_exception.dart';
import 'package:front/ui/widgets/extensions.dart';
import 'package:gap/gap.dart';

class NetworkDebugInfoTile extends StatelessWidget {
  const NetworkDebugInfoTile({required this.error, super.key});

  final AppException error;

  Future<void> copyToClipboard(String text, BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (!context.mounted) return;
    context.showSnackBar('Скопировано');
  }

  @override
  Widget build(BuildContext context) {
    var error = this.error;

    String? dioMessage;

    if (error is NetworkException) {
      dioMessage = error.dioMessage;
      if (dioMessage?.isEmpty == true) {
        dioMessage = null;
      }
      error = AppException.fromDynamic(error.originalError, st: error.st);
    }

    final networkDebugInfo = error is NetworkException
        ? error.networkDebugInfo
        : null;
    final statusCode = networkDebugInfo?.statusCode;
    final method = networkDebugInfo?.method;
    final source = networkDebugInfo?.source;
    final query = networkDebugInfo?.query;
    final data = networkDebugInfo?.data;
    final st = error.st;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ExpansionTile(
            collapsedShape: const Border(),
            visualDensity: VisualDensity.compact,
            title: const Text('Информация для отладки'),
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (dioMessage != null)
                Text(dioMessage, style: const TextStyle(fontSize: 16)),
              if (statusCode != null)
                Text(
                  'Status Code: $statusCode',
                  style: const TextStyle(fontSize: 16),
                ),
              if (source != null && method != null)
                Text('$method $source', style: const TextStyle(fontSize: 16)),
              if (query != null)
                Text('Query: $query', style: const TextStyle(fontSize: 16)),
              if (data != null)
                Text('Body: $data', style: const TextStyle(fontSize: 16)),
              if (st != null) ...[
                const Gap(8),
                const Text(
                  'Stack Trace:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Gap(4),
                Text(
                  st.toString(),
                  style: const TextStyle(fontSize: 12, fontFamily: 'monospace'),
                ),
              ],
            ],
          ),
        ),
        IconButton(
          onPressed: () {
            copyToClipboard(error.debugJson, context);
          },
          icon: const Icon(Icons.copy),
        ),
      ],
    );
  }
}
