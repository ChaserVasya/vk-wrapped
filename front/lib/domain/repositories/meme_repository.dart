import 'package:front/data/remote/api/meme_api_client.dart';
import 'package:front/domain/entities/meme_response.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class MemeRepository {
  final MemeApiClient _memeApiClient;

  const MemeRepository(this._memeApiClient);

  Future<MemeResponse> getMeme() async {
    return await _memeApiClient.getMeme();
  }

  Future<void> toggleMemeLike({required String memeId}) async {
    await _memeApiClient.toggleMemeLike(memeId: memeId);
  }

  Future<List<String>> getLikedMemes() async {
    return await _memeApiClient.getLikedMemes();
  }
}
