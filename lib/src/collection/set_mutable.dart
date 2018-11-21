import 'package:dart_kollection/dart_kollection.dart';
import 'package:dart_kollection/src/extension/collection_extension_mixin.dart';
import 'package:dart_kollection/src/extension/iterable_extension_mixin.dart';
import 'package:dart_kollection/src/extension/iterable_mutable_extension_mixin.dart';
import 'package:dart_kollection/src/collection/iterable.dart';
import 'package:dart_kollection/src/collection/set.dart';
import 'package:dart_kollection/src/util/hash.dart';

class DartMutableSet<T>
    with KMutableIterableExtensionsMixin<T>, KCollectionExtensionMixin<T>, KIterableExtensionsMixin<T>
    implements KMutableSet<T> {
  final Set<T> _set;
  int _hashCode;

  DartMutableSet([Iterable<T> iterable = const []])
      : _set = Set.from(iterable),
        super();

  /// Doesn't copy the incoming list which is more efficient but risks accidental modification of the incoming map.
  ///
  /// Use with care!
  DartMutableSet.noCopy(Set<T> set)
      : assert(set != null),
        _set = set,
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
  KMutableIterator<T> iterator() => _MutableSetIterator(this);

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

  @override
  bool add(T element) {
    _set.add(element);
    return true;
  }

  @override
  bool addAll(KCollection<T> elements) {
    var oldSize = size;
    _set.addAll(elements.iter);
    return size != oldSize;
  }

  @override
  void clear() => _set.clear();

  @override
  bool remove(T element) => _set.remove(element);

  @override
  bool removeAll(KCollection<T> elements) {
    final oldSize = size;
    for (var value in elements.iter) {
      _set.remove(value);
    }
    return oldSize != size;
  }

  @override
  bool retainAll(KCollection<T> elements) {
    final oldSize = size;
    _set.removeWhere((it) => !elements.contains(it));
    return oldSize != size;
  }
}

class _MutableSetIterator<T> extends KMutableIterator<T> {
  _MutableSetIterator(KMutableSet<T> set)
      : _set = set,
        _iterator = set.iter.iterator {
    lastReturned = null;
    _iterator.moveNext();
    nextValue = _iterator.current;
  }

  KMutableSet<T> _set;
  final Iterator<T> _iterator;
  T nextValue;
  T lastReturned;

  @override
  bool hasNext() {
    return nextValue != null;
  }

  @override
  T next() {
    var e = nextValue;
    if (e == null) throw NoSuchElementException();
    _iterator.moveNext();
    nextValue = _iterator.current;
    lastReturned = e;
    return e;
  }

  @override
  void remove() {
    _set.remove(lastReturned);
  }
}
