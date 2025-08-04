// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HomeEffect {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is HomeEffect);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'HomeEffect()';
  }
}

/// @nodoc
class $HomeEffectCopyWith<$Res> {
  $HomeEffectCopyWith(HomeEffect _, $Res Function(HomeEffect) __);
}

/// @nodoc

class HomeEffect$TokenSaved implements HomeEffect {
  const HomeEffect$TokenSaved();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is HomeEffect$TokenSaved);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'HomeEffect.tokenSaved()';
  }
}

/// @nodoc

class HomeEffect$TokenError implements HomeEffect {
  const HomeEffect$TokenError({required this.message});

  final String message;

  /// Create a copy of HomeEffect
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $HomeEffect$TokenErrorCopyWith<HomeEffect$TokenError> get copyWith =>
      _$HomeEffect$TokenErrorCopyWithImpl<HomeEffect$TokenError>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HomeEffect$TokenError &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'HomeEffect.tokenError(message: $message)';
  }
}

/// @nodoc
abstract mixin class $HomeEffect$TokenErrorCopyWith<$Res>
    implements $HomeEffectCopyWith<$Res> {
  factory $HomeEffect$TokenErrorCopyWith(
    HomeEffect$TokenError value,
    $Res Function(HomeEffect$TokenError) _then,
  ) = _$HomeEffect$TokenErrorCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$HomeEffect$TokenErrorCopyWithImpl<$Res>
    implements $HomeEffect$TokenErrorCopyWith<$Res> {
  _$HomeEffect$TokenErrorCopyWithImpl(this._self, this._then);

  final HomeEffect$TokenError _self;
  final $Res Function(HomeEffect$TokenError) _then;

  /// Create a copy of HomeEffect
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? message = null}) {
    return _then(
      HomeEffect$TokenError(
        message: null == message
            ? _self.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class HomeEffect$ShowTokenDialog implements HomeEffect {
  const HomeEffect$ShowTokenDialog();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HomeEffect$ShowTokenDialog);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'HomeEffect.showTokenDialog()';
  }
}

/// @nodoc
mixin _$HomeEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is HomeEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'HomeEvent()';
  }
}

/// @nodoc
class $HomeEventCopyWith<$Res> {
  $HomeEventCopyWith(HomeEvent _, $Res Function(HomeEvent) __);
}

/// @nodoc

class _SaveToken implements HomeEvent {
  const _SaveToken(this.token);

  final String token;

  /// Create a copy of HomeEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SaveTokenCopyWith<_SaveToken> get copyWith =>
      __$SaveTokenCopyWithImpl<_SaveToken>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SaveToken &&
            (identical(other.token, token) || other.token == token));
  }

  @override
  int get hashCode => Object.hash(runtimeType, token);

  @override
  String toString() {
    return 'HomeEvent.saveToken(token: $token)';
  }
}

/// @nodoc
abstract mixin class _$SaveTokenCopyWith<$Res>
    implements $HomeEventCopyWith<$Res> {
  factory _$SaveTokenCopyWith(
    _SaveToken value,
    $Res Function(_SaveToken) _then,
  ) = __$SaveTokenCopyWithImpl;
  @useResult
  $Res call({String token});
}

/// @nodoc
class __$SaveTokenCopyWithImpl<$Res> implements _$SaveTokenCopyWith<$Res> {
  __$SaveTokenCopyWithImpl(this._self, this._then);

  final _SaveToken _self;
  final $Res Function(_SaveToken) _then;

  /// Create a copy of HomeEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? token = null}) {
    return _then(
      _SaveToken(
        null == token
            ? _self.token
            : token // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _ShowTokenDialog implements HomeEvent {
  const _ShowTokenDialog();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _ShowTokenDialog);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'HomeEvent.showTokenDialog()';
  }
}

/// @nodoc
mixin _$HomeState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is HomeState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'HomeState()';
  }
}

/// @nodoc
class $HomeStateCopyWith<$Res> {
  $HomeStateCopyWith(HomeState _, $Res Function(HomeState) __);
}

/// @nodoc

class HomeState$Initial implements HomeState {
  const HomeState$Initial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is HomeState$Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'HomeState.initial()';
  }
}
