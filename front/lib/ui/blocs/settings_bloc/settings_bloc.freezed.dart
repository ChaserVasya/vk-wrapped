// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
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

/// Adds pattern-matching-related methods to [SettingsEffect].
extension SettingsEffectPatterns on SettingsEffect {
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
    TResult Function(SettingsEffect$TokenCleared value)? tokenCleared,
    TResult Function(SettingsEffect$TokenSaved value)? tokenSaved,
    TResult Function(SettingsEffect$CacheCleared value)? cacheCleared,
    TResult Function(SettingsEffect$DataExported value)? dataExported,
    TResult Function(SettingsEffect$NoDataToExport value)? noDataToExport,
    TResult Function(SettingsEffect$DateRangeFilterChanged value)?
    dateRangeFilterChanged,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case SettingsEffect$TokenCleared() when tokenCleared != null:
        return tokenCleared(_that);
      case SettingsEffect$TokenSaved() when tokenSaved != null:
        return tokenSaved(_that);
      case SettingsEffect$CacheCleared() when cacheCleared != null:
        return cacheCleared(_that);
      case SettingsEffect$DataExported() when dataExported != null:
        return dataExported(_that);
      case SettingsEffect$NoDataToExport() when noDataToExport != null:
        return noDataToExport(_that);
      case SettingsEffect$DateRangeFilterChanged()
          when dateRangeFilterChanged != null:
        return dateRangeFilterChanged(_that);
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
    required TResult Function(SettingsEffect$TokenCleared value) tokenCleared,
    required TResult Function(SettingsEffect$TokenSaved value) tokenSaved,
    required TResult Function(SettingsEffect$CacheCleared value) cacheCleared,
    required TResult Function(SettingsEffect$DataExported value) dataExported,
    required TResult Function(SettingsEffect$NoDataToExport value)
    noDataToExport,
    required TResult Function(SettingsEffect$DateRangeFilterChanged value)
    dateRangeFilterChanged,
  }) {
    final _that = this;
    switch (_that) {
      case SettingsEffect$TokenCleared():
        return tokenCleared(_that);
      case SettingsEffect$TokenSaved():
        return tokenSaved(_that);
      case SettingsEffect$CacheCleared():
        return cacheCleared(_that);
      case SettingsEffect$DataExported():
        return dataExported(_that);
      case SettingsEffect$NoDataToExport():
        return noDataToExport(_that);
      case SettingsEffect$DateRangeFilterChanged():
        return dateRangeFilterChanged(_that);
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
    TResult? Function(SettingsEffect$TokenCleared value)? tokenCleared,
    TResult? Function(SettingsEffect$TokenSaved value)? tokenSaved,
    TResult? Function(SettingsEffect$CacheCleared value)? cacheCleared,
    TResult? Function(SettingsEffect$DataExported value)? dataExported,
    TResult? Function(SettingsEffect$NoDataToExport value)? noDataToExport,
    TResult? Function(SettingsEffect$DateRangeFilterChanged value)?
    dateRangeFilterChanged,
  }) {
    final _that = this;
    switch (_that) {
      case SettingsEffect$TokenCleared() when tokenCleared != null:
        return tokenCleared(_that);
      case SettingsEffect$TokenSaved() when tokenSaved != null:
        return tokenSaved(_that);
      case SettingsEffect$CacheCleared() when cacheCleared != null:
        return cacheCleared(_that);
      case SettingsEffect$DataExported() when dataExported != null:
        return dataExported(_that);
      case SettingsEffect$NoDataToExport() when noDataToExport != null:
        return noDataToExport(_that);
      case SettingsEffect$DateRangeFilterChanged()
          when dateRangeFilterChanged != null:
        return dateRangeFilterChanged(_that);
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
    TResult Function()? tokenCleared,
    TResult Function()? tokenSaved,
    TResult Function()? cacheCleared,
    TResult Function()? dataExported,
    TResult Function()? noDataToExport,
    TResult Function()? dateRangeFilterChanged,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case SettingsEffect$TokenCleared() when tokenCleared != null:
        return tokenCleared();
      case SettingsEffect$TokenSaved() when tokenSaved != null:
        return tokenSaved();
      case SettingsEffect$CacheCleared() when cacheCleared != null:
        return cacheCleared();
      case SettingsEffect$DataExported() when dataExported != null:
        return dataExported();
      case SettingsEffect$NoDataToExport() when noDataToExport != null:
        return noDataToExport();
      case SettingsEffect$DateRangeFilterChanged()
          when dateRangeFilterChanged != null:
        return dateRangeFilterChanged();
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
    required TResult Function() tokenCleared,
    required TResult Function() tokenSaved,
    required TResult Function() cacheCleared,
    required TResult Function() dataExported,
    required TResult Function() noDataToExport,
    required TResult Function() dateRangeFilterChanged,
  }) {
    final _that = this;
    switch (_that) {
      case SettingsEffect$TokenCleared():
        return tokenCleared();
      case SettingsEffect$TokenSaved():
        return tokenSaved();
      case SettingsEffect$CacheCleared():
        return cacheCleared();
      case SettingsEffect$DataExported():
        return dataExported();
      case SettingsEffect$NoDataToExport():
        return noDataToExport();
      case SettingsEffect$DateRangeFilterChanged():
        return dateRangeFilterChanged();
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
    TResult? Function()? tokenCleared,
    TResult? Function()? tokenSaved,
    TResult? Function()? cacheCleared,
    TResult? Function()? dataExported,
    TResult? Function()? noDataToExport,
    TResult? Function()? dateRangeFilterChanged,
  }) {
    final _that = this;
    switch (_that) {
      case SettingsEffect$TokenCleared() when tokenCleared != null:
        return tokenCleared();
      case SettingsEffect$TokenSaved() when tokenSaved != null:
        return tokenSaved();
      case SettingsEffect$CacheCleared() when cacheCleared != null:
        return cacheCleared();
      case SettingsEffect$DataExported() when dataExported != null:
        return dataExported();
      case SettingsEffect$NoDataToExport() when noDataToExport != null:
        return noDataToExport();
      case SettingsEffect$DateRangeFilterChanged()
          when dateRangeFilterChanged != null:
        return dateRangeFilterChanged();
      case _:
        return null;
    }
  }
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

class SettingsEffect$DateRangeFilterChanged implements SettingsEffect {
  const SettingsEffect$DateRangeFilterChanged();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SettingsEffect$DateRangeFilterChanged);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SettingsEffect.dateRangeFilterChanged()';
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

/// Adds pattern-matching-related methods to [SettingsEvent].
extension SettingsEventPatterns on SettingsEvent {
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
    TResult Function(_ClearToken value)? clearToken,
    TResult Function(_SaveToken value)? saveToken,
    TResult Function(_ClearCache value)? clearCache,
    TResult Function(_ExportData value)? exportData,
    TResult Function(_LoadCurrentData value)? loadCurrentData,
    TResult Function(_SaveDateRangeFilter value)? saveDateRangeFilter,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ClearToken() when clearToken != null:
        return clearToken(_that);
      case _SaveToken() when saveToken != null:
        return saveToken(_that);
      case _ClearCache() when clearCache != null:
        return clearCache(_that);
      case _ExportData() when exportData != null:
        return exportData(_that);
      case _LoadCurrentData() when loadCurrentData != null:
        return loadCurrentData(_that);
      case _SaveDateRangeFilter() when saveDateRangeFilter != null:
        return saveDateRangeFilter(_that);
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
    required TResult Function(_ClearToken value) clearToken,
    required TResult Function(_SaveToken value) saveToken,
    required TResult Function(_ClearCache value) clearCache,
    required TResult Function(_ExportData value) exportData,
    required TResult Function(_LoadCurrentData value) loadCurrentData,
    required TResult Function(_SaveDateRangeFilter value) saveDateRangeFilter,
  }) {
    final _that = this;
    switch (_that) {
      case _ClearToken():
        return clearToken(_that);
      case _SaveToken():
        return saveToken(_that);
      case _ClearCache():
        return clearCache(_that);
      case _ExportData():
        return exportData(_that);
      case _LoadCurrentData():
        return loadCurrentData(_that);
      case _SaveDateRangeFilter():
        return saveDateRangeFilter(_that);
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
    TResult? Function(_ClearToken value)? clearToken,
    TResult? Function(_SaveToken value)? saveToken,
    TResult? Function(_ClearCache value)? clearCache,
    TResult? Function(_ExportData value)? exportData,
    TResult? Function(_LoadCurrentData value)? loadCurrentData,
    TResult? Function(_SaveDateRangeFilter value)? saveDateRangeFilter,
  }) {
    final _that = this;
    switch (_that) {
      case _ClearToken() when clearToken != null:
        return clearToken(_that);
      case _SaveToken() when saveToken != null:
        return saveToken(_that);
      case _ClearCache() when clearCache != null:
        return clearCache(_that);
      case _ExportData() when exportData != null:
        return exportData(_that);
      case _LoadCurrentData() when loadCurrentData != null:
        return loadCurrentData(_that);
      case _SaveDateRangeFilter() when saveDateRangeFilter != null:
        return saveDateRangeFilter(_that);
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
    TResult Function()? clearToken,
    TResult Function(String token)? saveToken,
    TResult Function()? clearCache,
    TResult Function()? exportData,
    TResult Function()? loadCurrentData,
    TResult Function(DateRangeFilter? filter)? saveDateRangeFilter,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ClearToken() when clearToken != null:
        return clearToken();
      case _SaveToken() when saveToken != null:
        return saveToken(_that.token);
      case _ClearCache() when clearCache != null:
        return clearCache();
      case _ExportData() when exportData != null:
        return exportData();
      case _LoadCurrentData() when loadCurrentData != null:
        return loadCurrentData();
      case _SaveDateRangeFilter() when saveDateRangeFilter != null:
        return saveDateRangeFilter(_that.filter);
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
    required TResult Function() clearToken,
    required TResult Function(String token) saveToken,
    required TResult Function() clearCache,
    required TResult Function() exportData,
    required TResult Function() loadCurrentData,
    required TResult Function(DateRangeFilter? filter) saveDateRangeFilter,
  }) {
    final _that = this;
    switch (_that) {
      case _ClearToken():
        return clearToken();
      case _SaveToken():
        return saveToken(_that.token);
      case _ClearCache():
        return clearCache();
      case _ExportData():
        return exportData();
      case _LoadCurrentData():
        return loadCurrentData();
      case _SaveDateRangeFilter():
        return saveDateRangeFilter(_that.filter);
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
    TResult? Function()? clearToken,
    TResult? Function(String token)? saveToken,
    TResult? Function()? clearCache,
    TResult? Function()? exportData,
    TResult? Function()? loadCurrentData,
    TResult? Function(DateRangeFilter? filter)? saveDateRangeFilter,
  }) {
    final _that = this;
    switch (_that) {
      case _ClearToken() when clearToken != null:
        return clearToken();
      case _SaveToken() when saveToken != null:
        return saveToken(_that.token);
      case _ClearCache() when clearCache != null:
        return clearCache();
      case _ExportData() when exportData != null:
        return exportData();
      case _LoadCurrentData() when loadCurrentData != null:
        return loadCurrentData();
      case _SaveDateRangeFilter() when saveDateRangeFilter != null:
        return saveDateRangeFilter(_that.filter);
      case _:
        return null;
    }
  }
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

class _SaveDateRangeFilter implements SettingsEvent {
  const _SaveDateRangeFilter(this.filter);

  final DateRangeFilter? filter;

  /// Create a copy of SettingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SaveDateRangeFilterCopyWith<_SaveDateRangeFilter> get copyWith =>
      __$SaveDateRangeFilterCopyWithImpl<_SaveDateRangeFilter>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SaveDateRangeFilter &&
            (identical(other.filter, filter) || other.filter == filter));
  }

  @override
  int get hashCode => Object.hash(runtimeType, filter);

  @override
  String toString() {
    return 'SettingsEvent.saveDateRangeFilter(filter: $filter)';
  }
}

/// @nodoc
abstract mixin class _$SaveDateRangeFilterCopyWith<$Res>
    implements $SettingsEventCopyWith<$Res> {
  factory _$SaveDateRangeFilterCopyWith(
    _SaveDateRangeFilter value,
    $Res Function(_SaveDateRangeFilter) _then,
  ) = __$SaveDateRangeFilterCopyWithImpl;
  @useResult
  $Res call({DateRangeFilter? filter});

  $DateRangeFilterCopyWith<$Res>? get filter;
}

/// @nodoc
class __$SaveDateRangeFilterCopyWithImpl<$Res>
    implements _$SaveDateRangeFilterCopyWith<$Res> {
  __$SaveDateRangeFilterCopyWithImpl(this._self, this._then);

  final _SaveDateRangeFilter _self;
  final $Res Function(_SaveDateRangeFilter) _then;

  /// Create a copy of SettingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? filter = freezed}) {
    return _then(
      _SaveDateRangeFilter(
        freezed == filter
            ? _self.filter
            : filter // ignore: cast_nullable_to_non_nullable
                  as DateRangeFilter?,
      ),
    );
  }

  /// Create a copy of SettingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DateRangeFilterCopyWith<$Res>? get filter {
    if (_self.filter == null) {
      return null;
    }

    return $DateRangeFilterCopyWith<$Res>(_self.filter!, (value) {
      return _then(_self.copyWith(filter: value));
    });
  }
}

/// @nodoc
mixin _$SettingsData {
  bool get hasToken;
  String? get currentToken;
  DateTime? get tokenExpiresAt;
  String get clientId;
  bool get isCacheCleared;
  DateRangeFilter? get dateRangeFilter;

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
                other.isCacheCleared == isCacheCleared) &&
            (identical(other.dateRangeFilter, dateRangeFilter) ||
                other.dateRangeFilter == dateRangeFilter));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    hasToken,
    currentToken,
    tokenExpiresAt,
    clientId,
    isCacheCleared,
    dateRangeFilter,
  );

  @override
  String toString() {
    return 'SettingsData(hasToken: $hasToken, currentToken: $currentToken, tokenExpiresAt: $tokenExpiresAt, clientId: $clientId, isCacheCleared: $isCacheCleared, dateRangeFilter: $dateRangeFilter)';
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
    DateRangeFilter? dateRangeFilter,
  });

  $DateRangeFilterCopyWith<$Res>? get dateRangeFilter;
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
    Object? dateRangeFilter = freezed,
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
        dateRangeFilter: freezed == dateRangeFilter
            ? _self.dateRangeFilter
            : dateRangeFilter // ignore: cast_nullable_to_non_nullable
                  as DateRangeFilter?,
      ),
    );
  }

  /// Create a copy of SettingsData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DateRangeFilterCopyWith<$Res>? get dateRangeFilter {
    if (_self.dateRangeFilter == null) {
      return null;
    }

    return $DateRangeFilterCopyWith<$Res>(_self.dateRangeFilter!, (value) {
      return _then(_self.copyWith(dateRangeFilter: value));
    });
  }
}

/// Adds pattern-matching-related methods to [SettingsData].
extension SettingsDataPatterns on SettingsData {
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
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_SettingsData value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SettingsData() when $default != null:
        return $default(_that);
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
  TResult map<TResult extends Object?>(
    TResult Function(_SettingsData value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettingsData():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
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
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_SettingsData value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettingsData() when $default != null:
        return $default(_that);
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
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
      bool hasToken,
      String? currentToken,
      DateTime? tokenExpiresAt,
      String clientId,
      bool isCacheCleared,
      DateRangeFilter? dateRangeFilter,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SettingsData() when $default != null:
        return $default(
          _that.hasToken,
          _that.currentToken,
          _that.tokenExpiresAt,
          _that.clientId,
          _that.isCacheCleared,
          _that.dateRangeFilter,
        );
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
  TResult when<TResult extends Object?>(
    TResult Function(
      bool hasToken,
      String? currentToken,
      DateTime? tokenExpiresAt,
      String clientId,
      bool isCacheCleared,
      DateRangeFilter? dateRangeFilter,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettingsData():
        return $default(
          _that.hasToken,
          _that.currentToken,
          _that.tokenExpiresAt,
          _that.clientId,
          _that.isCacheCleared,
          _that.dateRangeFilter,
        );
      case _:
        throw StateError('Unexpected subclass');
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
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
      bool hasToken,
      String? currentToken,
      DateTime? tokenExpiresAt,
      String clientId,
      bool isCacheCleared,
      DateRangeFilter? dateRangeFilter,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettingsData() when $default != null:
        return $default(
          _that.hasToken,
          _that.currentToken,
          _that.tokenExpiresAt,
          _that.clientId,
          _that.isCacheCleared,
          _that.dateRangeFilter,
        );
      case _:
        return null;
    }
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
    this.dateRangeFilter,
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
  @override
  final DateRangeFilter? dateRangeFilter;

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
                other.isCacheCleared == isCacheCleared) &&
            (identical(other.dateRangeFilter, dateRangeFilter) ||
                other.dateRangeFilter == dateRangeFilter));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    hasToken,
    currentToken,
    tokenExpiresAt,
    clientId,
    isCacheCleared,
    dateRangeFilter,
  );

  @override
  String toString() {
    return 'SettingsData(hasToken: $hasToken, currentToken: $currentToken, tokenExpiresAt: $tokenExpiresAt, clientId: $clientId, isCacheCleared: $isCacheCleared, dateRangeFilter: $dateRangeFilter)';
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
    DateRangeFilter? dateRangeFilter,
  });

  @override
  $DateRangeFilterCopyWith<$Res>? get dateRangeFilter;
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
    Object? dateRangeFilter = freezed,
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
        dateRangeFilter: freezed == dateRangeFilter
            ? _self.dateRangeFilter
            : dateRangeFilter // ignore: cast_nullable_to_non_nullable
                  as DateRangeFilter?,
      ),
    );
  }

  /// Create a copy of SettingsData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DateRangeFilterCopyWith<$Res>? get dateRangeFilter {
    if (_self.dateRangeFilter == null) {
      return null;
    }

    return $DateRangeFilterCopyWith<$Res>(_self.dateRangeFilter!, (value) {
      return _then(_self.copyWith(dateRangeFilter: value));
    });
  }
}
