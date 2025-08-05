import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/features/state_management/common_states.dart';
import 'package:front/ui/widgets/error_state.dart';
import 'package:front/ui/widgets/loading_state.dart';

typedef DataBuilder<D> = Widget Function(BuildContext context, D data);

class CommonStateHandler<S extends CommonStates<D>, D> extends StatelessWidget {
  const CommonStateHandler({
    super.key,
    required this.dataBuilder,
    required this.selector,
    this.errorTitle,
    required this.onRefreshRequested,
    this.title,
  });

  final S Function(BuildContext context) selector;
  final DataBuilder<D> dataBuilder;
  final String? errorTitle;
  final VoidCallback onRefreshRequested;

  /// {@template section.title}
  /// Same as [Section.title], but for all states. Don't use with [Section.title]
  /// {@endtemplate}
  final Widget? title;

  @override
  Widget build(BuildContext context) {
    final title = this.title;
    final state = selector(context);
    Widget widget;
    switch (state) {
      case CommonStateData<D>(data: final data):
        widget = Builder(builder: (context) => dataBuilder(context, data));
      case CommonStateError(e: final error):
        widget = ErrorStateWidget(error, onRefresh: onRefreshRequested);
      case CommonStateLoading<D>():
        widget = const LoadingStateWidget();
    }
    if (title != null) {
      widget = _wrapWithTitle(title, widget);
    }
    return widget;
  }

  Widget _wrapWithTitle(Widget title, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [title, const SizedBox(height: 16), child],
    );
  }
}

class CubitStateHandler<T extends Cubit<S>, S extends CommonStates<D>, D>
    extends StatelessWidget {
  const CubitStateHandler({
    super.key,
    required this.dataBuilder,
    this.errorTitle,
    this.title,
    this.onRefreshRequested,
  });

  final Widget Function(BuildContext context, D data) dataBuilder;
  final String? errorTitle;
  final Widget? title;
  final VoidCallback? onRefreshRequested;

  @override
  Widget build(BuildContext context) {
    return CommonStateHandler<S, D>(
      title: title,
      dataBuilder: dataBuilder,
      errorTitle: errorTitle,
      selector: (context) => context.watch<T>().state,
      onRefreshRequested: onRefreshRequested ?? () {},
    );
  }
}
