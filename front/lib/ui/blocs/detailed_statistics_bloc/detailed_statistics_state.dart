part of 'detailed_statistics_bloc.dart';

@freezed
class DetailedStatisticsState with _$DetailedStatisticsState {
  const factory DetailedStatisticsState.initial() =
      DetailedStatisticsState$Initial;
  const factory DetailedStatisticsState.loading() =
      DetailedStatisticsState$Loading;
  const factory DetailedStatisticsState.data({
    required Map<String, dynamic> statistics,
  }) = DetailedStatisticsState$Data;
  const factory DetailedStatisticsState.error({required String message}) =
      DetailedStatisticsState$Error;
}
