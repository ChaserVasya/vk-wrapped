import 'dart:convert';
import 'dart:io';

/// Клиент для работы с VK API
class VkApiClient {
  static const String _apiVersion = '5.131';
  static const String _baseUrl = 'https://api.vk.com/method';

  final String _token;

  VkApiClient(this._token);

  /// Выполняет запрос к VK API
  Future<Map<String, dynamic>> _makeApiRequest(
    String method,
    Map<String, String> params,
  ) async {
    final queryParams = {'access_token': _token, 'v': _apiVersion, ...params};

    final uri = Uri.parse(
      '$_baseUrl/$method',
    ).replace(queryParameters: queryParams);

    try {
      final response = await HttpClient()
          .getUrl(uri)
          .then((request) => request.close());
      final responseBody = await response.transform(utf8.decoder).join();

      if (response.statusCode != 200) {
        throw Exception('HTTP ${response.statusCode}: $responseBody');
      }

      final jsonData = jsonDecode(responseBody);

      if (jsonData['error'] != null) {
        final error = jsonData['error'];
        throw Exception(
          'VK API Error: ${error['error_msg']} (${error['error_code']})',
        );
      }

      return jsonData;
    } catch (e) {
      if (e is Exception) {
        rethrow;
      }
      throw Exception('Network error: $e');
    }
  }

  /// Получает информацию об аудио по ID
  ///
  /// [audioIds] - список ID аудио в формате "owner_id_audio_id"
  /// [return] - информация об аудио треках
  Future<List<Map<String, dynamic>>> getAudioById(List<String> audioIds) async {
    if (audioIds.isEmpty) {
      return [];
    }

    final audiosParam = audioIds.join(',');

    final response = await _makeApiRequest('audio.getById', {
      'audios': audiosParam,
    });

    final items = response['response'] as List;
    return items.cast<Map<String, dynamic>>();
  }

  /// Получает информацию об одном аудио по ID
  Future<Map<String, dynamic>?> getSingleAudioById(String audioId) async {
    final audios = await getAudioById([audioId]);
    return audios.isNotEmpty ? audios.first : null;
  }

  /// Получает аудио пользователя
  Future<List<Map<String, dynamic>>> getUserAudio({
    int? count,
    int? offset,
  }) async {
    final response = await _makeApiRequest('audio.get', {
      if (count != null) 'count': count.toString(),
      if (offset != null) 'offset': offset.toString(),
    });

    final items = response['response']['items'] as List;
    return items.cast<Map<String, dynamic>>();
  }

  /// Получает популярные аудио
  Future<List<Map<String, dynamic>>> getPopularAudio({
    int? count,
    int? offset,
  }) async {
    final response = await _makeApiRequest('audio.getPopular', {
      if (count != null) 'count': count.toString(),
      if (offset != null) 'offset': offset.toString(),
    });

    final items = response['response'] as List;
    return items.cast<Map<String, dynamic>>();
  }
}
