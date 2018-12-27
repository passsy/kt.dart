import 'package:dart_kollection/dart_kollection.dart';

/**
 * Classes that inherit from this interface can be represented as a sequence of elements that can
 * be iterated over.
 * @param T the type of element being iterated over. The iterator is covariant on its element type.
 */
abstract class KIterable<T> implements KIterableExtension<T> {
  /**
   * dart interop iterable for loops
   */
  Iterable<T> get iter;

  /**
   * Returns an iterator over the elements of this object.
   */
  KIterator<T> iterator();
}

abstract class KIterableExtension<T> {
  /**
   * Returns `true` if all elements match the given [predicate].
   */
  bool all(bool Function(T element) predicate);

  /**
   * Returns `true` if at least one element matches the given [predicate].
   *
   * Returns `true` if collection has at least one element when no [predicate] is provided
   */
  bool any([bool Function(T element) predicate]);

  /**
   * Returns this collection as an [Iterable].
   */
  KIterable<T> asIterable();

  /**
   * Returns a [Map] containing key-value pairs provided by [transform] function
   * applied to elements of the given collection.
   *
   * If any of two pairs would have the same key the last one gets added to the map.
   *
   * The returned map preserves the entry iteration order of the original collection.
   */
  KMap<K, V> associate<K, V>(KPair<K, V> Function(T) transform);

  /**
   * Returns a [Map] containing the elements from the given collection indexed by the key
   * returned from [keySelector] function applied to each element.
   *
   * If any two elements would have the same key returned by [keySelector] the last one gets added to the map.
   *
   * The returned map preserves the entry iteration order of the original collection.
   */
  KMap<K, T> associateBy<K>(K Function(T) keySelector);

  /**
   * Returns a [Map] containing the elements from the given collection indexed by the key
   * returned from [keySelector] function applied to each element. The element can be transformed with [valueTransform].
   *
   * If any two elements would have the same key returned by [keySelector] the last one gets added to the map.
   *
   * The returned map preserves the entry iteration order of the original collection.
   */
  KMap<K, V> associateByTransform<K, V>(
      K Function(T) keySelector, V Function(T) valueTransform);

  /**
   * Populates and returns the [destination] mutable map with key-value pairs,
   * where key is provided by the [keySelector] function and
   * and value is provided by the [valueTransform] function applied to elements of the given collection.
   *
   * If any two elements would have the same key returned by [keySelector] the last one gets added to the map.
   */
  M associateByTo<K, V, M extends KMutableMap<K, V>>(
      M destination, K Function(T) keySelector,
      [V Function(T) valueTransform]);

  /**
   * Populates and returns the [destination] mutable map with key-value pairs
   * provided by [transform] function applied to each element of the given collection.
   *
   * If any of two pairs would have the same key the last one gets added to the map.
   */
  M associateTo<K, V, M extends KMutableMap<K, V>>(
      M destination, KPair<K, V> Function(T) transform);

  /**
   * Returns a [Map] where keys are elements from the given collection and values are
   * produced by the [valueSelector] function applied to each element.
   *
   * If any two elements are equal, the last one gets added to the map.
   *
   * The returned map preserves the entry iteration order of the original collection.
   */
  KMap<T, V> associateWith<V>(V Function(T) valueSelector);

  /**
   * Populates and returns the [destination] mutable map with key-value pairs for each element of the given collection,
   * where key is the element itself and value is provided by the [valueSelector] function applied to that key.
   *
   * If any two elements are equal, the last one overwrites the former value in the map.
   */
  M associateWithTo<V, M extends KMutableMap<T, V>>(
      M destination, V Function(T) valueSelector);

  /**
   * Returns an average value produced by [selector] function applied to each element in the collection.
   */
  double averageBy(num Function(T) selector);

  /**
   * Splits this collection into a list of lists each not exceeding the given [size].
   *
   * The last list in the resulting list may have less elements than the given [size].
   *
   * @param [size] the number of elements to take in each list, must be positive and can be greater than the number of elements in this collection.
   */
  KList<KList<T>> chunked(int size);

  /**
   * Splits this collection into several lists each not exceeding the given [size]
   * and applies the given [transform] function to an each.
   *
   * @return list of results of the [transform] applied to an each list.
   *
   * Note that the list passed to the [transform] function is ephemeral and is valid only inside that function.
   * You should not store it or allow it to escape in some way, unless you made a snapshot of it.
   * The last list may have less elements than the given [size].
   *
   * @param [size] the number of elements to take in each list, must be positive and can be greater than the number of elements in this collection.
   *
   */
  KList<R> chunkedTransform<R>(int size, R Function(KList<T>) transform);

  /**
   * Returns `true` if [element] is found in the collection.
   */
  bool contains(T element);

  /**
   * Returns the number of elements matching the given [predicate] or the number of elements when `predicate = null`.
   */
  int count([bool Function(T) predicate]);

  /**
   * Returns a list containing only distinct elements from the given collection.
   *
   * The elements in the resulting list are in the same order as they were in the source collection.
   */
  KList<T> distinct();

  /**
   * Returns a list containing only elements from the given collection
   * having distinct keys returned by the given [selector] function.
   *
   * The elements in the resulting list are in the same order as they were in the source collection.
   */
  KList<T> distinctBy<K>(K Function(T) selector);

  /**
   * Returns a list containing all elements except first [n] elements.
   */
  KList<T> drop(int n);

  /**
   * Returns a list containing all elements except first elements that satisfy the given [predicate].
   */
  KList<T> dropWhile(bool Function(T) predicate);

  /**
   * Returns an element at the given [index] or throws an [IndexOutOfBoundsException] if the [index] is out of bounds of this collection.
   */
  @nonNull
  T elementAt(int index);

  /**
   * Returns an element at the given [index] or the result of calling the [defaultValue] function if the [index] is out of bounds of this collection.
   */
  @nonNull
  T elementAtOrElse(int index, T Function(int) defaultValue);

  /**
   * Returns an element at the given [index] or `null` if the [index] is out of bounds of this collection.
   */
  @nullable
  T elementAtOrNull(int index);

  /**
   * Returns a list containing only elements matching the given [predicate].
   */
  KList<T> filter(bool Function(T) predicate);

  /**
   * Returns a list containing only elements matching the given [predicate].
   * @param [predicate] function that takes the index of an element and the element itself
   * and returns the result of predicate evaluation on the element.
   */
  KList<T> filterIndexed(bool Function(int index, T) predicate);

  /**
   * Appends all elements matching the given [predicate] to the given [destination].
   * @param [predicate] function that takes the index of an element and the element itself
   * and returns the result of predicate evaluation on the element.
   */
  C filterIndexedTo<C extends KMutableCollection<T>>(
      C destination, bool Function(int index, T) predicate);

  /**
   * Returns a list containing all elements that are instances of specified type parameter R.
   */
  KList<R> filterIsInstance<R>();

  /**
   * Returns a list containing all elements not matching the given [predicate].
   */
  KList<T> filterNot(bool Function(T) predicate);

  /**
   * Returns a list containing all elements that are not `null`.
   */
  KList<T> filterNotNull();

  /**
   * Appends all elements that are not `null` to the given [destination].
   */
  C filterNotNullTo<C extends KMutableCollection<T>>(C destination);

  /**
   * Appends all elements not matching the given [predicate] to the given [destination].
   */
  C filterNotTo<C extends KMutableCollection<T>>(
      C destination, bool Function(T) predicate);

  /**
   * Appends all elements matching the given [predicate] to the given [destination].
   */
  C filterTo<C extends KMutableCollection<T>>(
      C destination, bool Function(T) predicate);

  /**
   * Returns the first element matching the given [predicate], or `null` if no such element was found.
   */
  @nullable
  T find(bool Function(T) predicate);

  /**
   * Returns the last element matching the given [predicate], or `null` if no such element was found.
   */
  @nullable
  T findLast(bool Function(T) predicate);

  /**
   * Returns first element.
   *
   * Use [predicate] to return the first element matching the given [predicate]
   *
   * @throws [NoSuchElementException] if the collection is empty.
   */
  @nonNull
  T first([bool Function(T) predicate]);

  /**
   * Returns the first element (matching [predicate] when provided), or `null` if the collection is empty.
   */
  @nullable
  T firstOrNull([bool Function(T) predicate]);

  /**
   * Returns a single list of all elements yielded from results of [transform] function being invoked on each element of original collection.
   */
  KList<R> flatMap<R>(KIterable<R> Function(T) transform);

  /**
   * Appends all elements yielded from results of [transform] function being invoked on each element of original collection, to the given [destination].
   */
  C flatMapTo<R, C extends KMutableCollection<R>>(
      C destination, KIterable<R> Function(T) transform);

  /**
   * Accumulates value starting with [initial] value and applying [operation] from left to right to current accumulator value and each element.
   */
  R fold<R>(R initial, R Function(R acc, T) operation);

  /**
   * Accumulates value starting with [initial] value and applying [operation] from left to right
   * to current accumulator value and each element with its index in the original collection.
   * @param [operation] function that takes the index of an element, current accumulator value
   * and the element itself, and calculates the next accumulator value.
   */
  R foldIndexed<R>(R initial, R Function(int index, R acc, T) operation);

  /**
   * Performs the given [action] on each element.
   */
  void forEach(void Function(T element) action);

  /**
   * Performs the given [action] on each element, providing sequential index with the element.
   * @param [action] function that takes the index of an element and the element itself
   * and performs the desired action on the element.
   */
  void forEachIndexed(void Function(int index, T element) action);

  /**
   * Groups elements of the original collection by the key returned by the given [keySelector] function
   * applied to each element and returns a map where each group key is associated with a list of corresponding elements.
   *
   * The returned map preserves the entry iteration order of the keys produced from the original collection.
   */
  KMap<K, KList<T>> groupBy<K>(K Function(T) keySelector);

  /**
   * Groups values returned by the [valueTransform] function applied to each element of the original collection
   * by the key returned by the given [keySelector] function applied to the element
   * and returns a map where each group key is associated with a list of corresponding values.
   *
   * The returned map preserves the entry iteration order of the keys produced from the original collection.
   */
  KMap<K, KList<V>> groupByTransform<K, V>(
      K Function(T) keySelector, V Function(T) valueTransform);

  /**
   * Groups elements of the original collection by the key returned by the given [keySelector] function
   * applied to each element and puts to the [destination] map each group key associated with a list of corresponding elements.
   *
   * @return The [destination] map.
   */
  M groupByTo<K, M extends KMutableMap<K, KMutableList<T>>>(
      M destination, K Function(T) keySelector);

  /**
   * Groups values returned by the [valueTransform] function applied to each element of the original collection
   * by the key returned by the given [keySelector] function applied to the element
   * and puts to the [destination] map each group key associated with a list of corresponding values.
   *
   * @return The [destination] map.
   */
  M groupByToTransform<K, V, M extends KMutableMap<K, KMutableList<V>>>(
      M destination, K Function(T) keySelector, V Function(T) valueTransform);

  /**
   * Returns first index of [element], or -1 if the collection does not contain element.
   */
  int indexOf(T element);

  /**
   * Returns index of the first element matching the given [predicate], or -1 if the collection does not contain such element.
   */
  int indexOfFirst(bool Function(T) predicate);

  /**
   * Returns index of the last element matching the given [predicate], or -1 if the collection does not contain such element.
   */
  int indexOfLast(bool Function(T) predicate);

  /**
   * Returns a set containing all elements that are contained by both this set and the specified collection.
   *
   * The returned set preserves the element iteration order of the original collection.
   */
  KSet<T> intersect(KIterable<T> other);

  /**
   * Creates a string from all the elements separated using [separator] and using the given [prefix] and [postfix] if supplied.
   *
   * If the collection could be huge, you can specify a non-negative value of [limit], in which case only the first [limit]
   * elements will be appended, followed by the [truncated] string (which defaults to "...").
   */
  String joinToString(
      {String separator = ", ",
      String prefix = "",
      String postfix = "",
      int limit = -1,
      String truncated = "...",
      String Function(T) transform});

  /**
   * Returns the last element matching the given [predicate].
   * @throws [NoSuchElementException] if no such element is found.
   */
  @nonNull
  T last([bool Function(T) predicate]);

  /**
   * Returns last index of [element], or -1 if the collection does not contain element.
   */
  int lastIndexOf(T element);

  /**
   * Returns the last element matching the given [predicate], or `null` if no such element was found.
   */
  @nullable
  T lastOrNull([bool Function(T) predicate]);

  /**
   * Returns a list containing the results of applying the given [transform] function
   * to each element in the original collection.
   */
  KList<R> map<R>(R Function(T) transform);

  /**
   * Returns a list containing the results of applying the given [transform] function
   * to each element and its index in the original collection.
   * @param [transform] function that takes the index of an element and the element itself
   * and returns the result of the transform applied to the element.
   */
  KList<R> mapIndexed<R>(R Function(int index, T) transform);

  /**
   * Returns a list containing only the non-null results of applying the given [transform] function
   * to each element and its index in the original collection.
   * @param [transform] function that takes the index of an element and the element itself
   * and returns the result of the transform applied to the element.
   */
  KList<R> mapIndexedNotNull<R>(R Function(int index, T) transform);

  /**
   * Applies the given [transform] function to each element and its index in the original collection
   * and appends only the non-null results to the given [destination].
   * @param [transform] function that takes the index of an element and the element itself
   * and returns the result of the transform applied to the element.
   */
  C mapIndexedNotNullTo<R, C extends KMutableCollection<R>>(
      C destination, R Function(int index, T) transform);

  /**
   * Applies the given [transform] function to each element and its index in the original collection
   * and appends the results to the given [destination].
   * @param [transform] function that takes the index of an element and the element itself
   * and returns the result of the transform applied to the element.
   */
  C mapIndexedTo<R, C extends KMutableCollection<R>>(
      C destination, R Function(int index, T) transform);

  /**
   * Returns a list containing the results of applying the given [transform] function
   * to each element in the original collection.
   */
  KList<R> mapNotNull<R>(R Function(T) transform);

  /**
   * Applies the given [transform] function to each element in the original collection
   * and appends only the non-null results to the given [destination].
   */
  C mapNotNullTo<R, C extends KMutableCollection<R>>(
      C destination, R Function(T) transform);

  /**
   * Applies the given [transform] function to each element of the original collection
   * and appends the results to the given [destination].
   */
  C mapTo<R, C extends KMutableCollection<R>>(
      C destination, R Function(T) transform);

  /**
   * Returns the largest element or `null` if there are no elements.
   */
  @TooGeneric(extensionForType: "KIterable<num>")
  @nullable
  num max();

  /**
   * Returns the first element yielding the largest value of the given function or `null` if there are no elements.
   */
  @nullable
  T maxBy<R extends Comparable<R>>(R Function(T) selector);

  /**
   * Returns the first element having the largest value according to the provided [comparator] or `null` if there are no elements.
   */
  @nullable
  T maxWith(Comparator<T> comparator);

  /**
   * Returns the smallest element or `null` if there are no elements.
   */
  @TooGeneric(extensionForType: "KIterable<num>")
  @nullable
  num min();

  /**
   * Returns a list containing all elements of the original collection except the elements contained in the given [elements] collection.
   */
  KList<T> minus(KIterable<T> elements);

  /**
   * Returns a list containing all elements of the original collection except the elements contained in the given [elements] collection.
   */
  KList<T> operator -(KIterable<T> elements);

  /**
   * Returns a list containing all elements of the original collection without the first occurrence of the given [element].
   */
  KList<T> minusElement(T element);

  /**
   * Returns the first element yielding the smallest value of the given function or `null` if there are no elements.
   */
  @nullable
  T minBy<R extends Comparable<R>>(R Function(T) selector);

  /**
   * Returns the first element having the smallest value according to the provided [comparator] or `null` if there are no elements.
   */
  @nullable
  T minWith(Comparator<T> comparator);

  /**
   * Returns `true` if the collection has no elements or no elements match the given [predicate].
   */
  bool none([bool Function(T) predicate]);

  /**
   * Performs the given [action] on each element. Use with cascade syntax to return self.
   *
   *       (listOf(["a", "b", "c"])
   *          ..onEach(print))
   *          .map((it) => it.toUpperCase())
   *          .getOrNull(0); // prints: a
   *
   * Without the cascade syntax (..) [KList.getOrNull] wouldn't be available.
   */
  void onEach(void Function(T) action);

  /**
   * Splits the original collection into pair of lists,
   * where *first* list contains elements for which [predicate] yielded `true`,
   * while *second* list contains elements for which [predicate] yielded `false`.
   */
  KPair<KList<T>, KList<T>> partition(bool Function(T) predicate);

  /**
   * Returns a list containing all elements of the original collection and then all elements of the given [elements] collection.
   */
  KList<T> plus(KIterable<T> elements);

  /**
   * Returns a list containing all elements of the original collection and then all elements of the given [elements] collection.
   */
  KList<T> operator +(KIterable<T> elements);

  /**
   * Returns a list containing all elements of the original collection and then the given [element].
   */
  KList<T> plusElement(T element);

  /**
   * Accumulates value starting with the first element and applying [operation] from left to right to current accumulator value and each element.
   */
  S reduce<S>(S Function(S acc, T) operation);

  /**
   * Accumulates value starting with the first element and applying [operation] from left to right
   * to current accumulator value and each element with its index in the original collection.
   * @param [operation] function that takes the index of an element, current accumulator value
   * and the element itself and calculates the next accumulator value.
   */
  S reduceIndexed<S>(S Function(int index, S acc, T) operation);

  /**
   * Returns an original collection containing all the non-`null` elements, throwing an [IllegalArgumentException] if there are any `null` elements.
   */
  KIterable<T> requireNoNulls();

  /**
   * Returns a list with elements in reversed order.
   */
  KList<T> reversed();

  /**
   * Returns the single element matching the given [predicate], or throws an exception if the list is empty or has more than one element.
   */
  @nonNull
  T single([bool Function(T) predicate]);

  /**
   * Returns the single element matching the given [predicate], or `null` if element was not found or more than one element was found.
   */
  @nullable
  T singleOrNull([bool Function(T) predicate]);

  /**
   * Returns a list of all elements sorted according to their natural sort order.
   */
  KList<T> sorted();

  /**
   * Returns a list of all elements sorted according to natural sort order of the value returned by specified [selector] function.
   */
  KList<T> sortedBy<R extends Comparable<R>>(R Function(T) selector);

  /**
   * Returns a list of all elements sorted descending according to natural sort order of the value returned by specified [selector] function.
   */
  KList<T> sortedByDescending<R extends Comparable<R>>(R Function(T) selector);

  /**
   * Returns a list of all elements sorted descending according to their natural sort order.
   */
  KList<T> sortedDescending();

  /**
   * Returns a list of all elements sorted according to the specified [comparator].
   */
  KList<T> sortedWith(Comparator<T> comparator);

  /**
   * Returns a set containing all elements that are contained by this collection and not contained by the specified collection.
   *
   * The returned set preserves the element iteration order of the original collection.
   */
  KSet<T> subtract(KIterable<T> other);

  /**
   * Returns the sum of all elements in the collection.
   *
   * Requires [T] to be [num]
   */
  @TooGeneric(extensionForType: "KIterable<num>")
  num sum();

  /**
   * Returns the sum of all values produced by [selector] function applied to each element in the collection.
   */
  int sumBy(int Function(T) selector);

  /**
   * Returns the sum of all values produced by [selector] function applied to each element in the collection.
   */
  double sumByDouble(double Function(T) selector);

  /**
   * Returns a list containing first [n] elements.
   */
  KList<T> take(int n);

  /**
   * Returns a HashSet of all elements.
   */
  KMutableSet<T> toHashSet();

  /**
   * Returns a [KList] containing all elements.
   */
  KList<T> toList();

  /**
   * Returns a [KMutableList] filled with all elements of this collection.
   */
  KMutableList<T> toMutableList();

  /**
   * Returns a mutable set containing all distinct elements from the given collection.
   *
   * The returned set preserves the element iteration order of the original collection.
   */
  KMutableSet<T> toMutableSet();

  /**
   * Returns a [KSet] of all elements.
   *
   * The returned set preserves the element iteration order of the original collection.
   */
  KSet<T> toSet();

  /**
   * Returns a set containing all distinct elements from both collections.
   *
   * The returned set preserves the element iteration order of the original collection.
   * Those elements of the [other] collection that are unique are iterated in the end
   * in the order of the [other] collection.
   */
  KSet<T> union(KIterable<T> other);

  /**
   * Returns a list of snapshots of the window of the given [size]
   * sliding along this collection with the given [step], where each
   * snapshot is a list.
   *
   * Several last lists may have less elements than the given [size].
   *
   * Both [size] and [step] must be positive and can be greater than the number of elements in this collection.
   * @param [size] the number of elements to take in each window
   * @param [step] the number of elements to move the window forward by on an each step, by default 1
   * @param [partialWindows] controls whether or not to keep partial windows in the end if any,
   * by default `false` which means partial windows won't be preserved
   */
  KList<KList<T>> windowed(int size,
      {int step = 1, bool partialWindows = false});

  /**
   * Returns a list of results of applying the given [transform] function to
   * an each list representing a view over the window of the given [size]
   * sliding along this collection with the given [step].
   *
   * Both [size] and [step] must be positive and can be greater than the number of elements in this collection.
   * @param [size] the number of elements to take in each window
   * @param [step] the number of elements to move the window forward by on an each step, by default 1
   * @param [partialWindows] controls whether or not to keep partial windows in the end if any,
   * by default `false` which means partial windows won't be preserved
   */
  KList<R> windowedTransform<R>(int size, R Function(KList<T>) transform,
      {int step = 1, bool partialWindows = false});

  /**
   * Returns a list of pairs built from the elements of `this` collection and [other] collection with the same index.
   * The returned list has length of the shortest collection.
   */
  KList<KPair<T, R>> zip<R>(KIterable<R> other);

  /**
   * Returns a list of values built from the elements of `this` collection and the [other] collection with the same index
   * using the provided [transform] function applied to each pair of elements.
   * The returned list has length of the shortest collection.
   */
  KList<V> zipTransform<R, V>(
      KIterable<R> other, V Function(T a, R b) transform);

  /**
   * Returns a list of pairs of each two adjacent elements in this collection.
   *
   * The returned list is empty if this collection contains less than two elements.
   */
  KList<KPair<T, T>> zipWithNext<R>();

  /**
   * Returns a list containing the results of applying the given [transform] function
   * to an each pair of two adjacent elements in this collection.
   *
   * The returned list is empty if this collection contains less than two elements.
   */
  KList<R> zipWithNextTransform<R>(R Function(T a, T b) transform);
}
