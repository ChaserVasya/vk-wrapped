import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';

/// Replaces combination of BlocProvider(child:BlocListener(...)) where
/// BlocListener updates [TargetBloc] with new [SourceBloc] state.
class ProxyBlocProvider<
  SourceBloc extends StateStreamableSource<S>,
  S,
  T,
  TargetBloc extends StateStreamableSource
>
    extends SingleChildStatelessWidget {
  const ProxyBlocProvider({
    super.key,
    this.child,
    required this.valueSelector,
    required this.create,
    required this.updateTargetBloc,
    required this.readSource,
  });

  final SourceBloc Function(BuildContext context) readSource;
  final T Function(S bloc) valueSelector;
  final TargetBloc Function(T value) create;
  final Widget? child;
  final void Function(TargetBloc bloc, T value) updateTargetBloc;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return BlocProvider<TargetBloc>(
      create: (context) => create(valueSelector(readSource(context).state)),
      child: BlocListener<SourceBloc, S>(
        listenWhen: (p, c) => valueSelector(p) != valueSelector(c),
        listener: (context, state) {
          final selectedValue = valueSelector(state);
          final targetBloc = context.read<TargetBloc>();
          updateTargetBloc(targetBloc, selectedValue);
        },
        child: this.child ?? child!,
      ),
    );
  }
}
