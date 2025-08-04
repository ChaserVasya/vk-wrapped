import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:project_utils/src/exception/app_exception.dart';

// mixin can`t override other mixins, so, I apply some boilerplate

/// Handlers emit on error
abstract class InterceptedBloc<Event, State> extends Bloc<Event, State> {
  InterceptedBloc(super.initialState);

  @override
  void on<E extends Event>(handler, {transformer}) {
    return super.on(
      (event, emit) => interceptor(() => handler(event, emit), emit),
      transformer: transformer,
    );
  }

  FutureOr<void> interceptor(
    FutureOr Function() handler,
    Emitter<State> emit,
  );
}

mixin HandlerEmitOnError<Event, State> on InterceptedBloc<Event, State> {
  @override
  interceptor(handler, emit) async {
    try {
      await handler();
    } catch (e, st) {
      final exc = AppException.fromDynamic(e, st: st);
      emit(createErrorState(exc));
      rethrow;
    }
  }

  State createErrorState(AppException? e);
}

/// Handlers rollback on error to state before the handler
mixin HandlerAtomic<Event, State> on InterceptedBloc<Event, State> {
  @override
  interceptor(handler, emit) async {
    await asFunction(this, emit, state, handler);
  }

  static Future<void> asFunction<E, S>(
    Bloc<E, S> bloc,
    Emitter<S> emit,
    S oldState,
    FutureOr Function() handler,
  ) async {
    try {
      await handler();
    } catch (e) {
      emit(oldState);
      rethrow;
    }
  }
}
