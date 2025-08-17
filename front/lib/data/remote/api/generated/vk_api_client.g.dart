// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../vk_api_client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VkAudioResponse _$VkAudioResponseFromJson(Map<String, dynamic> json) =>
    VkAudioResponse(
      response: json['response'] == null
          ? null
          : IList<VkAudioTrack>.fromJson(
              json['response'],
              (value) => VkAudioTrack.fromJson(value as Map<String, dynamic>),
            ),
      error: json['error'] == null
          ? null
          : VkError.fromJson(json['error'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VkAudioResponseToJson(VkAudioResponse instance) =>
    <String, dynamic>{
      'response': instance.response?.toJson((value) => value),
      'error': instance.error,
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

VkAudioTrack _$VkAudioTrackFromJson(Map<String, dynamic> json) => VkAudioTrack(
  id: (json['id'] as num).toInt(),
  ownerId: (json['owner_id'] as num).toInt(),
  title: json['title'] as String,
  artist: json['artist'] as String,
  duration: (json['duration'] as num).toInt(),
  url: json['url'] as String,
  date: (json['date'] as num?)?.toInt(),
  genreId: (json['genre_id'] as num?)?.toInt(),
  lyricsId: (json['lyrics_id'] as num?)?.toInt(),
  album: json['album'] == null
      ? null
      : VkAlbum.fromJson(json['album'] as Map<String, dynamic>),
  mainArtists: (json['main_artists'] as List<dynamic>?)
      ?.map((e) => VkMainArtist.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$VkAudioTrackToJson(VkAudioTrack instance) =>
    <String, dynamic>{
      'id': instance.id,
      'owner_id': instance.ownerId,
      'title': instance.title,
      'artist': instance.artist,
      'duration': instance.duration,
      'url': instance.url,
      'date': instance.date,
      'genre_id': instance.genreId,
      'lyrics_id': instance.lyricsId,
      'album': instance.album,
      'main_artists': instance.mainArtists,
    };

VkAlbum _$VkAlbumFromJson(Map<String, dynamic> json) => VkAlbum(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  ownerId: (json['owner_id'] as num).toInt(),
  thumb: json['thumb'] == null
      ? null
      : VkThumb.fromJson(json['thumb'] as Map<String, dynamic>),
  mainColor: json['main_color'] as String?,
);

Map<String, dynamic> _$VkAlbumToJson(VkAlbum instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'owner_id': instance.ownerId,
  'thumb': instance.thumb,
  'main_color': instance.mainColor,
};

VkThumb _$VkThumbFromJson(Map<String, dynamic> json) => VkThumb(
  width: (json['width'] as num).toInt(),
  height: (json['height'] as num).toInt(),
  id: json['id'] as String,
  photo34: json['photo_34'] as String?,
  photo135: json['photo_135'] as String?,
  photo300: json['photo_300'] as String?,
  photo600: json['photo_600'] as String?,
);

Map<String, dynamic> _$VkThumbToJson(VkThumb instance) => <String, dynamic>{
  'width': instance.width,
  'height': instance.height,
  'id': instance.id,
  'photo_34': instance.photo34,
  'photo_135': instance.photo135,
  'photo_300': instance.photo300,
  'photo_600': instance.photo600,
};

VkMainArtist _$VkMainArtistFromJson(Map<String, dynamic> json) => VkMainArtist(
  name: json['name'] as String,
  domain: json['domain'] as String?,
  id: json['id'] as String,
);

Map<String, dynamic> _$VkMainArtistToJson(VkMainArtist instance) =>
    <String, dynamic>{
      'name': instance.name,
      'domain': instance.domain,
      'id': instance.id,
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

VkErrorResponse _$VkErrorResponseFromJson(Map<String, dynamic> json) =>
    VkErrorResponse(
      error: VkError.fromJson(json['error'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VkErrorResponseToJson(VkErrorResponse instance) =>
    <String, dynamic>{'error': instance.error};

VkArtistResponse _$VkArtistResponseFromJson(Map<String, dynamic> json) =>
    VkArtistResponse(
      response: VkArtistInfo.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VkArtistResponseToJson(VkArtistResponse instance) =>
    <String, dynamic>{'response': instance.response};

VkArtistInfo _$VkArtistInfoFromJson(Map<String, dynamic> json) => VkArtistInfo(
  name: json['name'] as String,
  domain: json['domain'] as String?,
  id: json['id'] as String,
  photos: (json['photos'] as List<dynamic>?)
      ?.map((e) => VkArtistPhoto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$VkArtistInfoToJson(VkArtistInfo instance) =>
    <String, dynamic>{
      'name': instance.name,
      'domain': instance.domain,
      'id': instance.id,
      'photos': instance.photos,
    };

VkArtistPhoto _$VkArtistPhotoFromJson(Map<String, dynamic> json) =>
    VkArtistPhoto(
      type: json['type'] as String,
      photo: (json['photo'] as List<dynamic>)
          .map((e) => VkArtistPhotoSize.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VkArtistPhotoToJson(VkArtistPhoto instance) =>
    <String, dynamic>{'type': instance.type, 'photo': instance.photo};

VkArtistPhotoSize _$VkArtistPhotoSizeFromJson(Map<String, dynamic> json) =>
    VkArtistPhotoSize(
      url: json['url'] as String,
      width: (json['width'] as num).toInt(),
      height: (json['height'] as num).toInt(),
    );

Map<String, dynamic> _$VkArtistPhotoSizeToJson(VkArtistPhotoSize instance) =>
    <String, dynamic>{
      'url': instance.url,
      'width': instance.width,
      'height': instance.height,
    };

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

  @override
  Future<VkArtistResponse> getArtistById({
    required String artistId,
    required String accessToken,
    String version = '5.131',
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'artist_id': artistId,
      r'access_token': accessToken,
      r'v': version,
    };
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<VkArtistResponse>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/audio.getArtistById',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late VkArtistResponse _value;
    try {
      _value = VkArtistResponse.fromJson(_result.data!);
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
