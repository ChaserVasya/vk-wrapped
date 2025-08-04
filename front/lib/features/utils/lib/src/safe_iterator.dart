// Copy-paste of [FlatIterator] from fast_immutable_collections
/// This iterator encapsulate Dart's native Iterator to give a better error message
/// when current value is called before calling [moveNext].
///
class SafeIterator<T> implements Iterator<T> {
  Iterator<T> iterator;
  bool _pre, _hasCurrent;

  SafeIterator(this.iterator)
      : _pre = true,
        _hasCurrent = true;

  @override
  T get current {
    if (_pre) {
      throw StateError("No current value available. Call moveNext() first.");
    }
    if (!_hasCurrent) throw StateError("No move values available.");
    return iterator.current;
  }

  @override
  bool moveNext() {
    _pre = false;
    return _hasCurrent = iterator.moveNext();
  }
}
