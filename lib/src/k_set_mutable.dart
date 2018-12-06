import 'package:dart_kollection/dart_kollection.dart';

/**
 * A generic unordered collection of elements that does not support duplicate elements, and supports
 * adding and removing elements.
 * @param E the type of elements contained in the set. The mutable set is invariant on its element type.
 */
abstract class KMutableSet<T> implements KSet<T>, KMutableCollection<T> {
  // Query Operations
  @override
  KMutableIterator<T> iterator();

  // Modification Operations
  @override
  bool add(T element);

  @override
  bool remove(T element);

  // Bulk Modification Operations
  @override
  bool addAll(KIterable<T> elements);

  @override
  bool removeAll(KIterable<T> elements);

  @override
  bool retainAll(KIterable<T> elements);

  @override
  void clear();
}
