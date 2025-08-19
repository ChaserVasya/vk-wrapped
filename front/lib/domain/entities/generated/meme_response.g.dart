// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../meme_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MemeResponse _$MemeResponseFromJson(Map<String, dynamic> json) =>
    _MemeResponse(
      memeId: json['meme_id'] as String,
      url: json['url'] as String,
      isLiked: json['is_liked'] as bool,
    );

Map<String, dynamic> _$MemeResponseToJson(_MemeResponse instance) =>
    <String, dynamic>{
      'meme_id': instance.memeId,
      'url': instance.url,
      'is_liked': instance.isLiked,
    };
