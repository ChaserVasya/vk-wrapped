// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../meme_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MemeResponse {
  @JsonKey(name: 'meme_id')
  String get memeId;
  String get url;
  @JsonKey(name: 'is_liked')
  bool get isLiked;

  /// Create a copy of MemeResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MemeResponseCopyWith<MemeResponse> get copyWith =>
      _$MemeResponseCopyWithImpl<MemeResponse>(
        this as MemeResponse,
        _$identity,
      );

  /// Serializes this MemeResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MemeResponse &&
            (identical(other.memeId, memeId) || other.memeId == memeId) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.isLiked, isLiked) || other.isLiked == isLiked));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, memeId, url, isLiked);

  @override
  String toString() {
    return 'MemeResponse(memeId: $memeId, url: $url, isLiked: $isLiked)';
  }
}

/// @nodoc
abstract mixin class $MemeResponseCopyWith<$Res> {
  factory $MemeResponseCopyWith(
    MemeResponse value,
    $Res Function(MemeResponse) _then,
  ) = _$MemeResponseCopyWithImpl;
  @useResult
  $Res call({
    @JsonKey(name: 'meme_id') String memeId,
    String url,
    @JsonKey(name: 'is_liked') bool isLiked,
  });
}

/// @nodoc
class _$MemeResponseCopyWithImpl<$Res> implements $MemeResponseCopyWith<$Res> {
  _$MemeResponseCopyWithImpl(this._self, this._then);

  final MemeResponse _self;
  final $Res Function(MemeResponse) _then;

  /// Create a copy of MemeResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? memeId = null,
    Object? url = null,
    Object? isLiked = null,
  }) {
    return _then(
      _self.copyWith(
        memeId: null == memeId
            ? _self.memeId
            : memeId // ignore: cast_nullable_to_non_nullable
                  as String,
        url: null == url
            ? _self.url
            : url // ignore: cast_nullable_to_non_nullable
                  as String,
        isLiked: null == isLiked
            ? _self.isLiked
            : isLiked // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [MemeResponse].
extension MemeResponsePatterns on MemeResponse {
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
    TResult Function(_MemeResponse value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MemeResponse() when $default != null:
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
    TResult Function(_MemeResponse value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MemeResponse():
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
    TResult? Function(_MemeResponse value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MemeResponse() when $default != null:
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
      @JsonKey(name: 'meme_id') String memeId,
      String url,
      @JsonKey(name: 'is_liked') bool isLiked,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MemeResponse() when $default != null:
        return $default(_that.memeId, _that.url, _that.isLiked);
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
      @JsonKey(name: 'meme_id') String memeId,
      String url,
      @JsonKey(name: 'is_liked') bool isLiked,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MemeResponse():
        return $default(_that.memeId, _that.url, _that.isLiked);
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
      @JsonKey(name: 'meme_id') String memeId,
      String url,
      @JsonKey(name: 'is_liked') bool isLiked,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MemeResponse() when $default != null:
        return $default(_that.memeId, _that.url, _that.isLiked);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _MemeResponse implements MemeResponse {
  const _MemeResponse({
    @JsonKey(name: 'meme_id') required this.memeId,
    required this.url,
    @JsonKey(name: 'is_liked') required this.isLiked,
  });
  factory _MemeResponse.fromJson(Map<String, dynamic> json) =>
      _$MemeResponseFromJson(json);

  @override
  @JsonKey(name: 'meme_id')
  final String memeId;
  @override
  final String url;
  @override
  @JsonKey(name: 'is_liked')
  final bool isLiked;

  /// Create a copy of MemeResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MemeResponseCopyWith<_MemeResponse> get copyWith =>
      __$MemeResponseCopyWithImpl<_MemeResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MemeResponseToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MemeResponse &&
            (identical(other.memeId, memeId) || other.memeId == memeId) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.isLiked, isLiked) || other.isLiked == isLiked));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, memeId, url, isLiked);

  @override
  String toString() {
    return 'MemeResponse(memeId: $memeId, url: $url, isLiked: $isLiked)';
  }
}

/// @nodoc
abstract mixin class _$MemeResponseCopyWith<$Res>
    implements $MemeResponseCopyWith<$Res> {
  factory _$MemeResponseCopyWith(
    _MemeResponse value,
    $Res Function(_MemeResponse) _then,
  ) = __$MemeResponseCopyWithImpl;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'meme_id') String memeId,
    String url,
    @JsonKey(name: 'is_liked') bool isLiked,
  });
}

/// @nodoc
class __$MemeResponseCopyWithImpl<$Res>
    implements _$MemeResponseCopyWith<$Res> {
  __$MemeResponseCopyWithImpl(this._self, this._then);

  final _MemeResponse _self;
  final $Res Function(_MemeResponse) _then;

  /// Create a copy of MemeResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? memeId = null,
    Object? url = null,
    Object? isLiked = null,
  }) {
    return _then(
      _MemeResponse(
        memeId: null == memeId
            ? _self.memeId
            : memeId // ignore: cast_nullable_to_non_nullable
                  as String,
        url: null == url
            ? _self.url
            : url // ignore: cast_nullable_to_non_nullable
                  as String,
        isLiked: null == isLiked
            ? _self.isLiked
            : isLiked // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}
