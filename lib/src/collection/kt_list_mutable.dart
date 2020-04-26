import "dart:math";

import "package:kt_dart/collection.dart";
import "package:kt_dart/src/collection/impl/list_mutable.dart";
import "package:kt_dart/src/util/arguments.dart";

/// A generic ordered collection of elements that supports adding and removing elements.
/// @param E the type of elements contained in the list. The mutable list is invariant on its element type.
abstract class KtMutableList<T> implements KtList<T>, KtMutableCollection<T> {
  factory KtMutableList.empty() => DartMutableList<T>();

  factory KtMutableList.from([@nonNull Iterable<T> elements = const []]) {
    assert(() {
      if (elements == null) throw ArgumentError("elements can't be null");
      return true;
    }());
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
      T arg9]) = KtMutableList<T>._of;

  factory KtMutableList._of([
    Object arg0 = defaultArgument,
    Object arg1 = defaultArgument,
    Object arg2 = defaultArgument,
    Object arg3 = defaultArgument,
    Object arg4 = defaultArgument,
    Object arg5 = defaultArgument,
    Object arg6 = defaultArgument,
    Object arg7 = defaultArgument,
    Object arg8 = defaultArgument,
    Object arg9 = defaultArgument,
  ]) {
    return KtMutableList.from([
      if (arg0 != defaultArgument) arg0 as T,
      if (arg1 != defaultArgument) arg1 as T,
      if (arg2 != defaultArgument) arg2 as T,
      if (arg3 != defaultArgument) arg3 as T,
      if (arg4 != defaultArgument) arg4 as T,
      if (arg5 != defaultArgument) arg5 as T,
      if (arg6 != defaultArgument) arg6 as T,
      if (arg7 != defaultArgument) arg7 as T,
      if (arg8 != defaultArgument) arg8 as T,
      if (arg9 != defaultArgument) arg9 as T,
    ]);
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

extension KtMutableListExtensions<T> on KtMutableList<T> {
  /// Creates a [List] instance that wraps the original [KtList]. It acts as a view.
  ///
  /// Mutations on the returned [List] are reflected on the original [KtList]
  /// and vice versa.
  ///
  /// This method can be used to interop between the dart:collection and the
  /// kt.dart world.
  List<T> get dart => asList();

  /// Fills the list with the provided [value].
  ///
  /// Each element in the list gets replaced with the [value].
  void fill(T value) {
    for (var i = 0; i < size; i++) {
      set(i, value);
    }
  }

  /// Reverses elements in the list in-place.
  void reverse() {
    final mid = size >> 1;

    var i = 0;
    var j = size - 1;
    while (i < mid) {
      swap(i, j);
      i++;
      j--;
    }
  }

  /// Sorts elements in the list in-place according to natural sort order of the value returned by specified [selector] function.
  void sortBy<R extends Comparable>(R Function(T) selector) {
    assert(() {
      if (selector == null) throw ArgumentError("selector can't be null");
      return true;
    }());
    if (size > 1) {
      sortWith(compareBy(selector));
    }
  }

  /// Sorts elements in the list in-place descending according to natural sort order of the value returned by specified [selector] function.
  void sortByDescending<R extends Comparable>(R Function(T) selector) {
    assert(() {
      if (selector == null) throw ArgumentError("selector can't be null");
      return true;
    }());
    if (size > 1) {
      sortWith(compareByDescending(selector));
    }
  }

  /// Sorts elements in the list in-place according to the specified [comparator]
  void sortWith(Comparator<T> comparator) {
    assert(() {
      if (comparator == null) throw ArgumentError("comparator can't be null");
      return true;
    }());
    // delegate to darts list implementation for sorting which is highly optimized
    asList().sort(comparator);
  }

  /// Swaps the elements at the specified positions in the specified list.
  /// (If the specified positions are equal, invoking this method leaves
  /// the list unchanged.)
  void swap(int indexA, int indexB) {
    final firstOld = get(indexA);
    final secondOld = set(indexB, firstOld);
    set(indexA, secondOld);
  }

  /// Shuffles elements in the list.
  void shuffle([Random random]) {
    // delegate to darts list implementation for shuffling
    asList().shuffle(random);
  }
}
