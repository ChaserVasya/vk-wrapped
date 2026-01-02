// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../common_states.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CommonStates<T> {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is CommonStates<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'CommonStates<$T>()';
  }
}

/// @nodoc
class $CommonStatesCopyWith<T, $Res> {
  $CommonStatesCopyWith(CommonStates<T> _, $Res Function(CommonStates<T>) __);
}

/// Adds pattern-matching-related methods to [CommonStates].
extension CommonStatesPatterns<T> on CommonStates<T> {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CommonStateData<T> value)? data,
    TResult Function(CommonStateError<T> value)? error,
    TResult Function(CommonStateLoading<T> value)? loading,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case CommonStateData() when data != null:
        return data(_that);
      case CommonStateError() when error != null:
        return error(_that);
      case CommonStateLoading() when loading != null:
        return loading(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CommonStateData<T> value) data,
    required TResult Function(CommonStateError<T> value) error,
    required TResult Function(CommonStateLoading<T> value) loading,
  }) {
    final _that = this;
    switch (_that) {
      case CommonStateData():
        return data(_that);
      case CommonStateError():
        return error(_that);
      case CommonStateLoading():
        return loading(_that);
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CommonStateData<T> value)? data,
    TResult? Function(CommonStateError<T> value)? error,
    TResult? Function(CommonStateLoading<T> value)? loading,
  }) {
    final _that = this;
    switch (_that) {
      case CommonStateData() when data != null:
        return data(_that);
      case CommonStateError() when error != null:
        return error(_that);
      case CommonStateLoading() when loading != null:
        return loading(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? data,
    TResult Function(AppException e)? error,
    TResult Function()? loading,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case CommonStateData() when data != null:
        return data(_that.data);
      case CommonStateError() when error != null:
        return error(_that.e);
      case CommonStateLoading() when loading != null:
        return loading();
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data) data,
    required TResult Function(AppException e) error,
    required TResult Function() loading,
  }) {
    final _that = this;
    switch (_that) {
      case CommonStateData():
        return data(_that.data);
      case CommonStateError():
        return error(_that.e);
      case CommonStateLoading():
        return loading();
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T data)? data,
    TResult? Function(AppException e)? error,
    TResult? Function()? loading,
  }) {
    final _that = this;
    switch (_that) {
      case CommonStateData() when data != null:
        return data(_that.data);
      case CommonStateError() when error != null:
        return error(_that.e);
      case CommonStateLoading() when loading != null:
        return loading();
      case _:
        return null;
    }
  }
}

/// @nodoc

class CommonStateData<T> extends CommonStates<T> {
  const CommonStateData(this.data) : super._();

  final T data;

  /// Create a copy of CommonStates
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CommonStateDataCopyWith<T, CommonStateData<T>> get copyWith =>
      _$CommonStateDataCopyWithImpl<T, CommonStateData<T>>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CommonStateData<T> &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  @override
  String toString() {
    return 'CommonStates<$T>.data(data: $data)';
  }
}

/// @nodoc
abstract mixin class $CommonStateDataCopyWith<T, $Res>
    implements $CommonStatesCopyWith<T, $Res> {
  factory $CommonStateDataCopyWith(
    CommonStateData<T> value,
    $Res Function(CommonStateData<T>) _then,
  ) = _$CommonStateDataCopyWithImpl;
  @useResult
  $Res call({T data});
}

/// @nodoc
class _$CommonStateDataCopyWithImpl<T, $Res>
    implements $CommonStateDataCopyWith<T, $Res> {
  _$CommonStateDataCopyWithImpl(this._self, this._then);

  final CommonStateData<T> _self;
  final $Res Function(CommonStateData<T>) _then;

  /// Create a copy of CommonStates
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? data = freezed}) {
    return _then(
      CommonStateData<T>(
        freezed == data
            ? _self.data
            : data // ignore: cast_nullable_to_non_nullable
                  as T,
      ),
    );
  }
}

/// @nodoc

class CommonStateError<T> extends CommonStates<T> {
  const CommonStateError(this.e) : super._();

  final AppException e;

  /// Create a copy of CommonStates
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CommonStateErrorCopyWith<T, CommonStateError<T>> get copyWith =>
      _$CommonStateErrorCopyWithImpl<T, CommonStateError<T>>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CommonStateError<T> &&
            (identical(other.e, e) || other.e == e));
  }

  @override
  int get hashCode => Object.hash(runtimeType, e);

  @override
  String toString() {
    return 'CommonStates<$T>.error(e: $e)';
  }
}

/// @nodoc
abstract mixin class $CommonStateErrorCopyWith<T, $Res>
    implements $CommonStatesCopyWith<T, $Res> {
  factory $CommonStateErrorCopyWith(
    CommonStateError<T> value,
    $Res Function(CommonStateError<T>) _then,
  ) = _$CommonStateErrorCopyWithImpl;
  @useResult
  $Res call({AppException e});
}

/// @nodoc
class _$CommonStateErrorCopyWithImpl<T, $Res>
    implements $CommonStateErrorCopyWith<T, $Res> {
  _$CommonStateErrorCopyWithImpl(this._self, this._then);

  final CommonStateError<T> _self;
  final $Res Function(CommonStateError<T>) _then;

  /// Create a copy of CommonStates
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? e = null}) {
    return _then(
      CommonStateError<T>(
        null == e
            ? _self.e
            : e // ignore: cast_nullable_to_non_nullable
                  as AppException,
      ),
    );
  }
}

/// @nodoc

class CommonStateLoading<T> extends CommonStates<T> {
  const CommonStateLoading() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is CommonStateLoading<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'CommonStates<$T>.loading()';
  }
}
