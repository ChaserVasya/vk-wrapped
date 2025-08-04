// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
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

/// @nodoc

class TokenSetupEffect$TokenSaved implements TokenSetupEffect {
  const TokenSetupEffect$TokenSaved();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TokenSetupEffect$TokenSaved);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'TokenSetupEffect.tokenSaved()';
  }
}

/// @nodoc

class TokenSetupEffect$ValidationError implements TokenSetupEffect {
  const TokenSetupEffect$ValidationError({required this.message});

  final String message;

  /// Create a copy of TokenSetupEffect
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TokenSetupEffect$ValidationErrorCopyWith<TokenSetupEffect$ValidationError>
  get copyWith =>
      _$TokenSetupEffect$ValidationErrorCopyWithImpl<
        TokenSetupEffect$ValidationError
      >(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TokenSetupEffect$ValidationError &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'TokenSetupEffect.validationError(message: $message)';
  }
}

/// @nodoc
abstract mixin class $TokenSetupEffect$ValidationErrorCopyWith<$Res>
    implements $TokenSetupEffectCopyWith<$Res> {
  factory $TokenSetupEffect$ValidationErrorCopyWith(
    TokenSetupEffect$ValidationError value,
    $Res Function(TokenSetupEffect$ValidationError) _then,
  ) = _$TokenSetupEffect$ValidationErrorCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$TokenSetupEffect$ValidationErrorCopyWithImpl<$Res>
    implements $TokenSetupEffect$ValidationErrorCopyWith<$Res> {
  _$TokenSetupEffect$ValidationErrorCopyWithImpl(this._self, this._then);

  final TokenSetupEffect$ValidationError _self;
  final $Res Function(TokenSetupEffect$ValidationError) _then;

  /// Create a copy of TokenSetupEffect
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? message = null}) {
    return _then(
      TokenSetupEffect$ValidationError(
        message: null == message
            ? _self.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class TokenSetupEffect$Error implements TokenSetupEffect {
  const TokenSetupEffect$Error({required this.message});

  final String message;

  /// Create a copy of TokenSetupEffect
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TokenSetupEffect$ErrorCopyWith<TokenSetupEffect$Error> get copyWith =>
      _$TokenSetupEffect$ErrorCopyWithImpl<TokenSetupEffect$Error>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TokenSetupEffect$Error &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'TokenSetupEffect.error(message: $message)';
  }
}

/// @nodoc
abstract mixin class $TokenSetupEffect$ErrorCopyWith<$Res>
    implements $TokenSetupEffectCopyWith<$Res> {
  factory $TokenSetupEffect$ErrorCopyWith(
    TokenSetupEffect$Error value,
    $Res Function(TokenSetupEffect$Error) _then,
  ) = _$TokenSetupEffect$ErrorCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$TokenSetupEffect$ErrorCopyWithImpl<$Res>
    implements $TokenSetupEffect$ErrorCopyWith<$Res> {
  _$TokenSetupEffect$ErrorCopyWithImpl(this._self, this._then);

  final TokenSetupEffect$Error _self;
  final $Res Function(TokenSetupEffect$Error) _then;

  /// Create a copy of TokenSetupEffect
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? message = null}) {
    return _then(
      TokenSetupEffect$Error(
        message: null == message
            ? _self.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class TokenSetupEffect$OpenUrl implements TokenSetupEffect {
  const TokenSetupEffect$OpenUrl({required this.url});

  final String url;

  /// Create a copy of TokenSetupEffect
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TokenSetupEffect$OpenUrlCopyWith<TokenSetupEffect$OpenUrl> get copyWith =>
      _$TokenSetupEffect$OpenUrlCopyWithImpl<TokenSetupEffect$OpenUrl>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TokenSetupEffect$OpenUrl &&
            (identical(other.url, url) || other.url == url));
  }

  @override
  int get hashCode => Object.hash(runtimeType, url);

  @override
  String toString() {
    return 'TokenSetupEffect.openUrl(url: $url)';
  }
}

/// @nodoc
abstract mixin class $TokenSetupEffect$OpenUrlCopyWith<$Res>
    implements $TokenSetupEffectCopyWith<$Res> {
  factory $TokenSetupEffect$OpenUrlCopyWith(
    TokenSetupEffect$OpenUrl value,
    $Res Function(TokenSetupEffect$OpenUrl) _then,
  ) = _$TokenSetupEffect$OpenUrlCopyWithImpl;
  @useResult
  $Res call({String url});
}

/// @nodoc
class _$TokenSetupEffect$OpenUrlCopyWithImpl<$Res>
    implements $TokenSetupEffect$OpenUrlCopyWith<$Res> {
  _$TokenSetupEffect$OpenUrlCopyWithImpl(this._self, this._then);

  final TokenSetupEffect$OpenUrl _self;
  final $Res Function(TokenSetupEffect$OpenUrl) _then;

  /// Create a copy of TokenSetupEffect
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? url = null}) {
    return _then(
      TokenSetupEffect$OpenUrl(
        url: null == url
            ? _self.url
            : url // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
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

/// @nodoc

class _LoadCurrentData implements TokenSetupEvent {
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
    return 'TokenSetupEvent.loadCurrentData()';
  }
}

/// @nodoc

class _SaveToken implements TokenSetupEvent {
  const _SaveToken({required this.token, required this.clientId});

  final String token;
  final String clientId;

  /// Create a copy of TokenSetupEvent
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
            (identical(other.token, token) || other.token == token) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, token, clientId);

  @override
  String toString() {
    return 'TokenSetupEvent.saveToken(token: $token, clientId: $clientId)';
  }
}

/// @nodoc
abstract mixin class _$SaveTokenCopyWith<$Res>
    implements $TokenSetupEventCopyWith<$Res> {
  factory _$SaveTokenCopyWith(
    _SaveToken value,
    $Res Function(_SaveToken) _then,
  ) = __$SaveTokenCopyWithImpl;
  @useResult
  $Res call({String token, String clientId});
}

/// @nodoc
class __$SaveTokenCopyWithImpl<$Res> implements _$SaveTokenCopyWith<$Res> {
  __$SaveTokenCopyWithImpl(this._self, this._then);

  final _SaveToken _self;
  final $Res Function(_SaveToken) _then;

  /// Create a copy of TokenSetupEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? token = null, Object? clientId = null}) {
    return _then(
      _SaveToken(
        token: null == token
            ? _self.token
            : token // ignore: cast_nullable_to_non_nullable
                  as String,
        clientId: null == clientId
            ? _self.clientId
            : clientId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _OpenTokenUrl implements TokenSetupEvent {
  const _OpenTokenUrl();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _OpenTokenUrl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'TokenSetupEvent.openTokenUrl()';
  }
}

/// @nodoc
mixin _$TokenSetupState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is TokenSetupState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'TokenSetupState()';
  }
}

/// @nodoc
class $TokenSetupStateCopyWith<$Res> {
  $TokenSetupStateCopyWith(
    TokenSetupState _,
    $Res Function(TokenSetupState) __,
  );
}

/// @nodoc

class TokenSetupState$Initial implements TokenSetupState {
  const TokenSetupState$Initial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is TokenSetupState$Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'TokenSetupState.initial()';
  }
}

/// @nodoc

class TokenSetupState$Loading implements TokenSetupState {
  const TokenSetupState$Loading();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is TokenSetupState$Loading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'TokenSetupState.loading()';
  }
}

/// @nodoc

class TokenSetupState$Saving implements TokenSetupState {
  const TokenSetupState$Saving();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is TokenSetupState$Saving);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'TokenSetupState.saving()';
  }
}

/// @nodoc

class TokenSetupState$DataLoaded implements TokenSetupState {
  const TokenSetupState$DataLoaded({
    required this.currentToken,
    required this.currentClientId,
  });

  final String? currentToken;
  final String currentClientId;

  /// Create a copy of TokenSetupState
  /// with the given fields replaced by the non-null parameter values.
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
            (identical(other.currentToken, currentToken) ||
                other.currentToken == currentToken) &&
            (identical(other.currentClientId, currentClientId) ||
                other.currentClientId == currentClientId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, currentToken, currentClientId);

  @override
  String toString() {
    return 'TokenSetupState.dataLoaded(currentToken: $currentToken, currentClientId: $currentClientId)';
  }
}

/// @nodoc
abstract mixin class $TokenSetupState$DataLoadedCopyWith<$Res>
    implements $TokenSetupStateCopyWith<$Res> {
  factory $TokenSetupState$DataLoadedCopyWith(
    TokenSetupState$DataLoaded value,
    $Res Function(TokenSetupState$DataLoaded) _then,
  ) = _$TokenSetupState$DataLoadedCopyWithImpl;
  @useResult
  $Res call({String? currentToken, String currentClientId});
}

/// @nodoc
class _$TokenSetupState$DataLoadedCopyWithImpl<$Res>
    implements $TokenSetupState$DataLoadedCopyWith<$Res> {
  _$TokenSetupState$DataLoadedCopyWithImpl(this._self, this._then);

  final TokenSetupState$DataLoaded _self;
  final $Res Function(TokenSetupState$DataLoaded) _then;

  /// Create a copy of TokenSetupState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? currentToken = freezed, Object? currentClientId = null}) {
    return _then(
      TokenSetupState$DataLoaded(
        currentToken: freezed == currentToken
            ? _self.currentToken
            : currentToken // ignore: cast_nullable_to_non_nullable
                  as String?,
        currentClientId: null == currentClientId
            ? _self.currentClientId
            : currentClientId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}
