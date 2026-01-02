// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../date_range_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DateRangeFilter {
  /// Начало диапазона (включительно). null означает отсутствие ограничения снизу
  DateTime? get startDate;

  /// Конец диапазона (включительно). null означает отсутствие ограничения сверху
  DateTime? get endDate;

  /// Create a copy of DateRangeFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DateRangeFilterCopyWith<DateRangeFilter> get copyWith =>
      _$DateRangeFilterCopyWithImpl<DateRangeFilter>(
        this as DateRangeFilter,
        _$identity,
      );

  /// Serializes this DateRangeFilter to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DateRangeFilter &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, startDate, endDate);

  @override
  String toString() {
    return 'DateRangeFilter(startDate: $startDate, endDate: $endDate)';
  }
}

/// @nodoc
abstract mixin class $DateRangeFilterCopyWith<$Res> {
  factory $DateRangeFilterCopyWith(
    DateRangeFilter value,
    $Res Function(DateRangeFilter) _then,
  ) = _$DateRangeFilterCopyWithImpl;
  @useResult
  $Res call({DateTime? startDate, DateTime? endDate});
}

/// @nodoc
class _$DateRangeFilterCopyWithImpl<$Res>
    implements $DateRangeFilterCopyWith<$Res> {
  _$DateRangeFilterCopyWithImpl(this._self, this._then);

  final DateRangeFilter _self;
  final $Res Function(DateRangeFilter) _then;

  /// Create a copy of DateRangeFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? startDate = freezed, Object? endDate = freezed}) {
    return _then(
      _self.copyWith(
        startDate: freezed == startDate
            ? _self.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        endDate: freezed == endDate
            ? _self.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [DateRangeFilter].
extension DateRangeFilterPatterns on DateRangeFilter {
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
    TResult Function(_DateRangeFilter value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DateRangeFilter() when $default != null:
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
    TResult Function(_DateRangeFilter value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DateRangeFilter():
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
    TResult? Function(_DateRangeFilter value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DateRangeFilter() when $default != null:
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
    TResult Function(DateTime? startDate, DateTime? endDate)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DateRangeFilter() when $default != null:
        return $default(_that.startDate, _that.endDate);
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
    TResult Function(DateTime? startDate, DateTime? endDate) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DateRangeFilter():
        return $default(_that.startDate, _that.endDate);
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
    TResult? Function(DateTime? startDate, DateTime? endDate)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DateRangeFilter() when $default != null:
        return $default(_that.startDate, _that.endDate);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _DateRangeFilter extends DateRangeFilter {
  const _DateRangeFilter({this.startDate, this.endDate}) : super._();
  factory _DateRangeFilter.fromJson(Map<String, dynamic> json) =>
      _$DateRangeFilterFromJson(json);

  /// Начало диапазона (включительно). null означает отсутствие ограничения снизу
  @override
  final DateTime? startDate;

  /// Конец диапазона (включительно). null означает отсутствие ограничения сверху
  @override
  final DateTime? endDate;

  /// Create a copy of DateRangeFilter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DateRangeFilterCopyWith<_DateRangeFilter> get copyWith =>
      __$DateRangeFilterCopyWithImpl<_DateRangeFilter>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DateRangeFilterToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DateRangeFilter &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, startDate, endDate);

  @override
  String toString() {
    return 'DateRangeFilter(startDate: $startDate, endDate: $endDate)';
  }
}

/// @nodoc
abstract mixin class _$DateRangeFilterCopyWith<$Res>
    implements $DateRangeFilterCopyWith<$Res> {
  factory _$DateRangeFilterCopyWith(
    _DateRangeFilter value,
    $Res Function(_DateRangeFilter) _then,
  ) = __$DateRangeFilterCopyWithImpl;
  @override
  @useResult
  $Res call({DateTime? startDate, DateTime? endDate});
}

/// @nodoc
class __$DateRangeFilterCopyWithImpl<$Res>
    implements _$DateRangeFilterCopyWith<$Res> {
  __$DateRangeFilterCopyWithImpl(this._self, this._then);

  final _DateRangeFilter _self;
  final $Res Function(_DateRangeFilter) _then;

  /// Create a copy of DateRangeFilter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? startDate = freezed, Object? endDate = freezed}) {
    return _then(
      _DateRangeFilter(
        startDate: freezed == startDate
            ? _self.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        endDate: freezed == endDate
            ? _self.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}
