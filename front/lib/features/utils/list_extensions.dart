extension ListExtension<T> on Iterable<T> {
  List<T> mapIndexed(T Function(int index, dynamic item) f) {
    var index = 0;
    return map((item) => f(index++, item)).toList();
  }

  List<T> appendToSize(int newLength, T filler) {
    if (length >= newLength) {
      return toList();
    }
    return [
      ...this,
      ...List.filled(newLength - length, filler),
    ];
  }

  bool containsSame(Iterable<T> other) {
    if (length != other.length) return false;
    for (final our in this) {
      if (!other.any((their) => our == their)) return false;
    }
    return true;
  }

  static Iterable<T> findMissing<T, V, R>(
    Iterable<T> our,
    Iterable<V> other,
    bool Function(T, V) compareBy,
  ) {
    return our.where(
      (ourItem) => !other.any(
        (otherItem) => compareBy(ourItem, otherItem),
      ),
    );
  }

  static Iterable<T> find<T, V, R>(
    Iterable<T> our,
    Iterable<V> other,
    bool Function(T, V) compareBy,
  ) {
    return our.where(
      (ourItem) => other.any((otherItem) => compareBy(ourItem, otherItem)),
    );
  }
}
