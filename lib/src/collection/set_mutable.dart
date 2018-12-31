import 'package:dart_kollection/dart_kollection.dart';
import 'package:dart_kollection/src/extension/collection_extension_mixin.dart';
import 'package:dart_kollection/src/extension/iterable_extension_mixin.dart';
import 'package:dart_kollection/src/extension/iterable_mutable_extension_mixin.dart';
import 'package:dart_kollection/src/util/hash.dart';

class DartMutableSet<T>
    with
        KIterableExtensionsMixin<T>,
        KCollectionExtensionMixin<T>,
        KMutableIterableExtensionsMixin<T>
    implements KMutableSet<T> {
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

  final Set<T> _set;

  @override
  Iterable<T> get iter => _set;

  @override
  Set<T> get set => _set;

  @override
  bool contains(T element) => _set.contains(element);

  @override
  bool containsAll(KCollection<T> elements) {
    assert(() {
      if (elements == null) throw ArgumentError("elements can't be null");
      return true;
    }());
    return elements.all((it) => _set.contains(it));
  }

  @override
  bool isEmpty() => _set.isEmpty;

  @override
  KMutableIterator<T> iterator() => _MutableSetIterator(this);

  @override
  int get size => _set.length;

  @override
  int get hashCode =>
      hashObjects(_set.map((e) => e.hashCode).toList(growable: false)..sort());

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! KSet) return false;
    if (other.size != size) return false;
    if (other.hashCode != hashCode) return false;
    if (other is KSet<T>) {
      return containsAll(other);
    }
    return false;
  }

  @override
  bool add(T element) {
    return _set.add(element);
  }

  @override
  bool addAll(KIterable<T> elements) {
    assert(() {
      if (elements == null) throw ArgumentError("elements can't be null");
      return true;
    }());
    var oldSize = size;
    _set.addAll(elements.iter);
    return size != oldSize;
  }

  @override
  void clear() => _set.clear();

  @override
  bool remove(T element) => _set.remove(element);

  @override
  bool removeAll(KIterable<T> elements) {
    assert(() {
      if (elements == null) throw ArgumentError("elements can't be null");
      return true;
    }());
    final oldSize = size;
    for (var value in elements.iter) {
      _set.remove(value);
    }
    return oldSize != size;
  }

  @override
  bool retainAll(KIterable<T> elements) {
    assert(() {
      if (elements == null) throw ArgumentError("elements can't be null");
      return true;
    }());
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
    // removing from list is wrong because is is a copy of the original list.
    // remove should modify the underlying list, not the copy
    // see how kotlin solved this:
    // https://github.com/JetBrains/kotlin/blob/ba6da7c40a6cc502508faf6e04fa105b96bc7777/libraries/stdlib/js/src/kotlin/collections/InternalHashCodeMap.kt
    throw UnimplementedError(
        "remove() in not yet implemented. Please vote for https://github.com/passsy/dart_kollection/issues/5 for prioritization");
  }
}
