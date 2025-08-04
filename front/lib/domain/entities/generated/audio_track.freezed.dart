// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../audio_track.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AudioTrack {
  String get id;
  String get title;
  String get artist;
  String get url;
  int get duration;
  String? get albumCover;
  DateTime? get lastPlayed;
  int get playCount;

  /// Create a copy of AudioTrack
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AudioTrackCopyWith<AudioTrack> get copyWith =>
      _$AudioTrackCopyWithImpl<AudioTrack>(this as AudioTrack, _$identity);

  /// Serializes this AudioTrack to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AudioTrack &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.artist, artist) || other.artist == artist) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.albumCover, albumCover) ||
                other.albumCover == albumCover) &&
            (identical(other.lastPlayed, lastPlayed) ||
                other.lastPlayed == lastPlayed) &&
            (identical(other.playCount, playCount) ||
                other.playCount == playCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    artist,
    url,
    duration,
    albumCover,
    lastPlayed,
    playCount,
  );

  @override
  String toString() {
    return 'AudioTrack(id: $id, title: $title, artist: $artist, url: $url, duration: $duration, albumCover: $albumCover, lastPlayed: $lastPlayed, playCount: $playCount)';
  }
}

/// @nodoc
abstract mixin class $AudioTrackCopyWith<$Res> {
  factory $AudioTrackCopyWith(
    AudioTrack value,
    $Res Function(AudioTrack) _then,
  ) = _$AudioTrackCopyWithImpl;
  @useResult
  $Res call({
    String id,
    String title,
    String artist,
    String url,
    int duration,
    String? albumCover,
    DateTime? lastPlayed,
    int playCount,
  });
}

/// @nodoc
class _$AudioTrackCopyWithImpl<$Res> implements $AudioTrackCopyWith<$Res> {
  _$AudioTrackCopyWithImpl(this._self, this._then);

  final AudioTrack _self;
  final $Res Function(AudioTrack) _then;

  /// Create a copy of AudioTrack
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? artist = null,
    Object? url = null,
    Object? duration = null,
    Object? albumCover = freezed,
    Object? lastPlayed = freezed,
    Object? playCount = null,
  }) {
    return _then(
      _self.copyWith(
        id: null == id
            ? _self.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _self.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        artist: null == artist
            ? _self.artist
            : artist // ignore: cast_nullable_to_non_nullable
                  as String,
        url: null == url
            ? _self.url
            : url // ignore: cast_nullable_to_non_nullable
                  as String,
        duration: null == duration
            ? _self.duration
            : duration // ignore: cast_nullable_to_non_nullable
                  as int,
        albumCover: freezed == albumCover
            ? _self.albumCover
            : albumCover // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastPlayed: freezed == lastPlayed
            ? _self.lastPlayed
            : lastPlayed // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        playCount: null == playCount
            ? _self.playCount
            : playCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _AudioTrack implements AudioTrack {
  const _AudioTrack({
    required this.id,
    required this.title,
    required this.artist,
    required this.url,
    required this.duration,
    this.albumCover,
    this.lastPlayed,
    this.playCount = 0,
  });
  factory _AudioTrack.fromJson(Map<String, dynamic> json) =>
      _$AudioTrackFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String artist;
  @override
  final String url;
  @override
  final int duration;
  @override
  final String? albumCover;
  @override
  final DateTime? lastPlayed;
  @override
  @JsonKey()
  final int playCount;

  /// Create a copy of AudioTrack
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AudioTrackCopyWith<_AudioTrack> get copyWith =>
      __$AudioTrackCopyWithImpl<_AudioTrack>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AudioTrackToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AudioTrack &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.artist, artist) || other.artist == artist) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.albumCover, albumCover) ||
                other.albumCover == albumCover) &&
            (identical(other.lastPlayed, lastPlayed) ||
                other.lastPlayed == lastPlayed) &&
            (identical(other.playCount, playCount) ||
                other.playCount == playCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    artist,
    url,
    duration,
    albumCover,
    lastPlayed,
    playCount,
  );

  @override
  String toString() {
    return 'AudioTrack(id: $id, title: $title, artist: $artist, url: $url, duration: $duration, albumCover: $albumCover, lastPlayed: $lastPlayed, playCount: $playCount)';
  }
}

/// @nodoc
abstract mixin class _$AudioTrackCopyWith<$Res>
    implements $AudioTrackCopyWith<$Res> {
  factory _$AudioTrackCopyWith(
    _AudioTrack value,
    $Res Function(_AudioTrack) _then,
  ) = __$AudioTrackCopyWithImpl;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String artist,
    String url,
    int duration,
    String? albumCover,
    DateTime? lastPlayed,
    int playCount,
  });
}

/// @nodoc
class __$AudioTrackCopyWithImpl<$Res> implements _$AudioTrackCopyWith<$Res> {
  __$AudioTrackCopyWithImpl(this._self, this._then);

  final _AudioTrack _self;
  final $Res Function(_AudioTrack) _then;

  /// Create a copy of AudioTrack
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? artist = null,
    Object? url = null,
    Object? duration = null,
    Object? albumCover = freezed,
    Object? lastPlayed = freezed,
    Object? playCount = null,
  }) {
    return _then(
      _AudioTrack(
        id: null == id
            ? _self.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _self.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        artist: null == artist
            ? _self.artist
            : artist // ignore: cast_nullable_to_non_nullable
                  as String,
        url: null == url
            ? _self.url
            : url // ignore: cast_nullable_to_non_nullable
                  as String,
        duration: null == duration
            ? _self.duration
            : duration // ignore: cast_nullable_to_non_nullable
                  as int,
        albumCover: freezed == albumCover
            ? _self.albumCover
            : albumCover // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastPlayed: freezed == lastPlayed
            ? _self.lastPlayed
            : lastPlayed // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        playCount: null == playCount
            ? _self.playCount
            : playCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}
