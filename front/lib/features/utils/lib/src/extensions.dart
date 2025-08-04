import 'package:dartx/dartx.dart';

extension SetExtension on Set {
  bool containsEqual(Set other) => length == other.length && containsAll(other);
}

extension ColorExtension on String {
  int toColorInt() {
    if (startsWith("0x")) return int.parse(this);
    var hexColor = replaceAll("#", "");
    switch (hexColor.length) {
      case 6:
        return int.parse("0xFF$hexColor");
      case 8:
        return int.parse("0x$hexColor");
      default:
        return 0;
    }
  }
}

extension StringSafeSubstringExtension on String {
  /// Cuts a range to non-throwing range
  String safeSubstring(int start, [int? end]) {
    start = start.coerceIn(0, length);
    return substring(start, end?.coerceIn(start, length));
  }
}

extension IntExtension on int {
  int? get notZeroOrNull => this == 0 ? null : this;
}

extension SeparateExtension<T> on List<T> {
  List<T> separateByIndexed<S extends T>(S Function(int) separatorBuilder) {
    if (isEmpty) return this;
    final separatedListLength = 2 * length - 1;
    final separatedList =
        List<T?>.filled(separatedListLength, null, growable: true);
    for (var i = 0; i < separatedListLength; i++) {
      final int itemIndex = i ~/ 2;
      if (i.isEven) {
        separatedList[i] = this[itemIndex];
      } else {
        separatedList[i] = separatorBuilder(itemIndex);
      }
    }
    return separatedList.cast<T>();
  }

  List<T> separateBy<S extends T>(S separator) {
    return separateByIndexed((_) => separator);
  }

  List<T> separateAndWrapBy<S extends T>(S separator) {
    final separated = separateBy(separator);
    return separated.wrapBy(separator);
  }

  List<T> wrapBy<S extends T>(S separator) {
    return [
      separator,
      ...this,
      separator,
    ];
  }
}

extension MapT<T extends Object?> on T {
  Output map<Output>(Output Function(T) mapper) => mapper(this);
}

extension SeparateExtensionIterable<T> on Iterable<T> {
  List<T> separateBy<S extends T>(S separator) =>
      toList().separateBy(separator);
}
