import 'package:dart_kollection/dart_kollection.dart';

/**
 * A generic collection of elements that supports adding and removing elements.
 *
 * @param E the type of elements contained in the collection. The mutable collection is invariant on its element type.
 */
@Deprecated(
    "Please migrate to kotlin.dart https://github.com/passsy/kotlin.dart")
abstract class KMutableCollection<T>
    implements
        KCollection<T>,
        KMutableIterable<T>,
        KMutableCollectionExtension<T> {
  // Query Operations
  @override
  KMutableIterator<T> iterator();

  // Modification Operations
  /**
   * Adds the specified element to the collection.
   *
   * @return `true` if the element has been added, `false` if the collection does not support duplicates
   * and the element is already contained in the collection.
   */
  bool add(T element);

  /**
   * Removes a single instance of the specified element from this
   * collection, if it is present.
   *
   * @return `true` if the element has been successfully removed; `false` if it was not present in the collection.
   */
  bool remove(T element);

  // Bulk Modification Operations
  /**
   * Adds all of the elements in the specified collection to this collection.
   *
   * @return `true` if any of the specified elements was added to the collection, `false` if the collection was not modified.
   */
  bool addAll(KIterable<T> elements);

  /**
   * Removes all of this collection's elements that are also contained in the specified collection.
   *
   * @return `true` if any of the specified elements was removed from the collection, `false` if the collection was not modified.
   */
  bool removeAll(KIterable<T> elements);

  /**
   * Retains only the elements in this collection that are contained in the specified collection.
   *
   * @return `true` if any element was removed from the collection, `false` if the collection was not modified.
   */
  bool retainAll(KIterable<T> elements);

  /**
   * Removes all elements from this collection.
   */
  void clear();
}

abstract class KMutableCollectionExtension<T> {}
