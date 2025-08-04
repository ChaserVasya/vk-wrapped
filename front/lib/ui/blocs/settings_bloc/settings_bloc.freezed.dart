// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SettingsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsEvent()';
}


}

/// @nodoc
class $SettingsEventCopyWith<$Res>  {
$SettingsEventCopyWith(SettingsEvent _, $Res Function(SettingsEvent) __);
}


/// @nodoc


class _CheckTokenStatus implements SettingsEvent {
  const _CheckTokenStatus();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckTokenStatus);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsEvent.checkTokenStatus()';
}


}




/// @nodoc


class _ClearToken implements SettingsEvent {
  const _ClearToken();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClearToken);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsEvent.clearToken()';
}


}




/// @nodoc


class _SaveToken implements SettingsEvent {
  const _SaveToken(this.token);
  

 final  String token;

/// Create a copy of SettingsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SaveTokenCopyWith<_SaveToken> get copyWith => __$SaveTokenCopyWithImpl<_SaveToken>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SaveToken&&(identical(other.token, token) || other.token == token));
}


@override
int get hashCode => Object.hash(runtimeType,token);

@override
String toString() {
  return 'SettingsEvent.saveToken(token: $token)';
}


}

/// @nodoc
abstract mixin class _$SaveTokenCopyWith<$Res> implements $SettingsEventCopyWith<$Res> {
  factory _$SaveTokenCopyWith(_SaveToken value, $Res Function(_SaveToken) _then) = __$SaveTokenCopyWithImpl;
@useResult
$Res call({
 String token
});




}
/// @nodoc
class __$SaveTokenCopyWithImpl<$Res>
    implements _$SaveTokenCopyWith<$Res> {
  __$SaveTokenCopyWithImpl(this._self, this._then);

  final _SaveToken _self;
  final $Res Function(_SaveToken) _then;

/// Create a copy of SettingsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? token = null,}) {
  return _then(_SaveToken(
null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ClearCache implements SettingsEvent {
  const _ClearCache();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClearCache);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsEvent.clearCache()';
}


}




/// @nodoc


class _ExportData implements SettingsEvent {
  const _ExportData();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExportData);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsEvent.exportData()';
}


}




/// @nodoc
mixin _$SettingsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsState()';
}


}

/// @nodoc
class $SettingsStateCopyWith<$Res>  {
$SettingsStateCopyWith(SettingsState _, $Res Function(SettingsState) __);
}


/// @nodoc


class SettingsState$Initial implements SettingsState {
  const SettingsState$Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsState$Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsState.initial()';
}


}




/// @nodoc


class SettingsState$Loading implements SettingsState {
  const SettingsState$Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsState$Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsState.loading()';
}


}




/// @nodoc


class SettingsState$TokenConfigured implements SettingsState {
  const SettingsState$TokenConfigured({required this.hasToken});
  

 final  bool hasToken;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingsState$TokenConfiguredCopyWith<SettingsState$TokenConfigured> get copyWith => _$SettingsState$TokenConfiguredCopyWithImpl<SettingsState$TokenConfigured>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsState$TokenConfigured&&(identical(other.hasToken, hasToken) || other.hasToken == hasToken));
}


@override
int get hashCode => Object.hash(runtimeType,hasToken);

@override
String toString() {
  return 'SettingsState.tokenConfigured(hasToken: $hasToken)';
}


}

/// @nodoc
abstract mixin class $SettingsState$TokenConfiguredCopyWith<$Res> implements $SettingsStateCopyWith<$Res> {
  factory $SettingsState$TokenConfiguredCopyWith(SettingsState$TokenConfigured value, $Res Function(SettingsState$TokenConfigured) _then) = _$SettingsState$TokenConfiguredCopyWithImpl;
@useResult
$Res call({
 bool hasToken
});




}
/// @nodoc
class _$SettingsState$TokenConfiguredCopyWithImpl<$Res>
    implements $SettingsState$TokenConfiguredCopyWith<$Res> {
  _$SettingsState$TokenConfiguredCopyWithImpl(this._self, this._then);

  final SettingsState$TokenConfigured _self;
  final $Res Function(SettingsState$TokenConfigured) _then;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? hasToken = null,}) {
  return _then(SettingsState$TokenConfigured(
hasToken: null == hasToken ? _self.hasToken : hasToken // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class SettingsState$CacheStatus implements SettingsState {
  const SettingsState$CacheStatus({required this.isCleared});
  

 final  bool isCleared;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingsState$CacheStatusCopyWith<SettingsState$CacheStatus> get copyWith => _$SettingsState$CacheStatusCopyWithImpl<SettingsState$CacheStatus>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsState$CacheStatus&&(identical(other.isCleared, isCleared) || other.isCleared == isCleared));
}


@override
int get hashCode => Object.hash(runtimeType,isCleared);

@override
String toString() {
  return 'SettingsState.cacheStatus(isCleared: $isCleared)';
}


}

/// @nodoc
abstract mixin class $SettingsState$CacheStatusCopyWith<$Res> implements $SettingsStateCopyWith<$Res> {
  factory $SettingsState$CacheStatusCopyWith(SettingsState$CacheStatus value, $Res Function(SettingsState$CacheStatus) _then) = _$SettingsState$CacheStatusCopyWithImpl;
@useResult
$Res call({
 bool isCleared
});




}
/// @nodoc
class _$SettingsState$CacheStatusCopyWithImpl<$Res>
    implements $SettingsState$CacheStatusCopyWith<$Res> {
  _$SettingsState$CacheStatusCopyWithImpl(this._self, this._then);

  final SettingsState$CacheStatus _self;
  final $Res Function(SettingsState$CacheStatus) _then;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isCleared = null,}) {
  return _then(SettingsState$CacheStatus(
isCleared: null == isCleared ? _self.isCleared : isCleared // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$SettingsEffect {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsEffect);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsEffect()';
}


}

/// @nodoc
class $SettingsEffectCopyWith<$Res>  {
$SettingsEffectCopyWith(SettingsEffect _, $Res Function(SettingsEffect) __);
}


/// @nodoc


class SettingsEffect$TokenCleared implements SettingsEffect {
  const SettingsEffect$TokenCleared();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsEffect$TokenCleared);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsEffect.tokenCleared()';
}


}




/// @nodoc


class SettingsEffect$TokenSaved implements SettingsEffect {
  const SettingsEffect$TokenSaved();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsEffect$TokenSaved);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsEffect.tokenSaved()';
}


}




/// @nodoc


class SettingsEffect$CacheCleared implements SettingsEffect {
  const SettingsEffect$CacheCleared();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsEffect$CacheCleared);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsEffect.cacheCleared()';
}


}




/// @nodoc


class SettingsEffect$DataExported implements SettingsEffect {
  const SettingsEffect$DataExported();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsEffect$DataExported);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsEffect.dataExported()';
}


}




/// @nodoc


class SettingsEffect$NoDataToExport implements SettingsEffect {
  const SettingsEffect$NoDataToExport();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsEffect$NoDataToExport);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsEffect.noDataToExport()';
}


}




/// @nodoc


class SettingsEffect$ShowTokenDialog implements SettingsEffect {
  const SettingsEffect$ShowTokenDialog({required this.hasToken});
  

 final  bool hasToken;

/// Create a copy of SettingsEffect
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingsEffect$ShowTokenDialogCopyWith<SettingsEffect$ShowTokenDialog> get copyWith => _$SettingsEffect$ShowTokenDialogCopyWithImpl<SettingsEffect$ShowTokenDialog>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsEffect$ShowTokenDialog&&(identical(other.hasToken, hasToken) || other.hasToken == hasToken));
}


@override
int get hashCode => Object.hash(runtimeType,hasToken);

@override
String toString() {
  return 'SettingsEffect.showTokenDialog(hasToken: $hasToken)';
}


}

/// @nodoc
abstract mixin class $SettingsEffect$ShowTokenDialogCopyWith<$Res> implements $SettingsEffectCopyWith<$Res> {
  factory $SettingsEffect$ShowTokenDialogCopyWith(SettingsEffect$ShowTokenDialog value, $Res Function(SettingsEffect$ShowTokenDialog) _then) = _$SettingsEffect$ShowTokenDialogCopyWithImpl;
@useResult
$Res call({
 bool hasToken
});




}
/// @nodoc
class _$SettingsEffect$ShowTokenDialogCopyWithImpl<$Res>
    implements $SettingsEffect$ShowTokenDialogCopyWith<$Res> {
  _$SettingsEffect$ShowTokenDialogCopyWithImpl(this._self, this._then);

  final SettingsEffect$ShowTokenDialog _self;
  final $Res Function(SettingsEffect$ShowTokenDialog) _then;

/// Create a copy of SettingsEffect
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? hasToken = null,}) {
  return _then(SettingsEffect$ShowTokenDialog(
hasToken: null == hasToken ? _self.hasToken : hasToken // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class SettingsEffect$Error implements SettingsEffect {
  const SettingsEffect$Error({required this.message});
  

 final  String message;

/// Create a copy of SettingsEffect
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingsEffect$ErrorCopyWith<SettingsEffect$Error> get copyWith => _$SettingsEffect$ErrorCopyWithImpl<SettingsEffect$Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsEffect$Error&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'SettingsEffect.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $SettingsEffect$ErrorCopyWith<$Res> implements $SettingsEffectCopyWith<$Res> {
  factory $SettingsEffect$ErrorCopyWith(SettingsEffect$Error value, $Res Function(SettingsEffect$Error) _then) = _$SettingsEffect$ErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$SettingsEffect$ErrorCopyWithImpl<$Res>
    implements $SettingsEffect$ErrorCopyWith<$Res> {
  _$SettingsEffect$ErrorCopyWithImpl(this._self, this._then);

  final SettingsEffect$Error _self;
  final $Res Function(SettingsEffect$Error) _then;

/// Create a copy of SettingsEffect
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(SettingsEffect$Error(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
