import 'package:kotlin_dart/collection.dart';
import 'package:kotlin_dart/src/collection/extension/collection_extension_mixin.dart';
import 'package:kotlin_dart/src/collection/extension/iterable_extension_mixin.dart';
import 'package:kotlin_dart/src/util/hash.dart';

class DartSet<T>
    with KtIterableExtensionsMixin<T>, KtCollectionExtensionMixin<T>
    implements KtSet<T> {
  DartSet([Iterable<T> iterable = const []])
      : _set = Set.from(iterable),
        super();

  final Set<T> _set;
  int _hashCode;

  @override
  Iterable<T> get iter => _set;

  @override
  Set<T> get set {
    // The API of Set is mutable. Since KtSet is immutable returning a new instance
    // here prevents mutation of the underlying Set
    return Set.of(_set);
  }

  @override
  bool contains(T element) => _set.contains(element);

  @override
  bool containsAll(KtCollection<T> elements) {
    assert(() {
      if (elements == null) throw ArgumentError("elements can't be null");
      return true;
    }());
    return elements.all(_set.contains);
  }

  @override
  bool isEmpty() => _set.isEmpty;

  @override
  KtIterator<T> iterator() => _DartToKIterator(_set.iterator);

  @override
  int get size => _set.length;

  @override
  int get hashCode {
    _hashCode ??= hashObjects(
        _set.map((e) => e.hashCode).toList(growable: false)..sort());
    return _hashCode;
  }

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! KtSet) return false;
    if (other.size != size) return false;
    if (other.hashCode != hashCode) return false;
    if (other is KtSet<T>) {
      return containsAll(other);
    } else {
      return (other as KtSet).containsAll(this);
    }
  }
}

class _DartToKIterator<T> extends KtIterator<T> {
  _DartToKIterator(this.iterator) {
    lastReturned = null;
    _hasNext = iterator.moveNext();
    nextValue = iterator.current;
  }

  final Iterator<T> iterator;
  T nextValue;
  T lastReturned;
  var _hasNext = false;

  @override
  bool hasNext() {
    return _hasNext;
  }

  @override
  T next() {
    if (!_hasNext) throw NoSuchElementException();
    final e = nextValue;
    _hasNext = iterator.moveNext();
    nextValue = iterator.current;
    lastReturned = e;
    return e;
  }
}
