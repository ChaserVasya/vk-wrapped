import 'package:dio/dio.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

part 'generated/vk_api_client.g.dart';
part 'generated/vk_api_client.freezed.dart';

@RestApi(baseUrl: 'https://api.vk.com/method')
abstract class VkApiClient {
  factory VkApiClient(Dio dio, {String baseUrl}) = _VkApiClient;

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

  @override
  final int id;
  @override
  final int ownerId;
  @override
  final String title;
  @override
  final String artist;
  @override
  final int duration;
  @override
  final String url;

  VkAudioTrack({
    required this.id,
    required this.ownerId,
    required this.title,
    required this.artist,
    required this.duration,
    required this.url,
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
