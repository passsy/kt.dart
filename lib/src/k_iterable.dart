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
   * Returns `true` if [element] is found in the collection.
   */
  bool contains(T element);

  /**
   * Returns a list containing all elements except first [n] elements.
   */
  KIterable<T> drop(int n);

  /**
   * Returns a list containing all elements except first elements that satisfy the given [predicate].
   */
  KIterable<T> dropWhile([bool Function(T) predicate]);

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
}
