import 'package:kt_dart/collection.dart';

abstract class KtMutableIterableExtensionsMixin<T>
    implements KtMutableIterableExtension<T>, KtMutableIterable<T> {
  @override
  bool removeAllWhere(bool Function(T) predicate) =>
      _filterInPlace(predicate, true);

  @override
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
    while (i.hasNext())
      if (predicate(i.next()) == predicateResultToRemove) {
        i.remove();
        result = true;
      }
    return result;
  }
}
