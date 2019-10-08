import "package:kt_dart/collection.dart";

extension KtMutableIterableExtensions<T> on KtMutableIterable<T> {
  /// Removes all elements from this [KtMutableIterable] that match the given [predicate].
  ///
  /// @return `true` if any element was removed from the collection, `false` if the collection was not modified.
  bool removeAllWhere(bool Function(T) predicate) =>
      _filterInPlace(predicate, true);

  /// Retains only elements of this [KtMutableIterable] that match the given [predicate]
  ///
  /// @return `true` if any element was removed from the collection, `false` if the collection was not modified.
  bool retainAllWhere(bool Function(T) predicate) =>
      _filterInPlace(predicate, false);

  bool _filterInPlace(
      bool Function(T) predicate, bool predicateResultToRemove) {
    assert(() {
      if (predicate == null) throw ArgumentError("predicate can't be null");
      return true;
    }());
    var result = false;
    final i = iterator();
    while (i.hasNext()) {
      if (predicate(i.next()) == predicateResultToRemove) {
        i.remove();
        result = true;
      }
    }
    return result;
  }
}
