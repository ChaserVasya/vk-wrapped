// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token_setup_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TokenSetupEffect {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is TokenSetupEffect);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'TokenSetupEffect()';
  }
}

/// @nodoc
class $TokenSetupEffectCopyWith<$Res> {
  $TokenSetupEffectCopyWith(
    TokenSetupEffect _,
    $Res Function(TokenSetupEffect) __,
  );
}

/// Adds pattern-matching-related methods to [TokenSetupEffect].
extension TokenSetupEffectPatterns on TokenSetupEffect {
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
    TResult Function(TokenSetupEffect$Finish value)? finish,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case TokenSetupEffect$Finish() when finish != null:
        return finish(_that);
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
    required TResult Function(TokenSetupEffect$Finish value) finish,
  }) {
    final _that = this;
    switch (_that) {
      case TokenSetupEffect$Finish():
        return finish(_that);
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
    TResult? Function(TokenSetupEffect$Finish value)? finish,
  }) {
    final _that = this;
    switch (_that) {
      case TokenSetupEffect$Finish() when finish != null:
        return finish(_that);
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
    TResult Function()? finish,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case TokenSetupEffect$Finish() when finish != null:
        return finish();
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
  TResult when<TResult extends Object?>({required TResult Function() finish}) {
    final _that = this;
    switch (_that) {
      case TokenSetupEffect$Finish():
        return finish();
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
  TResult? whenOrNull<TResult extends Object?>({TResult? Function()? finish}) {
    final _that = this;
    switch (_that) {
      case TokenSetupEffect$Finish() when finish != null:
        return finish();
      case _:
        return null;
    }
  }
}

/// @nodoc

class TokenSetupEffect$Finish implements TokenSetupEffect {
  const TokenSetupEffect$Finish();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is TokenSetupEffect$Finish);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'TokenSetupEffect.finish()';
  }
}

/// @nodoc
mixin _$TokenSetupEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is TokenSetupEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'TokenSetupEvent()';
  }
}

/// @nodoc
class $TokenSetupEventCopyWith<$Res> {
  $TokenSetupEventCopyWith(
    TokenSetupEvent _,
    $Res Function(TokenSetupEvent) __,
  );
}

/// Adds pattern-matching-related methods to [TokenSetupEvent].
extension TokenSetupEventPatterns on TokenSetupEvent {
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
    TResult Function(_VkTokenResponseProvided value)? vkTokenResponseProvided,
    TResult Function(_VkAppIdSaved value)? vkAppIdSaved,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VkTokenResponseProvided() when vkTokenResponseProvided != null:
        return vkTokenResponseProvided(_that);
      case _VkAppIdSaved() when vkAppIdSaved != null:
        return vkAppIdSaved(_that);
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
    required TResult Function(_VkTokenResponseProvided value)
    vkTokenResponseProvided,
    required TResult Function(_VkAppIdSaved value) vkAppIdSaved,
  }) {
    final _that = this;
    switch (_that) {
      case _VkTokenResponseProvided():
        return vkTokenResponseProvided(_that);
      case _VkAppIdSaved():
        return vkAppIdSaved(_that);
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
    TResult? Function(_VkTokenResponseProvided value)? vkTokenResponseProvided,
    TResult? Function(_VkAppIdSaved value)? vkAppIdSaved,
  }) {
    final _that = this;
    switch (_that) {
      case _VkTokenResponseProvided() when vkTokenResponseProvided != null:
        return vkTokenResponseProvided(_that);
      case _VkAppIdSaved() when vkAppIdSaved != null:
        return vkAppIdSaved(_that);
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
    TResult Function(String url)? vkTokenResponseProvided,
    TResult Function(String vkAppId)? vkAppIdSaved,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VkTokenResponseProvided() when vkTokenResponseProvided != null:
        return vkTokenResponseProvided(_that.url);
      case _VkAppIdSaved() when vkAppIdSaved != null:
        return vkAppIdSaved(_that.vkAppId);
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
    required TResult Function(String url) vkTokenResponseProvided,
    required TResult Function(String vkAppId) vkAppIdSaved,
  }) {
    final _that = this;
    switch (_that) {
      case _VkTokenResponseProvided():
        return vkTokenResponseProvided(_that.url);
      case _VkAppIdSaved():
        return vkAppIdSaved(_that.vkAppId);
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
    TResult? Function(String url)? vkTokenResponseProvided,
    TResult? Function(String vkAppId)? vkAppIdSaved,
  }) {
    final _that = this;
    switch (_that) {
      case _VkTokenResponseProvided() when vkTokenResponseProvided != null:
        return vkTokenResponseProvided(_that.url);
      case _VkAppIdSaved() when vkAppIdSaved != null:
        return vkAppIdSaved(_that.vkAppId);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _VkTokenResponseProvided implements TokenSetupEvent {
  const _VkTokenResponseProvided(this.url);

  final String url;

  /// Create a copy of TokenSetupEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$VkTokenResponseProvidedCopyWith<_VkTokenResponseProvided> get copyWith =>
      __$VkTokenResponseProvidedCopyWithImpl<_VkTokenResponseProvided>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _VkTokenResponseProvided &&
            (identical(other.url, url) || other.url == url));
  }

  @override
  int get hashCode => Object.hash(runtimeType, url);

  @override
  String toString() {
    return 'TokenSetupEvent.vkTokenResponseProvided(url: $url)';
  }
}

/// @nodoc
abstract mixin class _$VkTokenResponseProvidedCopyWith<$Res>
    implements $TokenSetupEventCopyWith<$Res> {
  factory _$VkTokenResponseProvidedCopyWith(
    _VkTokenResponseProvided value,
    $Res Function(_VkTokenResponseProvided) _then,
  ) = __$VkTokenResponseProvidedCopyWithImpl;
  @useResult
  $Res call({String url});
}

/// @nodoc
class __$VkTokenResponseProvidedCopyWithImpl<$Res>
    implements _$VkTokenResponseProvidedCopyWith<$Res> {
  __$VkTokenResponseProvidedCopyWithImpl(this._self, this._then);

  final _VkTokenResponseProvided _self;
  final $Res Function(_VkTokenResponseProvided) _then;

  /// Create a copy of TokenSetupEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? url = null}) {
    return _then(
      _VkTokenResponseProvided(
        null == url
            ? _self.url
            : url // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _VkAppIdSaved implements TokenSetupEvent {
  const _VkAppIdSaved(this.vkAppId);

  final String vkAppId;

  /// Create a copy of TokenSetupEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$VkAppIdSavedCopyWith<_VkAppIdSaved> get copyWith =>
      __$VkAppIdSavedCopyWithImpl<_VkAppIdSaved>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _VkAppIdSaved &&
            (identical(other.vkAppId, vkAppId) || other.vkAppId == vkAppId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, vkAppId);

  @override
  String toString() {
    return 'TokenSetupEvent.vkAppIdSaved(vkAppId: $vkAppId)';
  }
}

/// @nodoc
abstract mixin class _$VkAppIdSavedCopyWith<$Res>
    implements $TokenSetupEventCopyWith<$Res> {
  factory _$VkAppIdSavedCopyWith(
    _VkAppIdSaved value,
    $Res Function(_VkAppIdSaved) _then,
  ) = __$VkAppIdSavedCopyWithImpl;
  @useResult
  $Res call({String vkAppId});
}

/// @nodoc
class __$VkAppIdSavedCopyWithImpl<$Res>
    implements _$VkAppIdSavedCopyWith<$Res> {
  __$VkAppIdSavedCopyWithImpl(this._self, this._then);

  final _VkAppIdSaved _self;
  final $Res Function(_VkAppIdSaved) _then;

  /// Create a copy of TokenSetupEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? vkAppId = null}) {
    return _then(
      _VkAppIdSaved(
        null == vkAppId
            ? _self.vkAppId
            : vkAppId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
mixin _$TokenSetupState {
  String get vkAppId;
  String? get currentToken;
  String? get tokenGenerationUrl;

  /// Create a copy of TokenSetupState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TokenSetupStateCopyWith<TokenSetupState> get copyWith =>
      _$TokenSetupStateCopyWithImpl<TokenSetupState>(
        this as TokenSetupState,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TokenSetupState &&
            (identical(other.vkAppId, vkAppId) || other.vkAppId == vkAppId) &&
            (identical(other.currentToken, currentToken) ||
                other.currentToken == currentToken) &&
            (identical(other.tokenGenerationUrl, tokenGenerationUrl) ||
                other.tokenGenerationUrl == tokenGenerationUrl));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, vkAppId, currentToken, tokenGenerationUrl);

  @override
  String toString() {
    return 'TokenSetupState(vkAppId: $vkAppId, currentToken: $currentToken, tokenGenerationUrl: $tokenGenerationUrl)';
  }
}

/// @nodoc
abstract mixin class $TokenSetupStateCopyWith<$Res> {
  factory $TokenSetupStateCopyWith(
    TokenSetupState value,
    $Res Function(TokenSetupState) _then,
  ) = _$TokenSetupStateCopyWithImpl;
  @useResult
  $Res call({String vkAppId, String? currentToken, String? tokenGenerationUrl});
}

/// @nodoc
class _$TokenSetupStateCopyWithImpl<$Res>
    implements $TokenSetupStateCopyWith<$Res> {
  _$TokenSetupStateCopyWithImpl(this._self, this._then);

  final TokenSetupState _self;
  final $Res Function(TokenSetupState) _then;

  /// Create a copy of TokenSetupState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? vkAppId = null,
    Object? currentToken = freezed,
    Object? tokenGenerationUrl = freezed,
  }) {
    return _then(
      _self.copyWith(
        vkAppId: null == vkAppId
            ? _self.vkAppId
            : vkAppId // ignore: cast_nullable_to_non_nullable
                  as String,
        currentToken: freezed == currentToken
            ? _self.currentToken
            : currentToken // ignore: cast_nullable_to_non_nullable
                  as String?,
        tokenGenerationUrl: freezed == tokenGenerationUrl
            ? _self.tokenGenerationUrl
            : tokenGenerationUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [TokenSetupState].
extension TokenSetupStatePatterns on TokenSetupState {
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
    TResult Function(TokenSetupState$DataLoaded value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case TokenSetupState$DataLoaded() when $default != null:
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
    TResult Function(TokenSetupState$DataLoaded value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case TokenSetupState$DataLoaded():
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
    TResult? Function(TokenSetupState$DataLoaded value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case TokenSetupState$DataLoaded() when $default != null:
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
      String vkAppId,
      String? currentToken,
      String? tokenGenerationUrl,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case TokenSetupState$DataLoaded() when $default != null:
        return $default(
          _that.vkAppId,
          _that.currentToken,
          _that.tokenGenerationUrl,
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
      String vkAppId,
      String? currentToken,
      String? tokenGenerationUrl,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case TokenSetupState$DataLoaded():
        return $default(
          _that.vkAppId,
          _that.currentToken,
          _that.tokenGenerationUrl,
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
      String vkAppId,
      String? currentToken,
      String? tokenGenerationUrl,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case TokenSetupState$DataLoaded() when $default != null:
        return $default(
          _that.vkAppId,
          _that.currentToken,
          _that.tokenGenerationUrl,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc

class TokenSetupState$DataLoaded implements TokenSetupState {
  const TokenSetupState$DataLoaded({
    required this.vkAppId,
    required this.currentToken,
    required this.tokenGenerationUrl,
  });

  @override
  final String vkAppId;
  @override
  final String? currentToken;
  @override
  final String? tokenGenerationUrl;

  /// Create a copy of TokenSetupState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TokenSetupState$DataLoadedCopyWith<TokenSetupState$DataLoaded>
  get copyWith =>
      _$TokenSetupState$DataLoadedCopyWithImpl<TokenSetupState$DataLoaded>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TokenSetupState$DataLoaded &&
            (identical(other.vkAppId, vkAppId) || other.vkAppId == vkAppId) &&
            (identical(other.currentToken, currentToken) ||
                other.currentToken == currentToken) &&
            (identical(other.tokenGenerationUrl, tokenGenerationUrl) ||
                other.tokenGenerationUrl == tokenGenerationUrl));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, vkAppId, currentToken, tokenGenerationUrl);

  @override
  String toString() {
    return 'TokenSetupState(vkAppId: $vkAppId, currentToken: $currentToken, tokenGenerationUrl: $tokenGenerationUrl)';
  }
}

/// @nodoc
abstract mixin class $TokenSetupState$DataLoadedCopyWith<$Res>
    implements $TokenSetupStateCopyWith<$Res> {
  factory $TokenSetupState$DataLoadedCopyWith(
    TokenSetupState$DataLoaded value,
    $Res Function(TokenSetupState$DataLoaded) _then,
  ) = _$TokenSetupState$DataLoadedCopyWithImpl;
  @override
  @useResult
  $Res call({String vkAppId, String? currentToken, String? tokenGenerationUrl});
}

/// @nodoc
class _$TokenSetupState$DataLoadedCopyWithImpl<$Res>
    implements $TokenSetupState$DataLoadedCopyWith<$Res> {
  _$TokenSetupState$DataLoadedCopyWithImpl(this._self, this._then);

  final TokenSetupState$DataLoaded _self;
  final $Res Function(TokenSetupState$DataLoaded) _then;

  /// Create a copy of TokenSetupState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? vkAppId = null,
    Object? currentToken = freezed,
    Object? tokenGenerationUrl = freezed,
  }) {
    return _then(
      TokenSetupState$DataLoaded(
        vkAppId: null == vkAppId
            ? _self.vkAppId
            : vkAppId // ignore: cast_nullable_to_non_nullable
                  as String,
        currentToken: freezed == currentToken
            ? _self.currentToken
            : currentToken // ignore: cast_nullable_to_non_nullable
                  as String?,
        tokenGenerationUrl: freezed == tokenGenerationUrl
            ? _self.tokenGenerationUrl
            : tokenGenerationUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}
