import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:front/data/local/prefs_storage.dart';
import 'package:front/data/remote/api/vk_api_client.dart';
import 'package:front/domain/exceptions/app_exception.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class VkService {
  final VkApiClient _client;
  final PrefsStorage _prefsStorage;

  VkService(this._prefsStorage, this._client);

  Future<IList<VkAudioTrack>> getAudioById(Iterable<String> audioIds) async {
    if (audioIds.isEmpty) {
      return const IListConst([]);
    }
    final audiosParam = audioIds.join(',');
    final res = await _client.getAudioById(
      audios: audiosParam,
      accessToken: _token,
    );
    return res.response;
  }

  String get _token {
    final token = _prefsStorage.getToken();
    if (token == null) {
      throw const AppException('VK Token отсутствует');
    }
    return token;
  }
}
