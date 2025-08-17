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
