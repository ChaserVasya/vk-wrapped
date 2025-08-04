// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'detailed_statistics_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DetailedStatisticsEffect {
  String get message;

  /// Create a copy of DetailedStatisticsEffect
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DetailedStatisticsEffectCopyWith<DetailedStatisticsEffect> get copyWith =>
      _$DetailedStatisticsEffectCopyWithImpl<DetailedStatisticsEffect>(
        this as DetailedStatisticsEffect,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DetailedStatisticsEffect &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'DetailedStatisticsEffect(message: $message)';
  }
}

/// @nodoc
abstract mixin class $DetailedStatisticsEffectCopyWith<$Res> {
  factory $DetailedStatisticsEffectCopyWith(
    DetailedStatisticsEffect value,
    $Res Function(DetailedStatisticsEffect) _then,
  ) = _$DetailedStatisticsEffectCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$DetailedStatisticsEffectCopyWithImpl<$Res>
    implements $DetailedStatisticsEffectCopyWith<$Res> {
  _$DetailedStatisticsEffectCopyWithImpl(this._self, this._then);

  final DetailedStatisticsEffect _self;
  final $Res Function(DetailedStatisticsEffect) _then;

  /// Create a copy of DetailedStatisticsEffect
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _self.copyWith(
        message: null == message
            ? _self.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class DetailedStatisticsEffect$Error implements DetailedStatisticsEffect {
  const DetailedStatisticsEffect$Error({required this.message});

  @override
  final String message;

  /// Create a copy of DetailedStatisticsEffect
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DetailedStatisticsEffect$ErrorCopyWith<DetailedStatisticsEffect$Error>
  get copyWith =>
      _$DetailedStatisticsEffect$ErrorCopyWithImpl<
        DetailedStatisticsEffect$Error
      >(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DetailedStatisticsEffect$Error &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'DetailedStatisticsEffect.error(message: $message)';
  }
}

/// @nodoc
abstract mixin class $DetailedStatisticsEffect$ErrorCopyWith<$Res>
    implements $DetailedStatisticsEffectCopyWith<$Res> {
  factory $DetailedStatisticsEffect$ErrorCopyWith(
    DetailedStatisticsEffect$Error value,
    $Res Function(DetailedStatisticsEffect$Error) _then,
  ) = _$DetailedStatisticsEffect$ErrorCopyWithImpl;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$DetailedStatisticsEffect$ErrorCopyWithImpl<$Res>
    implements $DetailedStatisticsEffect$ErrorCopyWith<$Res> {
  _$DetailedStatisticsEffect$ErrorCopyWithImpl(this._self, this._then);

  final DetailedStatisticsEffect$Error _self;
  final $Res Function(DetailedStatisticsEffect$Error) _then;

  /// Create a copy of DetailedStatisticsEffect
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? message = null}) {
    return _then(
      DetailedStatisticsEffect$Error(
        message: null == message
            ? _self.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
mixin _$DetailedStatisticsEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is DetailedStatisticsEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'DetailedStatisticsEvent()';
  }
}

/// @nodoc
class $DetailedStatisticsEventCopyWith<$Res> {
  $DetailedStatisticsEventCopyWith(
    DetailedStatisticsEvent _,
    $Res Function(DetailedStatisticsEvent) __,
  );
}

/// @nodoc

class _LoadStatistics implements DetailedStatisticsEvent {
  const _LoadStatistics(this.tracks);

  final IList<AudioTrack> tracks;

  /// Create a copy of DetailedStatisticsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LoadStatisticsCopyWith<_LoadStatistics> get copyWith =>
      __$LoadStatisticsCopyWithImpl<_LoadStatistics>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LoadStatistics &&
            const DeepCollectionEquality().equals(other.tracks, tracks));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(tracks));

  @override
  String toString() {
    return 'DetailedStatisticsEvent.loadStatistics(tracks: $tracks)';
  }
}

/// @nodoc
abstract mixin class _$LoadStatisticsCopyWith<$Res>
    implements $DetailedStatisticsEventCopyWith<$Res> {
  factory _$LoadStatisticsCopyWith(
    _LoadStatistics value,
    $Res Function(_LoadStatistics) _then,
  ) = __$LoadStatisticsCopyWithImpl;
  @useResult
  $Res call({IList<AudioTrack> tracks});
}

/// @nodoc
class __$LoadStatisticsCopyWithImpl<$Res>
    implements _$LoadStatisticsCopyWith<$Res> {
  __$LoadStatisticsCopyWithImpl(this._self, this._then);

  final _LoadStatistics _self;
  final $Res Function(_LoadStatistics) _then;

  /// Create a copy of DetailedStatisticsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? tracks = null}) {
    return _then(
      _LoadStatistics(
        null == tracks
            ? _self.tracks
            : tracks // ignore: cast_nullable_to_non_nullable
                  as IList<AudioTrack>,
      ),
    );
  }
}

/// @nodoc

class _LoadFromCache implements DetailedStatisticsEvent {
  const _LoadFromCache();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _LoadFromCache);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'DetailedStatisticsEvent.loadFromCache()';
  }
}

/// @nodoc
mixin _$DetailedStatisticsState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is DetailedStatisticsState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'DetailedStatisticsState()';
  }
}

/// @nodoc
class $DetailedStatisticsStateCopyWith<$Res> {
  $DetailedStatisticsStateCopyWith(
    DetailedStatisticsState _,
    $Res Function(DetailedStatisticsState) __,
  );
}

/// @nodoc

class DetailedStatisticsState$Initial implements DetailedStatisticsState {
  const DetailedStatisticsState$Initial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DetailedStatisticsState$Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'DetailedStatisticsState.initial()';
  }
}

/// @nodoc

class DetailedStatisticsState$Loading implements DetailedStatisticsState {
  const DetailedStatisticsState$Loading();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DetailedStatisticsState$Loading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'DetailedStatisticsState.loading()';
  }
}

/// @nodoc

class DetailedStatisticsState$Data implements DetailedStatisticsState {
  const DetailedStatisticsState$Data({required this.statistics});

  final IMap<String, dynamic> statistics;

  /// Create a copy of DetailedStatisticsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DetailedStatisticsState$DataCopyWith<DetailedStatisticsState$Data>
  get copyWith =>
      _$DetailedStatisticsState$DataCopyWithImpl<DetailedStatisticsState$Data>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DetailedStatisticsState$Data &&
            (identical(other.statistics, statistics) ||
                other.statistics == statistics));
  }

  @override
  int get hashCode => Object.hash(runtimeType, statistics);

  @override
  String toString() {
    return 'DetailedStatisticsState.data(statistics: $statistics)';
  }
}

/// @nodoc
abstract mixin class $DetailedStatisticsState$DataCopyWith<$Res>
    implements $DetailedStatisticsStateCopyWith<$Res> {
  factory $DetailedStatisticsState$DataCopyWith(
    DetailedStatisticsState$Data value,
    $Res Function(DetailedStatisticsState$Data) _then,
  ) = _$DetailedStatisticsState$DataCopyWithImpl;
  @useResult
  $Res call({IMap<String, dynamic> statistics});
}

/// @nodoc
class _$DetailedStatisticsState$DataCopyWithImpl<$Res>
    implements $DetailedStatisticsState$DataCopyWith<$Res> {
  _$DetailedStatisticsState$DataCopyWithImpl(this._self, this._then);

  final DetailedStatisticsState$Data _self;
  final $Res Function(DetailedStatisticsState$Data) _then;

  /// Create a copy of DetailedStatisticsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? statistics = null}) {
    return _then(
      DetailedStatisticsState$Data(
        statistics: null == statistics
            ? _self.statistics
            : statistics // ignore: cast_nullable_to_non_nullable
                  as IMap<String, dynamic>,
      ),
    );
  }
}

/// @nodoc

class DetailedStatisticsState$Error implements DetailedStatisticsState {
  const DetailedStatisticsState$Error({required this.message});

  final String message;

  /// Create a copy of DetailedStatisticsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DetailedStatisticsState$ErrorCopyWith<DetailedStatisticsState$Error>
  get copyWith =>
      _$DetailedStatisticsState$ErrorCopyWithImpl<
        DetailedStatisticsState$Error
      >(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DetailedStatisticsState$Error &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'DetailedStatisticsState.error(message: $message)';
  }
}

/// @nodoc
abstract mixin class $DetailedStatisticsState$ErrorCopyWith<$Res>
    implements $DetailedStatisticsStateCopyWith<$Res> {
  factory $DetailedStatisticsState$ErrorCopyWith(
    DetailedStatisticsState$Error value,
    $Res Function(DetailedStatisticsState$Error) _then,
  ) = _$DetailedStatisticsState$ErrorCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$DetailedStatisticsState$ErrorCopyWithImpl<$Res>
    implements $DetailedStatisticsState$ErrorCopyWith<$Res> {
  _$DetailedStatisticsState$ErrorCopyWithImpl(this._self, this._then);

  final DetailedStatisticsState$Error _self;
  final $Res Function(DetailedStatisticsState$Error) _then;

  /// Create a copy of DetailedStatisticsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? message = null}) {
    return _then(
      DetailedStatisticsState$Error(
        message: null == message
            ? _self.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}
