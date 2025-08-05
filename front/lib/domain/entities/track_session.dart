import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/track_session.freezed.dart';
part 'generated/track_session.g.dart';

@freezed
abstract class TrackSession with _$TrackSession {
  const TrackSession._();
  const factory TrackSession({
    required String fullId,

    /// В секундах (Unix timestamp)
    required int firstObserved,

    /// В секундах (Unix timestamp)
    required int lastSeen,
  }) = _TrackSession;

  factory TrackSession.fromJson(Map<String, dynamic> json) =>
      _$TrackSessionFromJson(json);

  /// Возвращает DateTime для firstObserved
  DateTime get firstObservedDateTime {
    return DateTime.fromMillisecondsSinceEpoch(firstObserved * 1000);
  }

  /// Возвращает DateTime для lastSeen
  DateTime get lastSeenDateTime {
    return DateTime.fromMillisecondsSinceEpoch(lastSeen * 1000);
  }

  /// Возвращает день (без времени) для firstObserved
  DateTime get firstObservedDay {
    final dateTime = firstObservedDateTime;
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }
}
