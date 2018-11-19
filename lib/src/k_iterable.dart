import 'package:dart_kollection/dart_kollection.dart';

/**
 * Classes that inherit from this interface can be represented as a sequence of elements that can
 * be iterated over.
 * @param T the type of element being iterated over. The iterator is covariant on its element type.
 */
abstract class KIterable<T> implements KIterableExtensions<T> {
  /**
   * dart interop iterable for loops
   */
  Iterable<T> get iter;

  /**
   * Returns an iterator over the elements of this object.
   */
  KIterator<T> iterator();
}

abstract class KIterableExtensions<T> {
  /**
   * Returns `true` if all elements match the given [predicate].
   */
  bool all([bool Function(T element) predicate = null]);

  /**
   * Returns `true` if at least one element matches the given [predicate].
   */
  bool any([bool Function(T element) predicate = null]);

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
   * Performs the given [action] on each element.
   */
  void forEach(void action(T element));
}
