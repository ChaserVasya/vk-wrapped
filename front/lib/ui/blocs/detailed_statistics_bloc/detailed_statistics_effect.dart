part of 'detailed_statistics_bloc.dart';

@freezed
sealed class DetailedStatisticsEffect with _$DetailedStatisticsEffect {
  const factory DetailedStatisticsEffect.error({required String message}) =
      DetailedStatisticsEffect$Error;
}
