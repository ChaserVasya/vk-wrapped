import 'package:front/domain/entities/audio_track.dart';
import 'package:front/domain/repositories/audio_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUserAudioUseCase {
  final AudioRepository _audioRepository;

  GetUserAudioUseCase(this._audioRepository);

  AudioRepository get repository => _audioRepository;

  Future<List<AudioTrack>> call({int? count, int? offset}) async {
    return await _audioRepository.getUserAudio(count: count, offset: offset);
  }
}
