// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'statistics_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StatisticStateData {
  IList<ArtistStats> get topArtists;
  IList<TrackWithStats> get topTracks;
  IList<({String title, int trackCount, int totalPlayCount, int totalDuration})>
  get tracksWithSameTitle;
  Duration get totalListeningTime;
  int get uniqueTracksCount;
  int get uniqueArtistsCount;
  int get uniqueAlbumsCount;
  int get uniqueGenresCount;
  Duration get averageTrackDuration;
  IList<TimeOfDayStats> get timeOfDayStats;
  IList<DayOfWeekStats> get dayOfWeekStats;
  IList<MonthStats> get monthStats;
  MostActiveDayStats? get mostActiveDay;
  VkAudioTrack? get longestTrack;
  VkAudioTrack? get shortestTrack;
  int get totalPlayCount;

  /// Create a copy of StatisticStateData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $StatisticStateDataCopyWith<StatisticStateData> get copyWith =>
      _$StatisticStateDataCopyWithImpl<StatisticStateData>(
        this as StatisticStateData,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StatisticStateData &&
            const DeepCollectionEquality().equals(
              other.topArtists,
              topArtists,
            ) &&
            const DeepCollectionEquality().equals(other.topTracks, topTracks) &&
            const DeepCollectionEquality().equals(
              other.tracksWithSameTitle,
              tracksWithSameTitle,
            ) &&
            (identical(other.totalListeningTime, totalListeningTime) ||
                other.totalListeningTime == totalListeningTime) &&
            (identical(other.uniqueTracksCount, uniqueTracksCount) ||
                other.uniqueTracksCount == uniqueTracksCount) &&
            (identical(other.uniqueArtistsCount, uniqueArtistsCount) ||
                other.uniqueArtistsCount == uniqueArtistsCount) &&
            (identical(other.uniqueAlbumsCount, uniqueAlbumsCount) ||
                other.uniqueAlbumsCount == uniqueAlbumsCount) &&
            (identical(other.uniqueGenresCount, uniqueGenresCount) ||
                other.uniqueGenresCount == uniqueGenresCount) &&
            (identical(other.averageTrackDuration, averageTrackDuration) ||
                other.averageTrackDuration == averageTrackDuration) &&
            const DeepCollectionEquality().equals(
              other.timeOfDayStats,
              timeOfDayStats,
            ) &&
            const DeepCollectionEquality().equals(
              other.dayOfWeekStats,
              dayOfWeekStats,
            ) &&
            const DeepCollectionEquality().equals(
              other.monthStats,
              monthStats,
            ) &&
            (identical(other.mostActiveDay, mostActiveDay) ||
                other.mostActiveDay == mostActiveDay) &&
            (identical(other.longestTrack, longestTrack) ||
                other.longestTrack == longestTrack) &&
            (identical(other.shortestTrack, shortestTrack) ||
                other.shortestTrack == shortestTrack) &&
            (identical(other.totalPlayCount, totalPlayCount) ||
                other.totalPlayCount == totalPlayCount));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(topArtists),
    const DeepCollectionEquality().hash(topTracks),
    const DeepCollectionEquality().hash(tracksWithSameTitle),
    totalListeningTime,
    uniqueTracksCount,
    uniqueArtistsCount,
    uniqueAlbumsCount,
    uniqueGenresCount,
    averageTrackDuration,
    const DeepCollectionEquality().hash(timeOfDayStats),
    const DeepCollectionEquality().hash(dayOfWeekStats),
    const DeepCollectionEquality().hash(monthStats),
    mostActiveDay,
    longestTrack,
    shortestTrack,
    totalPlayCount,
  );

  @override
  String toString() {
    return 'StatisticStateData(topArtists: $topArtists, topTracks: $topTracks, tracksWithSameTitle: $tracksWithSameTitle, totalListeningTime: $totalListeningTime, uniqueTracksCount: $uniqueTracksCount, uniqueArtistsCount: $uniqueArtistsCount, uniqueAlbumsCount: $uniqueAlbumsCount, uniqueGenresCount: $uniqueGenresCount, averageTrackDuration: $averageTrackDuration, timeOfDayStats: $timeOfDayStats, dayOfWeekStats: $dayOfWeekStats, monthStats: $monthStats, mostActiveDay: $mostActiveDay, longestTrack: $longestTrack, shortestTrack: $shortestTrack, totalPlayCount: $totalPlayCount)';
  }
}

/// @nodoc
abstract mixin class $StatisticStateDataCopyWith<$Res> {
  factory $StatisticStateDataCopyWith(
    StatisticStateData value,
    $Res Function(StatisticStateData) _then,
  ) = _$StatisticStateDataCopyWithImpl;
  @useResult
  $Res call({
    IList<ArtistStats> topArtists,
    IList<TrackWithStats> topTracks,
    IList<
      ({String title, int trackCount, int totalPlayCount, int totalDuration})
    >
    tracksWithSameTitle,
    Duration totalListeningTime,
    int uniqueTracksCount,
    int uniqueArtistsCount,
    int uniqueAlbumsCount,
    int uniqueGenresCount,
    Duration averageTrackDuration,
    IList<TimeOfDayStats> timeOfDayStats,
    IList<DayOfWeekStats> dayOfWeekStats,
    IList<MonthStats> monthStats,
    MostActiveDayStats? mostActiveDay,
    VkAudioTrack? longestTrack,
    VkAudioTrack? shortestTrack,
    int totalPlayCount,
  });

  $VkAudioTrackCopyWith<$Res>? get longestTrack;
  $VkAudioTrackCopyWith<$Res>? get shortestTrack;
}

/// @nodoc
class _$StatisticStateDataCopyWithImpl<$Res>
    implements $StatisticStateDataCopyWith<$Res> {
  _$StatisticStateDataCopyWithImpl(this._self, this._then);

  final StatisticStateData _self;
  final $Res Function(StatisticStateData) _then;

  /// Create a copy of StatisticStateData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? topArtists = null,
    Object? topTracks = null,
    Object? tracksWithSameTitle = null,
    Object? totalListeningTime = null,
    Object? uniqueTracksCount = null,
    Object? uniqueArtistsCount = null,
    Object? uniqueAlbumsCount = null,
    Object? uniqueGenresCount = null,
    Object? averageTrackDuration = null,
    Object? timeOfDayStats = null,
    Object? dayOfWeekStats = null,
    Object? monthStats = null,
    Object? mostActiveDay = freezed,
    Object? longestTrack = freezed,
    Object? shortestTrack = freezed,
    Object? totalPlayCount = null,
  }) {
    return _then(
      _self.copyWith(
        topArtists: null == topArtists
            ? _self.topArtists
            : topArtists // ignore: cast_nullable_to_non_nullable
                  as IList<ArtistStats>,
        topTracks: null == topTracks
            ? _self.topTracks
            : topTracks // ignore: cast_nullable_to_non_nullable
                  as IList<TrackWithStats>,
        tracksWithSameTitle: null == tracksWithSameTitle
            ? _self.tracksWithSameTitle
            : tracksWithSameTitle // ignore: cast_nullable_to_non_nullable
                  as IList<
                    ({
                      String title,
                      int trackCount,
                      int totalPlayCount,
                      int totalDuration,
                    })
                  >,
        totalListeningTime: null == totalListeningTime
            ? _self.totalListeningTime
            : totalListeningTime // ignore: cast_nullable_to_non_nullable
                  as Duration,
        uniqueTracksCount: null == uniqueTracksCount
            ? _self.uniqueTracksCount
            : uniqueTracksCount // ignore: cast_nullable_to_non_nullable
                  as int,
        uniqueArtistsCount: null == uniqueArtistsCount
            ? _self.uniqueArtistsCount
            : uniqueArtistsCount // ignore: cast_nullable_to_non_nullable
                  as int,
        uniqueAlbumsCount: null == uniqueAlbumsCount
            ? _self.uniqueAlbumsCount
            : uniqueAlbumsCount // ignore: cast_nullable_to_non_nullable
                  as int,
        uniqueGenresCount: null == uniqueGenresCount
            ? _self.uniqueGenresCount
            : uniqueGenresCount // ignore: cast_nullable_to_non_nullable
                  as int,
        averageTrackDuration: null == averageTrackDuration
            ? _self.averageTrackDuration
            : averageTrackDuration // ignore: cast_nullable_to_non_nullable
                  as Duration,
        timeOfDayStats: null == timeOfDayStats
            ? _self.timeOfDayStats
            : timeOfDayStats // ignore: cast_nullable_to_non_nullable
                  as IList<TimeOfDayStats>,
        dayOfWeekStats: null == dayOfWeekStats
            ? _self.dayOfWeekStats
            : dayOfWeekStats // ignore: cast_nullable_to_non_nullable
                  as IList<DayOfWeekStats>,
        monthStats: null == monthStats
            ? _self.monthStats
            : monthStats // ignore: cast_nullable_to_non_nullable
                  as IList<MonthStats>,
        mostActiveDay: freezed == mostActiveDay
            ? _self.mostActiveDay
            : mostActiveDay // ignore: cast_nullable_to_non_nullable
                  as MostActiveDayStats?,
        longestTrack: freezed == longestTrack
            ? _self.longestTrack
            : longestTrack // ignore: cast_nullable_to_non_nullable
                  as VkAudioTrack?,
        shortestTrack: freezed == shortestTrack
            ? _self.shortestTrack
            : shortestTrack // ignore: cast_nullable_to_non_nullable
                  as VkAudioTrack?,
        totalPlayCount: null == totalPlayCount
            ? _self.totalPlayCount
            : totalPlayCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }

  /// Create a copy of StatisticStateData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $VkAudioTrackCopyWith<$Res>? get longestTrack {
    if (_self.longestTrack == null) {
      return null;
    }

    return $VkAudioTrackCopyWith<$Res>(_self.longestTrack!, (value) {
      return _then(_self.copyWith(longestTrack: value));
    });
  }

  /// Create a copy of StatisticStateData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $VkAudioTrackCopyWith<$Res>? get shortestTrack {
    if (_self.shortestTrack == null) {
      return null;
    }

    return $VkAudioTrackCopyWith<$Res>(_self.shortestTrack!, (value) {
      return _then(_self.copyWith(shortestTrack: value));
    });
  }
}

/// @nodoc

class _StatisticStateData implements StatisticStateData {
  const _StatisticStateData({
    required this.topArtists,
    required this.topTracks,
    required this.tracksWithSameTitle,
    required this.totalListeningTime,
    required this.uniqueTracksCount,
    required this.uniqueArtistsCount,
    required this.uniqueAlbumsCount,
    required this.uniqueGenresCount,
    required this.averageTrackDuration,
    required this.timeOfDayStats,
    required this.dayOfWeekStats,
    required this.monthStats,
    required this.mostActiveDay,
    required this.longestTrack,
    required this.shortestTrack,
    required this.totalPlayCount,
  });

  @override
  final IList<ArtistStats> topArtists;
  @override
  final IList<TrackWithStats> topTracks;
  @override
  final IList<
    ({String title, int trackCount, int totalPlayCount, int totalDuration})
  >
  tracksWithSameTitle;
  @override
  final Duration totalListeningTime;
  @override
  final int uniqueTracksCount;
  @override
  final int uniqueArtistsCount;
  @override
  final int uniqueAlbumsCount;
  @override
  final int uniqueGenresCount;
  @override
  final Duration averageTrackDuration;
  @override
  final IList<TimeOfDayStats> timeOfDayStats;
  @override
  final IList<DayOfWeekStats> dayOfWeekStats;
  @override
  final IList<MonthStats> monthStats;
  @override
  final MostActiveDayStats? mostActiveDay;
  @override
  final VkAudioTrack? longestTrack;
  @override
  final VkAudioTrack? shortestTrack;
  @override
  final int totalPlayCount;

  /// Create a copy of StatisticStateData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$StatisticStateDataCopyWith<_StatisticStateData> get copyWith =>
      __$StatisticStateDataCopyWithImpl<_StatisticStateData>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _StatisticStateData &&
            const DeepCollectionEquality().equals(
              other.topArtists,
              topArtists,
            ) &&
            const DeepCollectionEquality().equals(other.topTracks, topTracks) &&
            const DeepCollectionEquality().equals(
              other.tracksWithSameTitle,
              tracksWithSameTitle,
            ) &&
            (identical(other.totalListeningTime, totalListeningTime) ||
                other.totalListeningTime == totalListeningTime) &&
            (identical(other.uniqueTracksCount, uniqueTracksCount) ||
                other.uniqueTracksCount == uniqueTracksCount) &&
            (identical(other.uniqueArtistsCount, uniqueArtistsCount) ||
                other.uniqueArtistsCount == uniqueArtistsCount) &&
            (identical(other.uniqueAlbumsCount, uniqueAlbumsCount) ||
                other.uniqueAlbumsCount == uniqueAlbumsCount) &&
            (identical(other.uniqueGenresCount, uniqueGenresCount) ||
                other.uniqueGenresCount == uniqueGenresCount) &&
            (identical(other.averageTrackDuration, averageTrackDuration) ||
                other.averageTrackDuration == averageTrackDuration) &&
            const DeepCollectionEquality().equals(
              other.timeOfDayStats,
              timeOfDayStats,
            ) &&
            const DeepCollectionEquality().equals(
              other.dayOfWeekStats,
              dayOfWeekStats,
            ) &&
            const DeepCollectionEquality().equals(
              other.monthStats,
              monthStats,
            ) &&
            (identical(other.mostActiveDay, mostActiveDay) ||
                other.mostActiveDay == mostActiveDay) &&
            (identical(other.longestTrack, longestTrack) ||
                other.longestTrack == longestTrack) &&
            (identical(other.shortestTrack, shortestTrack) ||
                other.shortestTrack == shortestTrack) &&
            (identical(other.totalPlayCount, totalPlayCount) ||
                other.totalPlayCount == totalPlayCount));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(topArtists),
    const DeepCollectionEquality().hash(topTracks),
    const DeepCollectionEquality().hash(tracksWithSameTitle),
    totalListeningTime,
    uniqueTracksCount,
    uniqueArtistsCount,
    uniqueAlbumsCount,
    uniqueGenresCount,
    averageTrackDuration,
    const DeepCollectionEquality().hash(timeOfDayStats),
    const DeepCollectionEquality().hash(dayOfWeekStats),
    const DeepCollectionEquality().hash(monthStats),
    mostActiveDay,
    longestTrack,
    shortestTrack,
    totalPlayCount,
  );

  @override
  String toString() {
    return 'StatisticStateData(topArtists: $topArtists, topTracks: $topTracks, tracksWithSameTitle: $tracksWithSameTitle, totalListeningTime: $totalListeningTime, uniqueTracksCount: $uniqueTracksCount, uniqueArtistsCount: $uniqueArtistsCount, uniqueAlbumsCount: $uniqueAlbumsCount, uniqueGenresCount: $uniqueGenresCount, averageTrackDuration: $averageTrackDuration, timeOfDayStats: $timeOfDayStats, dayOfWeekStats: $dayOfWeekStats, monthStats: $monthStats, mostActiveDay: $mostActiveDay, longestTrack: $longestTrack, shortestTrack: $shortestTrack, totalPlayCount: $totalPlayCount)';
  }
}

/// @nodoc
abstract mixin class _$StatisticStateDataCopyWith<$Res>
    implements $StatisticStateDataCopyWith<$Res> {
  factory _$StatisticStateDataCopyWith(
    _StatisticStateData value,
    $Res Function(_StatisticStateData) _then,
  ) = __$StatisticStateDataCopyWithImpl;
  @override
  @useResult
  $Res call({
    IList<ArtistStats> topArtists,
    IList<TrackWithStats> topTracks,
    IList<
      ({String title, int trackCount, int totalPlayCount, int totalDuration})
    >
    tracksWithSameTitle,
    Duration totalListeningTime,
    int uniqueTracksCount,
    int uniqueArtistsCount,
    int uniqueAlbumsCount,
    int uniqueGenresCount,
    Duration averageTrackDuration,
    IList<TimeOfDayStats> timeOfDayStats,
    IList<DayOfWeekStats> dayOfWeekStats,
    IList<MonthStats> monthStats,
    MostActiveDayStats? mostActiveDay,
    VkAudioTrack? longestTrack,
    VkAudioTrack? shortestTrack,
    int totalPlayCount,
  });

  @override
  $VkAudioTrackCopyWith<$Res>? get longestTrack;
  @override
  $VkAudioTrackCopyWith<$Res>? get shortestTrack;
}

/// @nodoc
class __$StatisticStateDataCopyWithImpl<$Res>
    implements _$StatisticStateDataCopyWith<$Res> {
  __$StatisticStateDataCopyWithImpl(this._self, this._then);

  final _StatisticStateData _self;
  final $Res Function(_StatisticStateData) _then;

  /// Create a copy of StatisticStateData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? topArtists = null,
    Object? topTracks = null,
    Object? tracksWithSameTitle = null,
    Object? totalListeningTime = null,
    Object? uniqueTracksCount = null,
    Object? uniqueArtistsCount = null,
    Object? uniqueAlbumsCount = null,
    Object? uniqueGenresCount = null,
    Object? averageTrackDuration = null,
    Object? timeOfDayStats = null,
    Object? dayOfWeekStats = null,
    Object? monthStats = null,
    Object? mostActiveDay = freezed,
    Object? longestTrack = freezed,
    Object? shortestTrack = freezed,
    Object? totalPlayCount = null,
  }) {
    return _then(
      _StatisticStateData(
        topArtists: null == topArtists
            ? _self.topArtists
            : topArtists // ignore: cast_nullable_to_non_nullable
                  as IList<ArtistStats>,
        topTracks: null == topTracks
            ? _self.topTracks
            : topTracks // ignore: cast_nullable_to_non_nullable
                  as IList<TrackWithStats>,
        tracksWithSameTitle: null == tracksWithSameTitle
            ? _self.tracksWithSameTitle
            : tracksWithSameTitle // ignore: cast_nullable_to_non_nullable
                  as IList<
                    ({
                      String title,
                      int trackCount,
                      int totalPlayCount,
                      int totalDuration,
                    })
                  >,
        totalListeningTime: null == totalListeningTime
            ? _self.totalListeningTime
            : totalListeningTime // ignore: cast_nullable_to_non_nullable
                  as Duration,
        uniqueTracksCount: null == uniqueTracksCount
            ? _self.uniqueTracksCount
            : uniqueTracksCount // ignore: cast_nullable_to_non_nullable
                  as int,
        uniqueArtistsCount: null == uniqueArtistsCount
            ? _self.uniqueArtistsCount
            : uniqueArtistsCount // ignore: cast_nullable_to_non_nullable
                  as int,
        uniqueAlbumsCount: null == uniqueAlbumsCount
            ? _self.uniqueAlbumsCount
            : uniqueAlbumsCount // ignore: cast_nullable_to_non_nullable
                  as int,
        uniqueGenresCount: null == uniqueGenresCount
            ? _self.uniqueGenresCount
            : uniqueGenresCount // ignore: cast_nullable_to_non_nullable
                  as int,
        averageTrackDuration: null == averageTrackDuration
            ? _self.averageTrackDuration
            : averageTrackDuration // ignore: cast_nullable_to_non_nullable
                  as Duration,
        timeOfDayStats: null == timeOfDayStats
            ? _self.timeOfDayStats
            : timeOfDayStats // ignore: cast_nullable_to_non_nullable
                  as IList<TimeOfDayStats>,
        dayOfWeekStats: null == dayOfWeekStats
            ? _self.dayOfWeekStats
            : dayOfWeekStats // ignore: cast_nullable_to_non_nullable
                  as IList<DayOfWeekStats>,
        monthStats: null == monthStats
            ? _self.monthStats
            : monthStats // ignore: cast_nullable_to_non_nullable
                  as IList<MonthStats>,
        mostActiveDay: freezed == mostActiveDay
            ? _self.mostActiveDay
            : mostActiveDay // ignore: cast_nullable_to_non_nullable
                  as MostActiveDayStats?,
        longestTrack: freezed == longestTrack
            ? _self.longestTrack
            : longestTrack // ignore: cast_nullable_to_non_nullable
                  as VkAudioTrack?,
        shortestTrack: freezed == shortestTrack
            ? _self.shortestTrack
            : shortestTrack // ignore: cast_nullable_to_non_nullable
                  as VkAudioTrack?,
        totalPlayCount: null == totalPlayCount
            ? _self.totalPlayCount
            : totalPlayCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }

  /// Create a copy of StatisticStateData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $VkAudioTrackCopyWith<$Res>? get longestTrack {
    if (_self.longestTrack == null) {
      return null;
    }

    return $VkAudioTrackCopyWith<$Res>(_self.longestTrack!, (value) {
      return _then(_self.copyWith(longestTrack: value));
    });
  }

  /// Create a copy of StatisticStateData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $VkAudioTrackCopyWith<$Res>? get shortestTrack {
    if (_self.shortestTrack == null) {
      return null;
    }

    return $VkAudioTrackCopyWith<$Res>(_self.shortestTrack!, (value) {
      return _then(_self.copyWith(shortestTrack: value));
    });
  }
}
