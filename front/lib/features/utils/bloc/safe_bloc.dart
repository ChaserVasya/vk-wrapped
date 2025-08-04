import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/widgets.dart';
import 'package:front/domain/exceptions/app_exception.dart';

export 'package:bloc_presentation/bloc_presentation.dart'
    show BlocPresentationWidgetListener;

typedef EffectBase = Object;

/// Mix of bloc_effect, safe_bloc, bloc_presentation concepts to provide
/// bloc -> presentation additional imperative states
/// named effects (defaults are declarative).
///
/// On any unhandled error it undo state and emits side effect error.
abstract class SafeBloc<E, S> extends Bloc<E, S>
    with
        BlocPresentationMixin<S, EffectBase>,
        EffectEmitterMixin,
        ErrorEmitterMixin {
  SafeBloc(super.initialState);
}

/// Class for cases when state undoing on error of [SafeBloc] is undesired
abstract class EffectBloc<E, S> extends Bloc<E, S>
    with
        BlocPresentationMixin<S, EffectBase>,
        EffectEmitterMixin,
        ErrorEmitterMixin {
  EffectBloc(super.initialState);
}

mixin EffectEmitterMixin<S>
    on BlocBase<S>, BlocPresentationMixin<S, EffectBase> {
  @protected
  void emitEffect<E extends EffectBase>(E effect) {
    emitPresentation(effect);
  }
}

mixin ErrorEmitterMixin<S> on BlocBase<S>, EffectEmitterMixin<S> {
  @override
  void onError(Object error, StackTrace stackTrace) {
    emitErrorEffect(error, st: stackTrace);
    super.onError(error, stackTrace);
  }

  @protected
  void emitErrorEffect(Object error, {StackTrace? st}) {
    emitPresentation(AppException(error.toString(), originalError: error));
  }
}

typedef EffectWidgetListener<P> = void Function(BuildContext context, P effect);

class EffectListener<B extends EffectEmitterMixin, E extends EffectBase>
    extends BlocPresentationListener<B, EffectBase> {
  EffectListener({
    super.key,
    super.bloc,
    super.child,
    required EffectWidgetListener<E> listener,
  }) : super(
         listener: (context, effect) {
           if (effect is! E) return;
           listener(context, effect);
         },
       );
}

/// Class for cases when state undoing on error of [SafeBloc] is undesired
abstract class EffectCubit<S> extends Cubit<S>
    with
        BlocPresentationMixin<S, EffectBase>,
        EffectEmitterMixin,
        ErrorEmitterMixin {
  EffectCubit(super.initialState);
}
