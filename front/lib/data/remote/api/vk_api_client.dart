import 'package:dio/dio.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'generated/vk_api_client.g.dart';
part 'generated/vk_api_client.freezed.dart';

@lazySingleton
@RestApi(baseUrl: 'https://api.vk.com/method')
abstract class VkApiClient {
  @factoryMethod
  factory VkApiClient(Dio dio) = _VkApiClient;

  @GET('/audio.getById')
  Future<VkAudioResponse> getAudioById({
    @Query('audios') required String audios,
    @Query('access_token') required String accessToken,
    @Query('v') String version = '5.131',
  });
}

@JsonSerializable()
class VkAudioResponse {
  final IList<VkAudioTrack> response;

  VkAudioResponse({required this.response});

  factory VkAudioResponse.fromJson(Map<String, dynamic> json) =>
      _$VkAudioResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VkAudioResponseToJson(this);
}

@freezed
@JsonSerializable()
class VkAudioTrack with _$VkAudioTrack {
  /// Used for search by vk api
  String get fullId => '${ownerId}_$id';

  /// Возвращает DateTime для date (если date не null)
  DateTime? get dateDateTime {
    if (date == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(date! * 1000);
  }

  @override
  @JsonKey(name: 'id')
  final int id;
  @override
  @JsonKey(name: 'owner_id')
  final int ownerId;
  @override
  @JsonKey(name: 'title')
  final String title;
  @override
  @JsonKey(name: 'artist')
  final String artist;
  @override
  @JsonKey(name: 'duration')
  final int duration;
  @override
  @JsonKey(name: 'url')
  final String url;
  @override
  @JsonKey(name: 'date')
  final int? date;
  @override
  @JsonKey(name: 'genre_id')
  final int? genreId;
  @override
  @JsonKey(name: 'lyrics_id')
  final int? lyricsId;

  @override
  @JsonKey(name: 'album')
  final VkAlbum? album;
  @override
  @JsonKey(name: 'main_artists')
  final List<VkMainArtist>? mainArtists;

  const VkAudioTrack({
    required this.id,
    required this.ownerId,
    required this.title,
    required this.artist,
    required this.duration,
    required this.url,
    this.date,
    this.genreId,
    this.lyricsId,
    this.album,
    this.mainArtists,
  });

  factory VkAudioTrack.fromJson(Map<String, dynamic> json) =>
      _$VkAudioTrackFromJson(json);

  Map<String, dynamic> toJson() => _$VkAudioTrackToJson(this);
}

@JsonSerializable()
class VkAlbum {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'owner_id')
  final int ownerId;
  @JsonKey(name: 'thumb')
  final VkThumb? thumb;
  @JsonKey(name: 'main_color')
  final String? mainColor;

  const VkAlbum({
    required this.id,
    required this.title,
    required this.ownerId,
    this.thumb,
    this.mainColor,
  });

  factory VkAlbum.fromJson(Map<String, dynamic> json) =>
      _$VkAlbumFromJson(json);

  Map<String, dynamic> toJson() => _$VkAlbumToJson(this);
}

@JsonSerializable()
class VkThumb {
  @JsonKey(name: 'width')
  final int width;
  @JsonKey(name: 'height')
  final int height;
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'photo_34')
  final String? photo34;
  @JsonKey(name: 'photo_135')
  final String? photo135;
  @JsonKey(name: 'photo_300')
  final String? photo300;
  @JsonKey(name: 'photo_600')
  final String? photo600;

  const VkThumb({
    required this.width,
    required this.height,
    required this.id,
    this.photo34,
    this.photo135,
    this.photo300,
    this.photo600,
  });

  factory VkThumb.fromJson(Map<String, dynamic> json) =>
      _$VkThumbFromJson(json);

  Map<String, dynamic> toJson() => _$VkThumbToJson(this);
}

@JsonSerializable()
class VkMainArtist {
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'domain')
  final String? domain;
  @JsonKey(name: 'id')
  final String id;

  const VkMainArtist({required this.name, this.domain, required this.id});

  factory VkMainArtist.fromJson(Map<String, dynamic> json) =>
      _$VkMainArtistFromJson(json);

  Map<String, dynamic> toJson() => _$VkMainArtistToJson(this);
}

@JsonSerializable()
class VkArtist {
  final int id;
  final String name;
  final String? domain;
  final String? photo;

  VkArtist({required this.id, required this.name, this.domain, this.photo});

  factory VkArtist.fromJson(Map<String, dynamic> json) =>
      _$VkArtistFromJson(json);

  Map<String, dynamic> toJson() => _$VkArtistToJson(this);
}

@JsonSerializable()
class VkError {
  @JsonKey(name: 'error_code')
  final int errorCode;
  @JsonKey(name: 'error_msg')
  final String errorMsg;
  @JsonKey(name: 'request_params')
  final List<VkRequestParam>? requestParams;

  VkError({
    required this.errorCode,
    required this.errorMsg,
    this.requestParams,
  });

  factory VkError.fromJson(Map<String, dynamic> json) =>
      _$VkErrorFromJson(json);

  Map<String, dynamic> toJson() => _$VkErrorToJson(this);
}

@JsonSerializable()
class VkRequestParam {
  final String key;
  final String value;

  VkRequestParam({required this.key, required this.value});

  factory VkRequestParam.fromJson(Map<String, dynamic> json) =>
      _$VkRequestParamFromJson(json);

  Map<String, dynamic> toJson() => _$VkRequestParamToJson(this);
}

@JsonSerializable()
class VkErrorResponse {
  final VkError error;

  VkErrorResponse({required this.error});

  factory VkErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$VkErrorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VkErrorResponseToJson(this);
}
