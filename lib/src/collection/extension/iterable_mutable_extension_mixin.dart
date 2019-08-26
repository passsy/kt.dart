import "package:kt_dart/collection.dart";


extension KtMutableIterableExtensions<T> on KtMutableIterable<T> {
  bool removeAllWhere(bool Function(T) predicate) =>
      _filterInPlace(predicate, true);

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
