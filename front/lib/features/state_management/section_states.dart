import 'package:flutter/material.dart';
import 'package:front/features/state_management/states.dart';

class SectionEmptyState extends StatelessWidget {
  const SectionEmptyState({super.key, this.text});

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: EmptyState(text: text),
      ),
    );
  }
}

class SectionDoNotShowStub extends StatelessWidget {
  const SectionDoNotShowStub({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: DoNotShowState(),
      ),
    );
  }
}

class SectionErrorState extends StatelessWidget {
  const SectionErrorState({
    super.key,
    this.title,
    required this.onRefresh,
    this.error,
  });

  final String? error;
  final String? title;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ErrorState(error, title: title, onRefresh: onRefresh),
      ),
    );
  }
}

class SectionLoadingState extends StatelessWidget {
  const SectionLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(padding: EdgeInsets.all(16), child: LoadingState()),
    );
  }
}
