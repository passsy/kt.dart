import "package:kt_dart/collection.dart";
import "package:kt_dart/src/collection/impl/dart_unmodifiable_set_view.dart";
import "package:kt_dart/src/util/hash.dart";

class DartSet<T> extends Object implements KtSet<T> {
  DartSet([Iterable<T> iterable = const []])
      : _set = UnmodifiableSetView(Set.from(iterable)),
        super();

  final Set<T> _set;

  @override
  Iterable<T> get iter => _set;

  @override
  Set<T> get set {
    // The API of Set is mutable. Since KtSet is immutable returning a new instance
    // here prevents mutation of the underlying Set
    return Set.of(_set);
  }

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
  KtIterator<T> iterator() => _DartToKIterator(_set.iterator);

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

class _DartToKIterator<T> extends KtIterator<T> {
  _DartToKIterator(this.iterator)
      : lastReturned = null,
        _hasNext = iterator.moveNext() {
    if (_hasNext) {
      nextValue = iterator.current;
    }
  }

  final Iterator<T> iterator;
  T? nextValue;
  T? lastReturned;
  bool _hasNext;

  @override
  bool hasNext() => _hasNext;

  @override
  T next() {
    if (!_hasNext) throw const NoSuchElementException();
    final e = nextValue;
    _hasNext = iterator.moveNext();
    if (_hasNext) {
      nextValue = iterator.current;
    }
    lastReturned = e;
    return e as T;
  }
}
