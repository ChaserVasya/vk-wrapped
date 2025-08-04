// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../audio_track.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AudioTrack _$AudioTrackFromJson(Map<String, dynamic> json) => _AudioTrack(
  id: json['id'] as String,
  title: json['title'] as String,
  artist: json['artist'] as String,
  url: json['url'] as String,
  duration: (json['duration'] as num).toInt(),
  albumCover: json['albumCover'] as String?,
  lastPlayed: json['lastPlayed'] == null
      ? null
      : DateTime.parse(json['lastPlayed'] as String),
  playCount: (json['playCount'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$AudioTrackToJson(_AudioTrack instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'artist': instance.artist,
      'url': instance.url,
      'duration': instance.duration,
      'albumCover': instance.albumCover,
      'lastPlayed': instance.lastPlayed?.toIso8601String(),
      'playCount': instance.playCount,
    };
