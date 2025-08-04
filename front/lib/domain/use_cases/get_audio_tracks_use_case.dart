import 'package:front/domain/entities/audio_track.dart';
import 'package:front/domain/repositories/audio_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAudioTracksUseCase {
  final AudioRepository _audioRepository;

  GetAudioTracksUseCase(this._audioRepository);

  AudioRepository get repository => _audioRepository;

  Future<List<AudioTrack>> call(List<String> audioIds) async {
    return await _audioRepository.getAudioById(audioIds);
  }
}
