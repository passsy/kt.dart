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
   */
  bool any([bool Function(T element) predicate]);

  /**
   * Returns this collection as an [Iterable].
   */
  KIterable<T> asIterable() => this;

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
   * returned from [keySelector] function applied to each element. The element can be transformed with [valueTransform].
   *
   * If any two elements would have the same key returned by [keySelector] the last one gets added to the map.
   *
   * The returned map preserves the entry iteration order of the original collection.
   */
  KMap<K, V> associateBy<K, V>(K Function(T) keySelector, [V Function(T) valueTransform]);

  /**
   * Populates and returns the [destination] mutable map with key-value pairs,
   * where key is provided by the [keySelector] function and
   * and value is provided by the [valueTransform] function applied to elements of the given collection.
   *
   * If any two elements would have the same key returned by [keySelector] the last one gets added to the map.
   */
  M associateByTo<K, V, M extends KMutableMap<K, V>>(M destination, K Function(T) keySelector,
      [V Function(T) valueTransform]);

  /**
   * Populates and returns the [destination] mutable map with key-value pairs
   * provided by [transform] function applied to each element of the given collection.
   *
   * If any of two pairs would have the same key the last one gets added to the map.
   */
  M associateTo<K, V, M extends KMutableMap<K, V>>(M destination, KPair<K, V> Function(T) transform);

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
  M associateWithTo<V, M extends KMutableMap<T, V>>(M destination, V Function(T) valueSelector);

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
   * Returns the number of elements in this collection.
   */
  int count();

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
  KIterable<T> drop(int n);

  /**
   * Returns a list containing all elements except first elements that satisfy the given [predicate].
   */
  KIterable<T> dropWhile(bool Function(T) predicate);

  /**
   * Returns an element at the given [index] or throws an [IndexOutOfBoundsException] if the [index] is out of bounds of this collection.
   */
  @nonNull
  T elementAt(int index);

  /**
   * Returns an element at the given [index] or the result of calling the [defaultValue] function if the [index] is out of bounds of this collection.
   */
  @nullable
  T elementAtOrElse(int index, T Function(int) defaultValue);

  /**
   * Returns an element at the given [index] or `null` if the [index] is out of bounds of this collection.
   */
  @nullable
  T elementAtOrNull(int index);

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
  @nullable
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
  C flatMapTo<R, C extends KMutableCollection<R>>(C destination, KIterable<R> Function(T) transform);

  /**
   * Performs the given [action] on each element.
   */
  void forEach(void Function(T element) action);

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
  @nullable
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
  KIterable<R> map<R>(R Function(T) transform);

  /**
   * Applies the given [transform] function to each element of the original collection
   * and appends the results to the given [destination].
   */
  C mapTo<R, C extends KMutableCollection<R>>(C destination, R Function(T) transform);

  /**
   * Returns the single element matching the given [predicate], or throws exception if there is no or more than one matching element.
   */
  @nullable
  T single([bool Function(T) predicate]);

  /**
   * Returns the single element matching the given [predicate], or `null` if element was not found or more than one element was found.
   */
  @nullable
  T singleOrNull([bool Function(T) predicate]);

  /**
   * Returns the sum of all elements in the collection.
   *
   * Requires [T] to be [num]
   */
  @TooGeneric(type: "KIterable<num>")
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
   * Appends all elements to the given [destination] collection.
   */
  C toCollection<C extends KMutableCollection<T>>(C destination);

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
  KList<KList<T>> windowed(int size, {int step = 1, bool partialWindows = false});

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
  KList<R> windowedTransform<R>(int size, R Function(KList<T>) transform, {int step = 1, bool partialWindows = false});
}
