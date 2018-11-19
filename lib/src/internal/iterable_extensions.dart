import 'package:dart_kollection/dart_kollection.dart';

abstract class KIterableExtensionsMixin<T> implements KIterable<T>, KIterableExtensions<T> {
  Iterable<T> get iter => _DartInteropIterable(this);

  @override
  void forEach(void action(T element)) {
    var i = iterator();
    while (i.hasNext()) {
      var element = i.next();
      action(element);
    }
  }

  @override
  bool any([bool Function(T element) test = null]) {
    if (test == null) {
      if (this is KCollection) return !(this as KCollection).isEmpty();
      return iterator().hasNext();
    }
    if (this is KCollection && (this as KCollection).isEmpty()) return false;
    for (var element in iter) {
      if (test(element)) return true;
    }
    return false;
  }
}

class _DartInteropIterable<T> extends Iterable<T> {
  _DartInteropIterable(this.kIterable);

  final KIterable<T> kIterable;

  @override
  Iterator<T> get iterator => _DartInteropIterator(kIterable.iterator());
}

class _DartInteropIterator<T> extends Iterator<T> {
  _DartInteropIterator(this.kIterator);

  final KIterator<T> kIterator;

  @override
  T current = null;

  @override
  bool moveNext() {
    var hasNext = kIterator.hasNext();
    if (hasNext) {
      current = kIterator.next();
      return true;
    } else {
      current = null;
      return false;
    }
  }
}
