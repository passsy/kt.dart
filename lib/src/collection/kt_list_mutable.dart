import 'package:kt_dart/collection.dart';
import 'package:kt_dart/src/collection/impl/list_mutable.dart';
import 'package:kt_dart/src/util/arguments.dart';

/// A generic ordered collection of elements that supports adding and removing elements.
/// @param E the type of elements contained in the list. The mutable list is invariant on its element type.
abstract class KtMutableList<T>
    implements KtList<T>, KtMutableCollection<T>, KtMutableListExtension<T> {
  factory KtMutableList.empty() => DartMutableList<T>();

  factory KtMutableList.from([Iterable<T> elements = const []]) {
    if (elements.isEmpty) return DartMutableList<T>();
    return DartMutableList(elements);
  }

  factory KtMutableList.of(
      [T arg0,
      T arg1,
      T arg2,
      T arg3,
      T arg4,
      T arg5,
      T arg6,
      T arg7,
      T arg8,
      T arg9]) {
    final args =
        argsToList(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    return KtMutableList.from(args);
  }

  /// Creates a [List] instance that wraps the original [KtList]. It acts as a view.
  ///
  /// Mutations on the returned [List] are reflected on the original [KtList]
  /// and vice versa.
  ///
  /// This method can be used to interop between the dart:collection and the
  /// kt.dart world.
  ///
  /// - Use [iter] to iterate over the elements of this [KtList] using a for-loop
  /// - Use [toList] to copy the list
  @override
  List<T> asList();

  // Modification Operations
  /// Adds the specified element to the end of this list.
  ///
  /// @return `true` because the list is always modified as the result of this operation.
  @override
  bool add(T element);

  @override
  bool remove(T element);

  // Bulk Modification Operations
  /// Adds all of the elements of the specified collection to the end of this list.
  ///
  /// The elements are appended in the order they appear in the [elements] collection.
  ///
  /// @return `true` if the list was changed as the result of the operation.
  @override
  bool addAll(KtIterable<T> elements);

  /// Inserts all of the elements in the specified collection [elements] into this list at the specified [index].
  ///
  /// @return `true` if the list was changed as the result of the operation.
  bool addAllAt(int index, KtCollection<T> elements);

  @override
  bool removeAll(KtIterable<T> elements);

  @override
  bool retainAll(KtIterable<T> elements);

  @override
  void clear();

  // Positional Access Operations
  /// Replaces the element at the specified position in this list with the specified element.
  ///
  /// @return the element previously at the specified position.
  @nullable
  T set(int index, T element);

  /// Replaces the element at the specified position in this list with the specified element.
  void operator []=(int index, T element);

  /// Inserts an element into the list at the specified [index].
  void addAt(int index, T element);

  /// Removes an element at the specified [index] from the list.
  ///
  /// @return the element that has been removed.
  @nullable
  T removeAt(int index);

  @override
  KtMutableListIterator<T> listIterator([int index = 0]);

  @override
  KtMutableList<T> subList(int fromIndex, int toIndex);
}

abstract class KtMutableListExtension<T> {
  /// Fills the list with the provided [value].
  ///
  /// Each element in the list gets replaced with the [value].
  void fill(T value);

  /// Reverses elements in the list in-place.
  void reverse();

  /// Sorts elements in the list in-place according to natural sort order of the value returned by specified [selector] function.
  void sortBy<R extends Comparable<R>>(R Function(T) selector);

  /// Sorts elements in the list in-place descending according to natural sort order of the value returned by specified [selector] function.
  void sortByDescending<R extends Comparable<R>>(R Function(T) selector);

  /// Sorts elements in the list in-place according to the specified [comparator]
  void sortWith(Comparator<T> comparator);

  /// Swaps the elements at the specified positions in the specified list.
  /// (If the specified positions are equal, invoking this method leaves
  /// the list unchanged.)
  void swap(int indexA, int indexB);
}
