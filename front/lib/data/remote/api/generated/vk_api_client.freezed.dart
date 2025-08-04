// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../vk_api_client.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VkAudioTrack {
  int get id;
  int get ownerId;
  String get title;
  String get artist;
  int get duration;
  String get url;

  /// Create a copy of VkAudioTrack
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $VkAudioTrackCopyWith<VkAudioTrack> get copyWith =>
      _$VkAudioTrackCopyWithImpl<VkAudioTrack>(
        this as VkAudioTrack,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is VkAudioTrack &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.artist, artist) || other.artist == artist) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, ownerId, title, artist, duration, url);

  @override
  String toString() {
    return 'VkAudioTrack(id: $id, ownerId: $ownerId, title: $title, artist: $artist, duration: $duration, url: $url)';
  }
}

/// @nodoc
abstract mixin class $VkAudioTrackCopyWith<$Res> {
  factory $VkAudioTrackCopyWith(
    VkAudioTrack value,
    $Res Function(VkAudioTrack) _then,
  ) = _$VkAudioTrackCopyWithImpl;
  @useResult
  $Res call({
    int id,
    int ownerId,
    String title,
    String artist,
    int duration,
    String url,
  });
}

/// @nodoc
class _$VkAudioTrackCopyWithImpl<$Res> implements $VkAudioTrackCopyWith<$Res> {
  _$VkAudioTrackCopyWithImpl(this._self, this._then);

  final VkAudioTrack _self;
  final $Res Function(VkAudioTrack) _then;

  /// Create a copy of VkAudioTrack
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? ownerId = null,
    Object? title = null,
    Object? artist = null,
    Object? duration = null,
    Object? url = null,
  }) {
    return _then(
      VkAudioTrack(
        id: null == id
            ? _self.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        ownerId: null == ownerId
            ? _self.ownerId
            : ownerId // ignore: cast_nullable_to_non_nullable
                  as int,
        title: null == title
            ? _self.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        artist: null == artist
            ? _self.artist
            : artist // ignore: cast_nullable_to_non_nullable
                  as String,
        duration: null == duration
            ? _self.duration
            : duration // ignore: cast_nullable_to_non_nullable
                  as int,
        url: null == url
            ? _self.url
            : url // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}
