// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SettingsEffect {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SettingsEffect);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SettingsEffect()';
  }
}

/// @nodoc
class $SettingsEffectCopyWith<$Res> {
  $SettingsEffectCopyWith(SettingsEffect _, $Res Function(SettingsEffect) __);
}

/// @nodoc

class SettingsEffect$TokenCleared implements SettingsEffect {
  const SettingsEffect$TokenCleared();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SettingsEffect$TokenCleared);
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
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SettingsEffect$TokenSaved);
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
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SettingsEffect$CacheCleared);
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
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SettingsEffect$DataExported);
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
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SettingsEffect$NoDataToExport);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SettingsEffect.noDataToExport()';
  }
}

/// @nodoc
mixin _$SettingsEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SettingsEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SettingsEvent()';
  }
}

/// @nodoc
class $SettingsEventCopyWith<$Res> {
  $SettingsEventCopyWith(SettingsEvent _, $Res Function(SettingsEvent) __);
}

/// @nodoc

class _ClearToken implements SettingsEvent {
  const _ClearToken();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _ClearToken);
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

  final String token;

  /// Create a copy of SettingsEvent
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
    return 'SettingsEvent.saveToken(token: $token)';
  }
}

/// @nodoc
abstract mixin class _$SaveTokenCopyWith<$Res>
    implements $SettingsEventCopyWith<$Res> {
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

  /// Create a copy of SettingsEvent
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

class _ClearCache implements SettingsEvent {
  const _ClearCache();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _ClearCache);
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
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _ExportData);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SettingsEvent.exportData()';
  }
}

/// @nodoc

class _LoadCurrentData implements SettingsEvent {
  const _LoadCurrentData();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _LoadCurrentData);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SettingsEvent.loadCurrentData()';
  }
}

/// @nodoc
mixin _$SettingsData {
  bool get hasToken;
  String? get currentToken;
  DateTime? get tokenExpiresAt;
  String get clientId;
  bool get isCacheCleared;

  /// Create a copy of SettingsData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SettingsDataCopyWith<SettingsData> get copyWith =>
      _$SettingsDataCopyWithImpl<SettingsData>(
        this as SettingsData,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SettingsData &&
            (identical(other.hasToken, hasToken) ||
                other.hasToken == hasToken) &&
            (identical(other.currentToken, currentToken) ||
                other.currentToken == currentToken) &&
            (identical(other.tokenExpiresAt, tokenExpiresAt) ||
                other.tokenExpiresAt == tokenExpiresAt) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.isCacheCleared, isCacheCleared) ||
                other.isCacheCleared == isCacheCleared));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    hasToken,
    currentToken,
    tokenExpiresAt,
    clientId,
    isCacheCleared,
  );

  @override
  String toString() {
    return 'SettingsData(hasToken: $hasToken, currentToken: $currentToken, tokenExpiresAt: $tokenExpiresAt, clientId: $clientId, isCacheCleared: $isCacheCleared)';
  }
}

/// @nodoc
abstract mixin class $SettingsDataCopyWith<$Res> {
  factory $SettingsDataCopyWith(
    SettingsData value,
    $Res Function(SettingsData) _then,
  ) = _$SettingsDataCopyWithImpl;
  @useResult
  $Res call({
    bool hasToken,
    String? currentToken,
    DateTime? tokenExpiresAt,
    String clientId,
    bool isCacheCleared,
  });
}

/// @nodoc
class _$SettingsDataCopyWithImpl<$Res> implements $SettingsDataCopyWith<$Res> {
  _$SettingsDataCopyWithImpl(this._self, this._then);

  final SettingsData _self;
  final $Res Function(SettingsData) _then;

  /// Create a copy of SettingsData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hasToken = null,
    Object? currentToken = freezed,
    Object? tokenExpiresAt = freezed,
    Object? clientId = null,
    Object? isCacheCleared = null,
  }) {
    return _then(
      _self.copyWith(
        hasToken: null == hasToken
            ? _self.hasToken
            : hasToken // ignore: cast_nullable_to_non_nullable
                  as bool,
        currentToken: freezed == currentToken
            ? _self.currentToken
            : currentToken // ignore: cast_nullable_to_non_nullable
                  as String?,
        tokenExpiresAt: freezed == tokenExpiresAt
            ? _self.tokenExpiresAt
            : tokenExpiresAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        clientId: null == clientId
            ? _self.clientId
            : clientId // ignore: cast_nullable_to_non_nullable
                  as String,
        isCacheCleared: null == isCacheCleared
            ? _self.isCacheCleared
            : isCacheCleared // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _SettingsData implements SettingsData {
  const _SettingsData({
    required this.hasToken,
    required this.currentToken,
    this.tokenExpiresAt,
    required this.clientId,
    required this.isCacheCleared,
  });

  @override
  final bool hasToken;
  @override
  final String? currentToken;
  @override
  final DateTime? tokenExpiresAt;
  @override
  final String clientId;
  @override
  final bool isCacheCleared;

  /// Create a copy of SettingsData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SettingsDataCopyWith<_SettingsData> get copyWith =>
      __$SettingsDataCopyWithImpl<_SettingsData>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SettingsData &&
            (identical(other.hasToken, hasToken) ||
                other.hasToken == hasToken) &&
            (identical(other.currentToken, currentToken) ||
                other.currentToken == currentToken) &&
            (identical(other.tokenExpiresAt, tokenExpiresAt) ||
                other.tokenExpiresAt == tokenExpiresAt) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.isCacheCleared, isCacheCleared) ||
                other.isCacheCleared == isCacheCleared));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    hasToken,
    currentToken,
    tokenExpiresAt,
    clientId,
    isCacheCleared,
  );

  @override
  String toString() {
    return 'SettingsData(hasToken: $hasToken, currentToken: $currentToken, tokenExpiresAt: $tokenExpiresAt, clientId: $clientId, isCacheCleared: $isCacheCleared)';
  }
}

/// @nodoc
abstract mixin class _$SettingsDataCopyWith<$Res>
    implements $SettingsDataCopyWith<$Res> {
  factory _$SettingsDataCopyWith(
    _SettingsData value,
    $Res Function(_SettingsData) _then,
  ) = __$SettingsDataCopyWithImpl;
  @override
  @useResult
  $Res call({
    bool hasToken,
    String? currentToken,
    DateTime? tokenExpiresAt,
    String clientId,
    bool isCacheCleared,
  });
}

/// @nodoc
class __$SettingsDataCopyWithImpl<$Res>
    implements _$SettingsDataCopyWith<$Res> {
  __$SettingsDataCopyWithImpl(this._self, this._then);

  final _SettingsData _self;
  final $Res Function(_SettingsData) _then;

  /// Create a copy of SettingsData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? hasToken = null,
    Object? currentToken = freezed,
    Object? tokenExpiresAt = freezed,
    Object? clientId = null,
    Object? isCacheCleared = null,
  }) {
    return _then(
      _SettingsData(
        hasToken: null == hasToken
            ? _self.hasToken
            : hasToken // ignore: cast_nullable_to_non_nullable
                  as bool,
        currentToken: freezed == currentToken
            ? _self.currentToken
            : currentToken // ignore: cast_nullable_to_non_nullable
                  as String?,
        tokenExpiresAt: freezed == tokenExpiresAt
            ? _self.tokenExpiresAt
            : tokenExpiresAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        clientId: null == clientId
            ? _self.clientId
            : clientId // ignore: cast_nullable_to_non_nullable
                  as String,
        isCacheCleared: null == isCacheCleared
            ? _self.isCacheCleared
            : isCacheCleared // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}
