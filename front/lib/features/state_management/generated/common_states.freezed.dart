// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
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
