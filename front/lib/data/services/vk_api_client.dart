import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

part 'generated/vk_api_client.g.dart';

@RestApi(baseUrl: 'https://api.vk.com/method')
abstract class VkApiClient {
  factory VkApiClient(Dio dio, {String baseUrl}) = _VkApiClient;

  @GET('/audio.getById')
  Future<VkAudioResponse> getAudioById({
    @Query('audios') required String audios,
    @Query('access_token') required String accessToken,
    @Query('v') String version = '5.131',
  });

  @GET('/audio.get')
  Future<VkAudioResponse> getUserAudio({
    @Query('count') int? count,
    @Query('offset') int? offset,
    @Query('access_token') required String accessToken,
    @Query('v') String version = '5.131',
  });

  @GET('/audio.getPopular')
  Future<VkAudioResponse> getPopularAudio({
    @Query('count') int? count,
    @Query('offset') int? offset,
    @Query('access_token') required String accessToken,
    @Query('v') String version = '5.131',
  });
}

@JsonSerializable()
class VkAudioResponse {
  final List<VkAudioTrack> response;

  VkAudioResponse({required this.response});

  factory VkAudioResponse.fromJson(Map<String, dynamic> json) =>
      _$VkAudioResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VkAudioResponseToJson(this);
}

@JsonSerializable()
class VkAudioTrack {
  final int id;
  final int ownerId;
  final String title;
  final String artist;
  final int duration;
  final String url;
  @JsonKey(name: 'date')
  final int date;

  VkAudioTrack({
    required this.id,
    required this.ownerId,
    required this.title,
    required this.artist,
    required this.duration,
    required this.url,
    required this.date,
  });

  factory VkAudioTrack.fromJson(Map<String, dynamic> json) =>
      _$VkAudioTrackFromJson(json);

  Map<String, dynamic> toJson() => _$VkAudioTrackToJson(this);
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
