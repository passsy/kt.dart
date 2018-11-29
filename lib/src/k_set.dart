import 'package:dart_kollection/dart_kollection.dart';

/**
 * A generic unordered collection of elements that does not support duplicate elements.
 * Methods in this interface support only read-only access to the set;
 * read/write access is supported through the [KMutableSet] interface.
 * @param E the type of elements contained in the set. The set is covariant on its element type.
 */
abstract class KSet<T> implements KCollection<T> {
  /**
   * dart interop list for time critical operations such as sorting
   */
  Set<T> get set;

  // Query Operations
  @override
  int get size;

  @override
  bool isEmpty();

  @override
  bool contains(T element);

  @override
  bool containsAll(KCollection<T> elements);

  // Bulk Operations
  @override
  KIterator<T> iterator();
}
