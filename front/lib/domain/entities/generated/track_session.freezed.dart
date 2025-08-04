// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../track_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TrackSession {
  String get fullId;
  int get firstObserved;
  int get lastSeen;

  /// Create a copy of TrackSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TrackSessionCopyWith<TrackSession> get copyWith =>
      _$TrackSessionCopyWithImpl<TrackSession>(
        this as TrackSession,
        _$identity,
      );

  /// Serializes this TrackSession to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TrackSession &&
            (identical(other.fullId, fullId) || other.fullId == fullId) &&
            (identical(other.firstObserved, firstObserved) ||
                other.firstObserved == firstObserved) &&
            (identical(other.lastSeen, lastSeen) ||
                other.lastSeen == lastSeen));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, fullId, firstObserved, lastSeen);

  @override
  String toString() {
    return 'TrackSession(fullId: $fullId, firstObserved: $firstObserved, lastSeen: $lastSeen)';
  }
}

/// @nodoc
abstract mixin class $TrackSessionCopyWith<$Res> {
  factory $TrackSessionCopyWith(
    TrackSession value,
    $Res Function(TrackSession) _then,
  ) = _$TrackSessionCopyWithImpl;
  @useResult
  $Res call({String fullId, int firstObserved, int lastSeen});
}

/// @nodoc
class _$TrackSessionCopyWithImpl<$Res> implements $TrackSessionCopyWith<$Res> {
  _$TrackSessionCopyWithImpl(this._self, this._then);

  final TrackSession _self;
  final $Res Function(TrackSession) _then;

  /// Create a copy of TrackSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullId = null,
    Object? firstObserved = null,
    Object? lastSeen = null,
  }) {
    return _then(
      _self.copyWith(
        fullId: null == fullId
            ? _self.fullId
            : fullId // ignore: cast_nullable_to_non_nullable
                  as String,
        firstObserved: null == firstObserved
            ? _self.firstObserved
            : firstObserved // ignore: cast_nullable_to_non_nullable
                  as int,
        lastSeen: null == lastSeen
            ? _self.lastSeen
            : lastSeen // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _TrackSession implements TrackSession {
  const _TrackSession({
    required this.fullId,
    required this.firstObserved,
    required this.lastSeen,
  });
  factory _TrackSession.fromJson(Map<String, dynamic> json) =>
      _$TrackSessionFromJson(json);

  @override
  final String fullId;
  @override
  final int firstObserved;
  @override
  final int lastSeen;

  /// Create a copy of TrackSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TrackSessionCopyWith<_TrackSession> get copyWith =>
      __$TrackSessionCopyWithImpl<_TrackSession>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TrackSessionToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TrackSession &&
            (identical(other.fullId, fullId) || other.fullId == fullId) &&
            (identical(other.firstObserved, firstObserved) ||
                other.firstObserved == firstObserved) &&
            (identical(other.lastSeen, lastSeen) ||
                other.lastSeen == lastSeen));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, fullId, firstObserved, lastSeen);

  @override
  String toString() {
    return 'TrackSession(fullId: $fullId, firstObserved: $firstObserved, lastSeen: $lastSeen)';
  }
}

/// @nodoc
abstract mixin class _$TrackSessionCopyWith<$Res>
    implements $TrackSessionCopyWith<$Res> {
  factory _$TrackSessionCopyWith(
    _TrackSession value,
    $Res Function(_TrackSession) _then,
  ) = __$TrackSessionCopyWithImpl;
  @override
  @useResult
  $Res call({String fullId, int firstObserved, int lastSeen});
}

/// @nodoc
class __$TrackSessionCopyWithImpl<$Res>
    implements _$TrackSessionCopyWith<$Res> {
  __$TrackSessionCopyWithImpl(this._self, this._then);

  final _TrackSession _self;
  final $Res Function(_TrackSession) _then;

  /// Create a copy of TrackSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? fullId = null,
    Object? firstObserved = null,
    Object? lastSeen = null,
  }) {
    return _then(
      _TrackSession(
        fullId: null == fullId
            ? _self.fullId
            : fullId // ignore: cast_nullable_to_non_nullable
                  as String,
        firstObserved: null == firstObserved
            ? _self.firstObserved
            : firstObserved // ignore: cast_nullable_to_non_nullable
                  as int,
        lastSeen: null == lastSeen
            ? _self.lastSeen
            : lastSeen // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}
