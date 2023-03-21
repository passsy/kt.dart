import "package:kt_dart/collection.dart";
import "package:kt_dart/src/util/hash.dart";

class DartMutableSet<T> extends Object implements KtMutableSet<T> {
  DartMutableSet([Iterable<T> iterable = const []])
      : _set = Set.from(iterable),
        super();

  /// Doesn't copy the incoming list which is more efficient but risks accidental modification of the incoming map.
  ///
  /// Use with care!
  const DartMutableSet.noCopy(Set<T> set)
      : _set = set,
        super();

  final Set<T> _set;

  @override
  Iterable<T> get iter => _set;

  @override
  Set<T> get set => _set;

  @override
  Set<T> asSet() => _set;

  @override
  bool contains(T element) => _set.contains(element);

  @override
  bool containsAll(KtCollection<T> elements) {
    return elements.all(_set.contains);
  }

  @override
  bool isEmpty() => _set.isEmpty;

  @override
  KtMutableIterator<T> iterator() => _MutableSetIterator(this);

  @override
  int get size => _set.length;

  @override
  int get hashCode =>
      hashObjects(_set.map((e) => e.hashCode).toList(growable: false)..sort());

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! KtSet) return false;
    if (other.size != size) return false;
    if (other.hashCode != hashCode) return false;
    if (other is KtSet<T>) {
      return containsAll(other);
    } else {
      return other.containsAll(this);
    }
  }

  @override
  bool add(T element) => _set.add(element);

  @override
  bool addAll(KtIterable<T> elements) {
    final oldSize = size;
    _set.addAll(elements.iter);
    return size != oldSize;
  }

  @override
  void clear() => _set.clear();

  @override
  bool remove(T element) => _set.remove(element);

  @override
  bool removeAll(KtIterable<T> elements) {
    final oldSize = size;
    for (final value in elements.iter) {
      _set.remove(value);
    }
    return oldSize != size;
  }

  @override
  bool retainAll(KtIterable<T> elements) {
    final oldSize = size;
    _set.removeWhere((it) => !elements.contains(it));
    return oldSize != size;
  }

  @override
  String toString() {
    return joinToString(
      separator: ", ",
      prefix: "[",
      postfix: "]",
      transform: (it) =>
          identical(it, this) ? "(this Collection)" : it.toString(),
    );
  }
}

class _MutableSetIterator<T> extends KtMutableIterator<T> {
  _MutableSetIterator(this.set)
      : _iterator = set.iter.iterator,
        lastReturned = null {
    _hasNext = _iterator.moveNext();
    if (_hasNext) {
      nextValue = _iterator.current;
    }
  }

  final Iterator<T> _iterator;
  T? nextValue;
  T? lastReturned;
  bool _hasNext = false;
  final KtMutableSet<T> set;

  @override
  bool hasNext() => _hasNext;

  @override
  T next() {
    if (!_hasNext) throw const NoSuchElementException();
    final e = nextValue;
    _hasNext = _iterator.moveNext();
    if (_hasNext) {
      nextValue = _iterator.current;
    }
    lastReturned = e;
    return e as T;
  }

  @override
  void remove() {
    final lastReturned = this.lastReturned;
    if (lastReturned == null) throw StateError('remove() must be called after next()');
    set.remove(lastReturned);
    this.lastReturned = null;
  }
}
