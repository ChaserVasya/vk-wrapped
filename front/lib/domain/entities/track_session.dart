import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/track_session.freezed.dart';
part 'generated/track_session.g.dart';

@freezed
abstract class TrackSession with _$TrackSession {
  const factory TrackSession({
    required String fullId,
    required int firstObserved,
    required int lastSeen,
  }) = _TrackSession;

  factory TrackSession.fromJson(Map<String, dynamic> json) =>
      _$TrackSessionFromJson(json);
}
