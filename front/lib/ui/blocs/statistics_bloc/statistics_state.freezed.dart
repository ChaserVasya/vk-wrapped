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
mixin _$StatisticsState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is StatisticsState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'StatisticsState()';
  }
}

/// @nodoc
class $StatisticsStateCopyWith<$Res> {
  $StatisticsStateCopyWith(
    StatisticsState _,
    $Res Function(StatisticsState) __,
  );
}

/// @nodoc

class StatisticsState$LoadingState implements StatisticsState {
  const StatisticsState$LoadingState();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StatisticsState$LoadingState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'StatisticsState.loadingState()';
  }
}

/// @nodoc

class StatisticsState$DataState implements StatisticsState {
  const StatisticsState$DataState({
    required this.topArtists,
    required this.topTracks,
    required this.totalListeningTime,
    required this.uniqueTracksCount,
    required this.uniqueArtistsCount,
    required this.averageTrackDuration,
    required this.timeOfDayStats,
    required this.dayOfWeekStats,
    required this.monthStats,
    required this.mostActiveDay,
    required this.longestTrack,
    required this.shortestTrack,
    required this.totalPlayCount,
  });

  final IList<ArtistStats> topArtists;
  final IList<TrackStats> topTracks;
  final Duration totalListeningTime;
  final int uniqueTracksCount;
  final int uniqueArtistsCount;
  final Duration averageTrackDuration;
  final IList<TimeOfDayStats> timeOfDayStats;
  final IList<DayOfWeekStats> dayOfWeekStats;
  final IList<MonthStats> monthStats;
  final DateTime? mostActiveDay;
  final TrackStats? longestTrack;
  final TrackStats? shortestTrack;
  final int totalPlayCount;

  /// Create a copy of StatisticsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $StatisticsState$DataStateCopyWith<StatisticsState$DataState> get copyWith =>
      _$StatisticsState$DataStateCopyWithImpl<StatisticsState$DataState>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StatisticsState$DataState &&
            const DeepCollectionEquality().equals(
              other.topArtists,
              topArtists,
            ) &&
            const DeepCollectionEquality().equals(other.topTracks, topTracks) &&
            (identical(other.totalListeningTime, totalListeningTime) ||
                other.totalListeningTime == totalListeningTime) &&
            (identical(other.uniqueTracksCount, uniqueTracksCount) ||
                other.uniqueTracksCount == uniqueTracksCount) &&
            (identical(other.uniqueArtistsCount, uniqueArtistsCount) ||
                other.uniqueArtistsCount == uniqueArtistsCount) &&
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
    totalListeningTime,
    uniqueTracksCount,
    uniqueArtistsCount,
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
    return 'StatisticsState.dataState(topArtists: $topArtists, topTracks: $topTracks, totalListeningTime: $totalListeningTime, uniqueTracksCount: $uniqueTracksCount, uniqueArtistsCount: $uniqueArtistsCount, averageTrackDuration: $averageTrackDuration, timeOfDayStats: $timeOfDayStats, dayOfWeekStats: $dayOfWeekStats, monthStats: $monthStats, mostActiveDay: $mostActiveDay, longestTrack: $longestTrack, shortestTrack: $shortestTrack, totalPlayCount: $totalPlayCount)';
  }
}

/// @nodoc
abstract mixin class $StatisticsState$DataStateCopyWith<$Res>
    implements $StatisticsStateCopyWith<$Res> {
  factory $StatisticsState$DataStateCopyWith(
    StatisticsState$DataState value,
    $Res Function(StatisticsState$DataState) _then,
  ) = _$StatisticsState$DataStateCopyWithImpl;
  @useResult
  $Res call({
    IList<ArtistStats> topArtists,
    IList<TrackStats> topTracks,
    Duration totalListeningTime,
    int uniqueTracksCount,
    int uniqueArtistsCount,
    Duration averageTrackDuration,
    IList<TimeOfDayStats> timeOfDayStats,
    IList<DayOfWeekStats> dayOfWeekStats,
    IList<MonthStats> monthStats,
    DateTime? mostActiveDay,
    TrackStats? longestTrack,
    TrackStats? shortestTrack,
    int totalPlayCount,
  });
}

/// @nodoc
class _$StatisticsState$DataStateCopyWithImpl<$Res>
    implements $StatisticsState$DataStateCopyWith<$Res> {
  _$StatisticsState$DataStateCopyWithImpl(this._self, this._then);

  final StatisticsState$DataState _self;
  final $Res Function(StatisticsState$DataState) _then;

  /// Create a copy of StatisticsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? topArtists = null,
    Object? topTracks = null,
    Object? totalListeningTime = null,
    Object? uniqueTracksCount = null,
    Object? uniqueArtistsCount = null,
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
      StatisticsState$DataState(
        topArtists: null == topArtists
            ? _self.topArtists
            : topArtists // ignore: cast_nullable_to_non_nullable
                  as IList<ArtistStats>,
        topTracks: null == topTracks
            ? _self.topTracks
            : topTracks // ignore: cast_nullable_to_non_nullable
                  as IList<TrackStats>,
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
                  as DateTime?,
        longestTrack: freezed == longestTrack
            ? _self.longestTrack
            : longestTrack // ignore: cast_nullable_to_non_nullable
                  as TrackStats?,
        shortestTrack: freezed == shortestTrack
            ? _self.shortestTrack
            : shortestTrack // ignore: cast_nullable_to_non_nullable
                  as TrackStats?,
        totalPlayCount: null == totalPlayCount
            ? _self.totalPlayCount
            : totalPlayCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}
