import 'package:equatable/equatable.dart';

class Interval extends Equatable {
  const Interval(this.start, this.end);

  final DateTime start;
  final DateTime end;

  Duration get duration => end.difference(start);

  int get years =>
      end.year -
      start.year -
      (start.copyWith(year: end.year).isAfter(end) ? 1 : 0);

  bool contains(DateTime dateTime) =>
      start.isBefore(dateTime) && end.isAfter(dateTime);

  @override
  List<Object?> get props =>
      [start.millisecondsSinceEpoch, end.millisecondsSinceEpoch];
}

extension DateTimeIntervalExtension on DateTime {
  bool between(DateTime? start, DateTime? end) =>
      start != null && end != null && isAfter(start) && isBefore(end);
}

extension LikeDaysExtension on Duration {
  (int h, int m) get inTime {
    return (
      inHours,
      inMinutes % Duration.minutesPerHour,
    );
  }
}
