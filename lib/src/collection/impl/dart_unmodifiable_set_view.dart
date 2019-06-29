import "dart:collection";

/// An unmodifiable set.
///
/// An UnmodifiableSetView contains a [Set] object and ensures
/// that it does not change.
/// Methods that would change the set,
/// such as [add] and [remove], throw an [UnsupportedError].
/// Permitted operations defer to the wrapped set.
class UnmodifiableSetView<E> extends Object
    with IterableMixin<E>
    implements Set<E> {
  UnmodifiableSetView(Set<E> set) : _set = set;

  final Set<E> _set;

  @override
  Iterator<E> get iterator => _set.iterator;

  @override
  int get length => _set.length;

  @override
  Set<T> cast<T>() => _set.cast<T>();

  @override
  bool containsAll(Iterable<Object> other) => _set.containsAll(other);

  @override
  Set<E> difference(Set<Object> other) => _set.difference(other);

  @override
  Set<E> intersection(Set<Object> other) => _set.intersection(other);

  @override
  E lookup(Object object) => _set.lookup(object);

  @override
  Set<E> union(Set<E> other) => _set.union(other);

  @override
  Set<E> toSet() => _set.toSet();

  static T _throw<T>() =>
      throw UnsupportedError("Cannot modify an unmodifiable Set");

  /// Throws an [UnsupportedError];
  /// operations that change the set are disallowed.
  @override
  bool add(E value) => _throw();

  /// Throws an [UnsupportedError];
  /// operations that change the set are disallowed.
  @override
  void addAll(Iterable<E> elements) => _throw();

  /// Throws an [UnsupportedError];
  /// operations that change the set are disallowed.
  @override
  bool remove(Object value) => _throw();

  /// Throws an [UnsupportedError];
  /// operations that change the set are disallowed.
  @override
  void removeAll(Iterable elements) => _throw();

  /// Throws an [UnsupportedError];
  /// operations that change the set are disallowed.
  @override
  void retainAll(Iterable elements) => _throw();

  /// Throws an [UnsupportedError];
  /// operations that change the set are disallowed.
  @override
  void removeWhere(bool test(E element)) => _throw();

  /// Throws an [UnsupportedError];
  /// operations that change the set are disallowed.
  @override
  void retainWhere(bool test(E element)) => _throw();

  /// Throws an [UnsupportedError];
  /// operations that change the set are disallowed.
  @override
  void clear() => _throw();
}
