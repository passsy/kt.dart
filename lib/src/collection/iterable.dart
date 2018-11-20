import 'package:dart_kollection/dart_kollection.dart';

// TODO create empty version
class DartInteropIterable<T> extends Iterable<T> {
  DartInteropIterable(this.kIterable);

  final KIterable<T> kIterable;

  @override
  Iterator<T> get iterator => _DartIterator(kIterable.iterator());
}

class _DartIterator<T> extends Iterator<T> {
  _DartIterator(this.kIterator);

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
