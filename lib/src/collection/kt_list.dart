import 'package:kt_dart/collection.dart';
import 'package:kt_dart/src/collection/impl/list.dart';
import 'package:kt_dart/src/collection/impl/list_empty.dart';
import 'package:kt_dart/src/util/arguments.dart';

/// A generic ordered collection of elements. Methods in this interface support only read-only access to the list;
/// read/write access is supported through the [KtMutableList] interface.
/// @param [T] the type of elements contained in the list. The list is covariant on its element type.
abstract class KtList<T> implements KtCollection<T>, KtListExtension<T> {
  /// Returns an empty read-only list.
  factory KtList.empty() => EmptyList<T>();

  /// Returns a new read-only list based on [elements].
  factory KtList.from([@nonNull Iterable<T> elements = const []]) {
    assert(() {
      if (elements == null) throw ArgumentError("elements can't be null");
      return true;
    }());
    if (elements.isEmpty) return EmptyList();
    return DartList(elements);
  }

  /// Returns a new read-only list of given elements.
  ///
  /// Elements aren't allowed to be `null`. If your list requires `null` values use [KtList.from]
  factory KtList.of(
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
    return KtList.from(args);
  }

  /// Deprecated, use [asList] or [iter] for loops
  @Deprecated("use asList() or iter instead")
  List<T> get list;

  // Query Operations
  @override
  int get size;

  /// Returns a read-only dart:core [List]
  ///
  /// This method can be used to interop between the dart:collection and the
  /// kt.dart world.
  ///
  /// - Use [iter] to iterate over the elements of this [KtList] using a for-loop
  /// - Use [toList] to copy the list
  List<T> asList();

  @override
  bool isEmpty();

  @override
  bool contains(T element);

  @override
  KtIterator<T> iterator();

  // Bulk Operations
  @override
  bool containsAll(KtCollection<T> elements);

  // Positional Access Operations
  /// Returns the element at the specified index in the list or throw [IndexOutOfBoundsException]
  @nullable
  T get(int index);

  /// Returns the element at the specified index in the list or throw [IndexOutOfBoundsException]
  @nullable
  T operator [](int index);

  // Search Operations
  /// Returns the index of the first occurrence of the specified element in the list, or -1 if the specified
  /// element is not contained in the list.
  @override
  int indexOf(T element);

  /// Returns the index of the last occurrence of the specified element in the list, or -1 if the specified
  /// element is not contained in the list.
  @override
  int lastIndexOf(T element);

  // List Iterators
  /// Returns a list iterator over the elements in this list (in proper sequence), starting at the specified [index] or `0` by default.
  KtListIterator<T> listIterator([int index = 0]);

  // View
  /// Returns a view of the portion of this list between the specified [fromIndex] (inclusive) and [toIndex] (exclusive).
  /// The returned list is backed by this list, so non-structural changes in the returned list are reflected in this list, and vice-versa.
  ///
  /// Structural changes in the base list make the behavior of the view undefined.
  KtList<T> subList(int fromIndex, int toIndex);
}

abstract class KtListExtension<T> {
  /// Returns a list containing all elements except last [n] elements.
  KtList<T> dropLast(int n);

  /// Returns a list containing all elements except last elements that satisfy the given [predicate].
  KtList<T> dropLastWhile(bool Function(T) predicate);

  /// Returns an element at the given [index] or throws an [IndexOutOfBoundsException] if the [index] is out of bounds of this list.
  @nonNull
  T elementAt(int index);

  /// Returns an element at the given [index] or the result of calling the [defaultValue] function if the [index] is out of bounds of this list.
  @nonNull
  T elementAtOrElse(int index, T defaultValue(int index));

  /// Returns an element at the given [index] or `null` if the [index] is out of bounds of this collection.
  @nullable
  T elementAtOrNull(int index);

  /// Returns first element.
  ///
  /// Use [predicate] to return the first element matching the given [predicate]
  ///
  /// @throws [NoSuchElementException] if the collection is empty.
  @nonNull
  T first([bool Function(T) predicate]);

  /// Accumulates value starting with [initial] value and applying [operation] from right to left to each element and current accumulator value.
  R foldRight<R>(R initial, R Function(T, R acc) operation);

  /// Accumulates value starting with [initial] value and applying [operation] from right to left
  /// to each element with its index in the original list and current accumulator value.
  /// @param [operation] function that takes the index of an element, the element itself
  /// and current accumulator value, and calculates the next accumulator value.
  R foldRightIndexed<R>(R initial, R Function(int index, T, R acc) operation);

  /// Returns an element at the given [index] or the result of calling the [defaultValue] function if the [index] is out of bounds of this list.
  @nonNull
  T getOrElse(int index, T Function(int) defaultValue);

  /// Returns an element at the given [index] or `null` if the [index] is out of bounds of this list.
  @nullable
  T getOrNull(int index);

  /// Returns the last element matching the given [predicate].
  /// @throws [NoSuchElementException] if no such element is found.
  @nonNull
  T last([bool Function(T) predicate]);

  /// Returns the index of the last item in the list or -1 if the list is empty.
  int get lastIndex;

  /// Accumulates value starting with last element and applying [operation] from right to left to each element and current accumulator value.
  S reduceRight<S>(S Function(T, S acc) operation);

  /// Accumulates value starting with last element and applying [operation] from right to left
  /// to each element with its index in the original list and current accumulator value.
  /// @param [operation] function that takes the index of an element, the element itself
  /// and current accumulator value, and calculates the next accumulator value.
  S reduceRightIndexed<S>(S Function(int index, T, S acc) operation);

  /// Returns a list containing elements at specified [indices].
  KtList<T> slice(KtIterable<int> indices);

  /// Returns a list containing last [n] elements.
  KtList<T> takeLast(int n);

  /// Returns a list containing last elements satisfying the given [predicate].
  KtList<T> takeLastWhile(bool Function(T) predicate);
}
