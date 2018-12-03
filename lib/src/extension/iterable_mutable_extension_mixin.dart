import 'package:dart_kollection/dart_kollection.dart';

abstract class KMutableIterableExtensionsMixin<T>
    implements KMutableIterableExtension<T>, KMutableIterable<T> {
  @override
  bool removeAllWhere(bool Function(T) predicate) =>
      _filterInPlace(predicate, true);

  @override
  bool retainAllWhere(bool Function(T) predicate) =>
      _filterInPlace(predicate, false);

  bool _filterInPlace(
      bool Function(T) predicate, bool predicateResultToRemove) {
    var result = false;
    var i = iterator();
    while (i.hasNext())
      if (predicate(i.next()) == predicateResultToRemove) {
        i.remove();
        result = true;
      }
    return result;
  }
}
