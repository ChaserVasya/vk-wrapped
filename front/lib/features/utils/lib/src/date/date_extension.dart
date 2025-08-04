import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String toDate() => DateFormat('dd.MM.y').format(this);

  String toDateTitle() => DateFormat.yMMMMd().format(this);

  String toDateTimeShort() => DateFormat('yMMddTHmmss').format(this);

  String toTime() => DateFormat.Hm().format(this);

  DateTime clipToDay() => copyWith(
        hour: 0,
        minute: 0,
        second: 0,
        millisecond: 0,
        microsecond: 0,
      );

  String toDayMonth() => DateFormat('dd.MM').format(this);
  String toMonthTitle() => DateFormat.MMMM().format(this);

  String toMonthYearTitle() => DateFormat.yMMMM().format(this);

  DateTime atStartOfTheDayUtc() => DateTime.utc(year, month, day);

  DateTime plusDaysUtc(int days) =>
      DateTime.utc(year, month, day + days, hour, minute, second);

  DateTime plusDays(int days) => copyWith(day: day + days);

  DateTime plusMinutes(int minutes) => copyWith(minute: minute + minutes);

  DateTime plusSeconds(int seconds) => copyWith(second: second + seconds);

  /// Probably is a little bit expensive
  List<int> getCurrentWeekDays() {
    final todayWeekDay = weekday;
    final monday = plusDaysUtc(-todayWeekDay + 1);
    return [for (int i = 0; i < 7; i++) monday.plusDaysUtc(i).day];
  }

  int getDaysDiff(DateTime other, {bool abs = false}) {
    final result = daySinceEpoch() - other.daySinceEpoch();
    return result < 0 && abs ? -result : result;
  }

  int daySinceEpoch() =>
      atStartOfTheDayUtc().millisecondsSinceEpoch ~/ 86400000;

  bool isSameLocalDay(DateTime? other) {
    if (other == null) return false;
    return toLocal().clipToDay() == other.toLocal().clipToDay();
  }

  bool isSameDay(DateTime? other) {
    if (other == null) return false;
    return daySinceEpoch() == other.daySinceEpoch();
  }
}
