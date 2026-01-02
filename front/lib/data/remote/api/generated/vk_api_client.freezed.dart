// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
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
  int? get date;
  int? get genreId;
  int? get lyricsId;
  VkAlbum? get album;
  List<VkMainArtist>? get mainArtists;

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
            (identical(other.url, url) || other.url == url) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.genreId, genreId) || other.genreId == genreId) &&
            (identical(other.lyricsId, lyricsId) ||
                other.lyricsId == lyricsId) &&
            (identical(other.album, album) || other.album == album) &&
            const DeepCollectionEquality().equals(
              other.mainArtists,
              mainArtists,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    ownerId,
    title,
    artist,
    duration,
    url,
    date,
    genreId,
    lyricsId,
    album,
    const DeepCollectionEquality().hash(mainArtists),
  );

  @override
  String toString() {
    return 'VkAudioTrack(id: $id, ownerId: $ownerId, title: $title, artist: $artist, duration: $duration, url: $url, date: $date, genreId: $genreId, lyricsId: $lyricsId, album: $album, mainArtists: $mainArtists)';
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
    int? date,
    int? genreId,
    int? lyricsId,
    VkAlbum? album,
    List<VkMainArtist>? mainArtists,
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
    Object? date = freezed,
    Object? genreId = freezed,
    Object? lyricsId = freezed,
    Object? album = freezed,
    Object? mainArtists = freezed,
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
        date: freezed == date
            ? _self.date
            : date // ignore: cast_nullable_to_non_nullable
                  as int?,
        genreId: freezed == genreId
            ? _self.genreId
            : genreId // ignore: cast_nullable_to_non_nullable
                  as int?,
        lyricsId: freezed == lyricsId
            ? _self.lyricsId
            : lyricsId // ignore: cast_nullable_to_non_nullable
                  as int?,
        album: freezed == album
            ? _self.album
            : album // ignore: cast_nullable_to_non_nullable
                  as VkAlbum?,
        mainArtists: freezed == mainArtists
            ? _self.mainArtists
            : mainArtists // ignore: cast_nullable_to_non_nullable
                  as List<VkMainArtist>?,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [VkAudioTrack].
extension VkAudioTrackPatterns on VkAudioTrack {
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
  TResult maybeMap<TResult extends Object?>({required TResult orElse()}) {
    final _that = this;
    switch (_that) {
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
  TResult map<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
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
  TResult? mapOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
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
  TResult maybeWhen<TResult extends Object?>({required TResult orElse()}) {
    final _that = this;
    switch (_that) {
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
  TResult when<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
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
  TResult? whenOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }
}
