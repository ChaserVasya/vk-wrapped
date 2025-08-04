// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audio_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AudioEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AudioEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AudioEvent()';
}


}

/// @nodoc
class $AudioEventCopyWith<$Res>  {
$AudioEventCopyWith(AudioEvent _, $Res Function(AudioEvent) __);
}


/// @nodoc


class _LoadUserAudio implements AudioEvent {
  const _LoadUserAudio({this.count});
  

 final  int? count;

/// Create a copy of AudioEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadUserAudioCopyWith<_LoadUserAudio> get copyWith => __$LoadUserAudioCopyWithImpl<_LoadUserAudio>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadUserAudio&&(identical(other.count, count) || other.count == count));
}


@override
int get hashCode => Object.hash(runtimeType,count);

@override
String toString() {
  return 'AudioEvent.loadUserAudio(count: $count)';
}


}

/// @nodoc
abstract mixin class _$LoadUserAudioCopyWith<$Res> implements $AudioEventCopyWith<$Res> {
  factory _$LoadUserAudioCopyWith(_LoadUserAudio value, $Res Function(_LoadUserAudio) _then) = __$LoadUserAudioCopyWithImpl;
@useResult
$Res call({
 int? count
});




}
/// @nodoc
class __$LoadUserAudioCopyWithImpl<$Res>
    implements _$LoadUserAudioCopyWith<$Res> {
  __$LoadUserAudioCopyWithImpl(this._self, this._then);

  final _LoadUserAudio _self;
  final $Res Function(_LoadUserAudio) _then;

/// Create a copy of AudioEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? count = freezed,}) {
  return _then(_LoadUserAudio(
count: freezed == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class _LoadAudioTracks implements AudioEvent {
  const _LoadAudioTracks({required final  List<String> trackIds}): _trackIds = trackIds;
  

 final  List<String> _trackIds;
 List<String> get trackIds {
  if (_trackIds is EqualUnmodifiableListView) return _trackIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_trackIds);
}


/// Create a copy of AudioEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadAudioTracksCopyWith<_LoadAudioTracks> get copyWith => __$LoadAudioTracksCopyWithImpl<_LoadAudioTracks>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadAudioTracks&&const DeepCollectionEquality().equals(other._trackIds, _trackIds));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_trackIds));

@override
String toString() {
  return 'AudioEvent.loadAudioTracks(trackIds: $trackIds)';
}


}

/// @nodoc
abstract mixin class _$LoadAudioTracksCopyWith<$Res> implements $AudioEventCopyWith<$Res> {
  factory _$LoadAudioTracksCopyWith(_LoadAudioTracks value, $Res Function(_LoadAudioTracks) _then) = __$LoadAudioTracksCopyWithImpl;
@useResult
$Res call({
 List<String> trackIds
});




}
/// @nodoc
class __$LoadAudioTracksCopyWithImpl<$Res>
    implements _$LoadAudioTracksCopyWith<$Res> {
  __$LoadAudioTracksCopyWithImpl(this._self, this._then);

  final _LoadAudioTracks _self;
  final $Res Function(_LoadAudioTracks) _then;

/// Create a copy of AudioEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? trackIds = null,}) {
  return _then(_LoadAudioTracks(
trackIds: null == trackIds ? _self._trackIds : trackIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc


class _SetToken implements AudioEvent {
  const _SetToken({required this.token});
  

 final  String token;

/// Create a copy of AudioEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SetTokenCopyWith<_SetToken> get copyWith => __$SetTokenCopyWithImpl<_SetToken>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SetToken&&(identical(other.token, token) || other.token == token));
}


@override
int get hashCode => Object.hash(runtimeType,token);

@override
String toString() {
  return 'AudioEvent.setToken(token: $token)';
}


}

/// @nodoc
abstract mixin class _$SetTokenCopyWith<$Res> implements $AudioEventCopyWith<$Res> {
  factory _$SetTokenCopyWith(_SetToken value, $Res Function(_SetToken) _then) = __$SetTokenCopyWithImpl;
@useResult
$Res call({
 String token
});




}
/// @nodoc
class __$SetTokenCopyWithImpl<$Res>
    implements _$SetTokenCopyWith<$Res> {
  __$SetTokenCopyWithImpl(this._self, this._then);

  final _SetToken _self;
  final $Res Function(_SetToken) _then;

/// Create a copy of AudioEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? token = null,}) {
  return _then(_SetToken(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ClearCache implements AudioEvent {
  const _ClearCache();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClearCache);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AudioEvent.clearCache()';
}


}




/// @nodoc
mixin _$AudioState {

 CommonStates<List<AudioTrack>> get tracks; CommonStates<String> get token;
/// Create a copy of AudioState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AudioStateCopyWith<AudioState> get copyWith => _$AudioStateCopyWithImpl<AudioState>(this as AudioState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AudioState&&(identical(other.tracks, tracks) || other.tracks == tracks)&&(identical(other.token, token) || other.token == token));
}


@override
int get hashCode => Object.hash(runtimeType,tracks,token);

@override
String toString() {
  return 'AudioState(tracks: $tracks, token: $token)';
}


}

/// @nodoc
abstract mixin class $AudioStateCopyWith<$Res>  {
  factory $AudioStateCopyWith(AudioState value, $Res Function(AudioState) _then) = _$AudioStateCopyWithImpl;
@useResult
$Res call({
 CommonStates<List<AudioTrack>> tracks, CommonStates<String> token
});




}
/// @nodoc
class _$AudioStateCopyWithImpl<$Res>
    implements $AudioStateCopyWith<$Res> {
  _$AudioStateCopyWithImpl(this._self, this._then);

  final AudioState _self;
  final $Res Function(AudioState) _then;

/// Create a copy of AudioState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tracks = null,Object? token = null,}) {
  return _then(AudioState(
tracks: null == tracks ? _self.tracks : tracks // ignore: cast_nullable_to_non_nullable
as CommonStates<List<AudioTrack>>,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as CommonStates<String>,
  ));
}

}


// dart format on
