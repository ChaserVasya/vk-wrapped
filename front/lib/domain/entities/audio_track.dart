import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/audio_track.freezed.dart';
part 'generated/audio_track.g.dart';

@freezed
abstract class AudioTrack with _$AudioTrack {
  const factory AudioTrack({
    required String id,
    required String title,
    required String artist,
    required String url,
    required int duration,
    String? albumCover,
    DateTime? lastPlayed,
    @Default(0) int playCount,
  }) = _AudioTrack;

  factory AudioTrack.fromJson(Map<String, dynamic> json) =>
      _$AudioTrackFromJson(json);
}
