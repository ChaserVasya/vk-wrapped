import 'package:bloc/bloc.dart';

/// Bloc analog of [ValueNotifier]
class ValueCubit<T> extends Cubit<T> {
  ValueCubit(super.initialState);

  set value(T newValue) => emit(newValue);
  T get value => state;
}
