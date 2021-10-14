import "package:kt_dart/collection.dart";

/// A generic collection of elements that supports adding and removing elements.
///
/// @param E the type of elements contained in the collection. The mutable collection is invariant on its element type.
abstract class KtMutableCollection<T>
    implements KtCollection<T>, KtMutableIterable<T> {
  // Query Operations
  @override
  KtMutableIterator<T> iterator();

  // Modification Operations
  /// Adds the specified element to the collection.
  ///
  /// @return `true` if the element has been added, `false` if the collection does not support duplicates
  /// and the element is already contained in the collection.
  bool add(T element);

  /// Removes a single instance of the specified element from this
  /// collection, if it is present.
  ///
  /// @return `true` if the element has been successfully removed; `false` if it was not present in the collection.
  bool remove(T element);

  /// Removes the first element from this mutable list.
  ///
  /// @return  that removed element, or throws [NoSuchElementException] if this list is empty.
  T removeFirst(KtIterable<T> elements);

  // Bulk Modification Operations
  /// Adds all of the elements in the specified collection to this collection.
  ///
  /// @return `true` if any of the specified elements was added to the collection, `false` if the collection was not modified.
  bool addAll(KtIterable<T> elements);

  /// Removes all of this collection's elements that are also contained in the specified collection.
  ///
  /// @return `true` if any of the specified elements was removed from the collection, `false` if the collection was not modified.
  bool removeAll(KtIterable<T> elements);

  /// Retains only the elements in this collection that are contained in the specified collection.
  ///
  /// @return `true` if any element was removed from the collection, `false` if the collection was not modified.
  bool retainAll(KtIterable<T> elements);

  /// Removes all elements from this collection.
  void clear();
}

extension KtMutableIterableExtensions<T> on KtMutableIterable<T> {
  /// Removes all elements from this [KtMutableIterable] that match the given [predicate].
  ///
  /// @return `true` if any element was removed from the collection, `false` if the collection was not modified.
  bool removeAllWhere(bool Function(T) predicate) =>
      _filterInPlace(predicate, true);

  /// Retains only elements of this [KtMutableIterable] that match the given [predicate]
  ///
  /// @return `true` if any element was removed from the collection, `false` if the collection was not modified.
  bool retainAllWhere(bool Function(T) predicate) =>
      _filterInPlace(predicate, false);

  bool _filterInPlace(
      bool Function(T) predicate, bool predicateResultToRemove) {
    var result = false;
    final i = iterator();
    while (i.hasNext()) {
      if (predicate(i.next()) == predicateResultToRemove) {
        i.remove();
        result = true;
      }
    }
    return result;
  }
}
