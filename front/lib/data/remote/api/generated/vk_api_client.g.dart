// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../vk_api_client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VkAudioResponse _$VkAudioResponseFromJson(Map<String, dynamic> json) =>
    VkAudioResponse(
      response: IList<VkAudioTrack>.fromJson(
        json['response'],
        (value) => VkAudioTrack.fromJson(value as Map<String, dynamic>),
      ),
    );

Map<String, dynamic> _$VkAudioResponseToJson(VkAudioResponse instance) =>
    <String, dynamic>{'response': instance.response.toJson((value) => value)};

VkAudioTrack _$VkAudioTrackFromJson(Map<String, dynamic> json) => VkAudioTrack(
  id: (json['id'] as num).toInt(),
  ownerId: (json['ownerId'] as num).toInt(),
  title: json['title'] as String,
  artist: json['artist'] as String,
  duration: (json['duration'] as num).toInt(),
  url: json['url'] as String,
);

Map<String, dynamic> _$VkAudioTrackToJson(VkAudioTrack instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ownerId': instance.ownerId,
      'title': instance.title,
      'artist': instance.artist,
      'duration': instance.duration,
      'url': instance.url,
    };

VkArtist _$VkArtistFromJson(Map<String, dynamic> json) => VkArtist(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  domain: json['domain'] as String?,
  photo: json['photo'] as String?,
);

Map<String, dynamic> _$VkArtistToJson(VkArtist instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'domain': instance.domain,
  'photo': instance.photo,
};

VkError _$VkErrorFromJson(Map<String, dynamic> json) => VkError(
  errorCode: (json['error_code'] as num).toInt(),
  errorMsg: json['error_msg'] as String,
  requestParams: (json['request_params'] as List<dynamic>?)
      ?.map((e) => VkRequestParam.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$VkErrorToJson(VkError instance) => <String, dynamic>{
  'error_code': instance.errorCode,
  'error_msg': instance.errorMsg,
  'request_params': instance.requestParams,
};

VkRequestParam _$VkRequestParamFromJson(Map<String, dynamic> json) =>
    VkRequestParam(key: json['key'] as String, value: json['value'] as String);

Map<String, dynamic> _$VkRequestParamToJson(VkRequestParam instance) =>
    <String, dynamic>{'key': instance.key, 'value': instance.value};

VkErrorResponse _$VkErrorResponseFromJson(Map<String, dynamic> json) =>
    VkErrorResponse(
      error: VkError.fromJson(json['error'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VkErrorResponseToJson(VkErrorResponse instance) =>
    <String, dynamic>{'error': instance.error};

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element,unnecessary_string_interpolations

class _VkApiClient implements VkApiClient {
  _VkApiClient(this._dio, {this.baseUrl, this.errorLogger}) {
    baseUrl ??= 'https://api.vk.com/method';
  }

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<VkAudioResponse> getAudioById({
    required String audios,
    required String accessToken,
    String version = '5.131',
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'audios': audios,
      r'access_token': accessToken,
      r'v': version,
    };
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<VkAudioResponse>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/audio.getById',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late VkAudioResponse _value;
    try {
      _value = VkAudioResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(String dioBaseUrl, String? baseUrl) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
