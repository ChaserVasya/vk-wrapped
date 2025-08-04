// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../track_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TrackSession _$TrackSessionFromJson(Map<String, dynamic> json) =>
    _TrackSession(
      fullId: json['fullId'] as String,
      firstObserved: (json['firstObserved'] as num).toInt(),
      lastSeen: (json['lastSeen'] as num).toInt(),
    );

Map<String, dynamic> _$TrackSessionToJson(_TrackSession instance) =>
    <String, dynamic>{
      'fullId': instance.fullId,
      'firstObserved': instance.firstObserved,
      'lastSeen': instance.lastSeen,
    };
