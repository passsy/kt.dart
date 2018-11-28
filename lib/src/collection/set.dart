import 'package:dart_kollection/dart_kollection.dart';
import 'package:dart_kollection/src/extension/collection_extension_mixin.dart';
import 'package:dart_kollection/src/extension/iterable_extension_mixin.dart';
import 'package:dart_kollection/src/util/hash.dart';

class DartSet<T> with KIterableExtensionsMixin<T>, KCollectionExtensionMixin<T> implements KSet<T> {
  final Set<T> _set;
  int _hashCode;

  DartSet([Iterable<T> iterable = const []])
      : _set = Set.from(iterable),
        super();

  @override
  Iterable<T> get iter => _set;

  @override
  bool contains(T element) => _set.contains(element);

  @override
  bool containsAll(KCollection<T> elements) {
    return elements.all((it) => _set.contains(it));
  }

  @override
  bool isEmpty() => _set.isEmpty;

  @override
  KIterator<T> iterator() => _DartToKIterator(_set.iterator);

  @override
  int get size => _set.length;

  @override
  int get hashCode {
    if (_hashCode == null) {
      _hashCode = hashObjects(_set.map((e) => e.hashCode).toList(growable: false)..sort());
    }
    return _hashCode;
  }

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! KSet) return false;
    if (other.size != size) return false;
    if (other.hashCode != hashCode) return false;
    return containsAll(other);
  }
}

class _DartToKIterator<T> extends KIterator<T> {
  final Iterator<T> iterator;
  T nextValue;
  T lastReturned;

  _DartToKIterator(this.iterator) {
    lastReturned = null;
    iterator.moveNext();
    nextValue = iterator.current;
  }

  @override
  bool hasNext() {
    return nextValue != null;
  }

  @override
  T next() {
    var e = nextValue;
    if (e == null) throw NoSuchElementException();
    iterator.moveNext();
    nextValue = iterator.current;
    lastReturned = e;
    return e;
  }
}
