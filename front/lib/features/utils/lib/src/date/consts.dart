//https://stackoverflow.com/a/67144899/15588532
class DateTimeMaxMin {
  //
  static const _shiftForTZSafeMapping = 1;
  static const _numDays = 100000000 - _shiftForTZSafeMapping;

  static DateTime get min => DateTime.fromMicrosecondsSinceEpoch(0)
      .subtract(const Duration(days: _numDays));
  static DateTime get max => DateTime.fromMicrosecondsSinceEpoch(0)
      .add(const Duration(days: _numDays));
}
