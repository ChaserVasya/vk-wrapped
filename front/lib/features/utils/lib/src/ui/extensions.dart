import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension NullIfEmptyExtension<T extends Flex> on T {
  T? get nullIfEmpty => children.isEmpty ? null : this;
}

extension NullIfBlankExtension on String? {
  String? get nullIfBlank => isNullOrBlank ? null : this;
}

abstract final class IntlUtils {
  static List<String> get shortWeekdays =>
      DateFormat().dateSymbols.SHORTWEEKDAYS;

  static String shortWeekdayForDate(DateTime date) =>
      shortWeekdays[date.weekday % 7];

  static Iterable<String> get shortWeekdays$UpperCase =>
      shortWeekdays.map((w) => w.toUpperCase()).toList();
}
