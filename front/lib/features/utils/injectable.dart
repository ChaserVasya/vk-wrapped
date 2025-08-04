/// Wraps [Record]. injectable_generator below 2.15.0 can't handle Record
///
/// Example:
/// ```
/// class BlocParams extends Params<(Id locationId)>{}
/// ```
class Params<R extends Record> {
  const Params(this.params);

  final R params;

  // Copied from ValueKey

  @override
  operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is Params<R> && other.params == params;
  }

  @override
  get hashCode => Object.hash(runtimeType, params);
}
