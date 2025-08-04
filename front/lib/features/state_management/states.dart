import 'package:flutter/material.dart';
import 'package:front/ui/widgets/loading_widget.dart';
import 'package:gap/gap.dart';

class DoNotShowState extends StatelessWidget {
  const DoNotShowState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('Should never be reached');
  }
}

class ErrorState extends StatelessWidget {
  const ErrorState(
    this.error, {
    super.key,
    this.title,
    this.onRefresh,
    this.actionTitle,
  });

  final String? title;
  final String? error;
  final VoidCallback? onRefresh;
  final String? actionTitle;

  @override
  Widget build(BuildContext context) {
    final onRefresh = this.onRefresh;
    final error = this.error;
    final message = error;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, size: 48),
          const Gap(8),
          if (message != null) ...[
            Text(message, style: const TextStyle(fontSize: 16)),
            const Gap(8),
          ],
          Text(
            title ?? 'Ошибка загрузки данных',
            style: const TextStyle(fontSize: 16),
          ),
          const Gap(8),
          if (onRefresh != null)
            TextButton(
              onPressed: onRefresh,
              child: Text(actionTitle ?? 'Повторить'),
            ),
        ],
      ),
    );
  }
}

class ErrorStateCard extends StatelessWidget {
  const ErrorStateCard(
    this.error, {
    super.key,
    this.title,
    this.onRefresh,
    this.actionTitle,
  });

  final String? title;
  final String? error;
  final VoidCallback? onRefresh;
  final String? actionTitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ErrorState(
          error,
          title: title ?? 'Ошибка загрузки данных',
          onRefresh: onRefresh,
        ),
      ),
    );
  }
}

class LoadingState extends StatelessWidget {
  const LoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoadingWidget();
  }
}

class EmptyState extends StatelessWidget {
  const EmptyState({super.key, this.text});

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.music_note, size: 48, color: Colors.grey),
          const Gap(8),
          Text(
            text ?? 'Нет данных',
            style: const TextStyle(fontSize: 16, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
