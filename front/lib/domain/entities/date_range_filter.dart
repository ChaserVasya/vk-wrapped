import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/date_range_filter.freezed.dart';
part 'generated/date_range_filter.g.dart';

/// Фильтр диапазона дат для сессий
/// null значения означают отсутствие ограничения с соответствующей стороны
@freezed
abstract class DateRangeFilter with _$DateRangeFilter {
  const DateRangeFilter._();
  const factory DateRangeFilter({
    /// Начало диапазона (включительно). null означает отсутствие ограничения снизу
    DateTime? startDate,

    /// Конец диапазона (включительно). null означает отсутствие ограничения сверху
    DateTime? endDate,
  }) = _DateRangeFilter;

  factory DateRangeFilter.fromJson(Map<String, dynamic> json) =>
      _$DateRangeFilterFromJson(json);

  /// Создает фильтр для всего периода (без ограничений)
  factory DateRangeFilter.all() {
    return const DateRangeFilter(startDate: null, endDate: null);
  }

  /// Создает фильтр для конкретного года
  factory DateRangeFilter.forYear(int year) {
    final start = DateTime(year, 1, 1);
    final end = DateTime(year, 12, 31, 23, 59, 59, 999);
    return DateRangeFilter(startDate: start, endDate: end);
  }

  /// Создает фильтр для кастомного диапазона
  factory DateRangeFilter.custom({
    required DateTime startDate,
    required DateTime endDate,
  }) {
    return DateRangeFilter(startDate: startDate, endDate: endDate);
  }

  /// Проверяет, попадает ли дата в диапазон фильтра
  bool matches(DateTime date) {
    final start = startDate;
    final end = endDate;
    if (start != null && date.isBefore(start)) {
      return false;
    }
    if (end != null && date.isAfter(end)) {
      return false;
    }
    return true;
  }

  /// Проверяет, попадает ли сессия в диапазон фильтра
  /// Сессия попадает, если период сессии пересекается с диапазоном фильтра
  bool matchesSession({
    required DateTime firstObserved,
    required DateTime lastSeen,
  }) {
    // Проверяем, пересекается ли период сессии с диапазоном фильтра
    final sessionStart = firstObserved;
    final sessionEnd = lastSeen;
    final start = startDate;
    final end = endDate;

    // Если есть ограничение снизу и сессия закончилась до начала фильтра
    if (start != null && sessionEnd.isBefore(start)) {
      return false;
    }

    // Если есть ограничение сверху и сессия началась после конца фильтра
    if (end != null && sessionStart.isAfter(end)) {
      return false;
    }

    return true;
  }
}
