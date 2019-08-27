import "package:kt_dart/collection.dart";
import "package:kt_dart/src/collection/extension/collection_extension_mixin.dart";
import "package:kt_dart/src/collection/extension/iterable_extension_mixin.dart";
import "package:kt_dart/src/collection/extension/iterable_mutable_extension_mixin.dart";
import "package:kt_dart/src/util/hash.dart";

class DartMutableSet<T> extends Object
    with
        KtIterableExtensionsMixin<T>,
        KtCollectionExtensionMixin<T>,
        KtMutableIterableExtensionsMixin<T>
    implements KtMutableSet<T> {
  DartMutableSet([Iterable<T> iterable = const []])
      : _set = Set.from(iterable),
        super();

  /// Doesn't copy the incoming list which is more efficient but risks accidental modification of the incoming map.
  ///
  /// Use with care!
  DartMutableSet.noCopy(Set<T> set)
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
    assert(() {
      if (elements == null) throw ArgumentError("elements can't be null");
      return true;
    }());
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
    } else if (other is KtSet) {
      return other.containsAll(this);
    }
    return false;
  }

  @override
  bool add(T element) => _set.add(element);

  @override
  bool addAll(KtIterable<T> elements) {
    assert(() {
      if (elements == null) throw ArgumentError("elements can't be null");
      return true;
    }());
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
    assert(() {
      if (elements == null) throw ArgumentError("elements can't be null");
      return true;
    }());
    final oldSize = size;
    for (final value in elements.iter) {
      _set.remove(value);
    }
    return oldSize != size;
  }

  @override
  bool retainAll(KtIterable<T> elements) {
    assert(() {
      if (elements == null) throw ArgumentError("elements can't be null");
      return true;
    }());
    final oldSize = size;
    _set.removeWhere((it) => !elements.contains(it));
    return oldSize != size;
  }
}

class _MutableSetIterator<T> extends KtMutableIterator<T> {
  _MutableSetIterator(KtMutableSet<T> set)
      : _set = set,
        _iterator = set.iter.iterator {
    lastReturned = null;
    _hasNext = _iterator.moveNext();
    nextValue = _iterator.current;
  }

  final KtMutableSet<T> _set;
  final Iterator<T> _iterator;
  T nextValue;
  T lastReturned;
  bool _hasNext;

  @override
  bool hasNext() => _hasNext;

  @override
  T next() {
    if (!_hasNext) throw const NoSuchElementException();
    final e = nextValue;
    _hasNext = _iterator.moveNext();
    nextValue = _iterator.current;
    lastReturned = e;
    return e;
  }

  @override
  void remove() {
    // removing from list is wrong because is is a copy of the original list.
    // remove should modify the underlying list, not the copy
    // see how kotlin solved this:
    // https://github.com/JetBrains/kotlin/blob/ba6da7c40a6cc502508faf6e04fa105b96bc7777/libraries/stdlib/js/src/kotlin/collections/InternalHashCodeMap.kt
    throw UnimplementedError(
        "remove() in not yet implemented. Please vote for https://github.com/passsy/dart_kollection/issues/5 for prioritization");
  }
}
