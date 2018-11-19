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

/**
 * Classes that inherit from this interface can be represented as a sequence of elements that can
 * be iterated over and that supports removing elements during iteration.
 * @param T the type of element being iterated over. The mutable iterator is invariant on its element type.
 */
abstract class KMutableIterable<T> implements KIterable<T> {
  /**
   * Returns an iterator over the elements of this sequence that supports removing elements during iteration.
   */
  KMutableIterator<T> iterator();
}

/**
 * A generic collection of elements. Methods in this interface support only read-only access to the collection;
 * read/write access is supported through the [KMutableCollection] interface.
 * @param E the type of elements contained in the collection. The collection is covariant on its element type.
 */
abstract class KCollection<E> implements KIterable<E> {
  const KCollection() : super();

  // Query Operations
  /**
   * Returns the size of the collection.
   */
  int get size;

  /**
   * Returns `true` if the collection is empty (contains no elements), `false` otherwise.
   */
  bool isEmpty();

  /**
   * Checks if the specified element is contained in this collection.
   */
  bool contains(E element);

  KIterator<E> iterator();

  // Bulk Operations
  /**
   * Checks if all elements in the specified collection are contained in this collection.
   */
  bool containsAll(KCollection<E> elements);
}

/**
 * A generic collection of elements that supports adding and removing elements.
 *
 * @param E the type of elements contained in the collection. The mutable collection is invariant on its element type.
 */
abstract class KMutableCollection<E> implements KCollection<E>, KMutableIterable<E> {
  // Query Operations
  KMutableIterator<E> iterator();

  // Modification Operations
  /**
   * Adds the specified element to the collection.
   *
   * @return `true` if the element has been added, `false` if the collection does not support duplicates
   * and the element is already contained in the collection.
   */
  bool add(E element);

  /**
   * Removes a single instance of the specified element from this
   * collection, if it is present.
   *
   * @return `true` if the element has been successfully removed; `false` if it was not present in the collection.
   */
  bool remove(E element);

  // Bulk Modification Operations
  /**
   * Adds all of the elements in the specified collection to this collection.
   *
   * @return `true` if any of the specified elements was added to the collection, `false` if the collection was not modified.
   */
  bool addAll(KCollection<E> elements);

  /**
   * Removes all of this collection's elements that are also contained in the specified collection.
   *
   * @return `true` if any of the specified elements was removed from the collection, `false` if the collection was not modified.
   */
  bool removeAll(KCollection<E> elements);

  /**
   * Retains only the elements in this collection that are contained in the specified collection.
   *
   * @return `true` if any element was removed from the collection, `false` if the collection was not modified.
   */
  bool retainAll(KCollection<E> elements);

  /**
   * Removes all elements from this collection.
   */
  void clear();
}

/**
 * A generic ordered collection of elements. Methods in this interface support only read-only access to the list;
 * read/write access is supported through the [KMutableList] interface.
 * @param E the type of elements contained in the list. The list is covariant on its element type.
 */
abstract class KList<E> implements KCollection<E> {
  // Query Operations
  int get size;

  // Positional Access Operations
  /**
   * Returns the element at the specified index in the list.
   */
  E get(int index);

  // Search Operations
  /**
   * Returns the index of the first occurrence of the specified element in the list, or -1 if the specified
   * element is not contained in the list.
   */
  int indexOf(E element);

  /**
   * Returns the index of the last occurrence of the specified element in the list, or -1 if the specified
   * element is not contained in the list.
   */
  int lastIndexOf(E element);

  // List Iterators
  /**
   * Returns a list iterator over the elements in this list (in proper sequence), starting at the specified [index] or `0` by default.
   */
  KListIterator<E> listIterator([int index = 0]);

  // View
  /**
   * Returns a view of the portion of this list between the specified [fromIndex] (inclusive) and [toIndex] (exclusive).
   * The returned list is backed by this list, so non-structural changes in the returned list are reflected in this list, and vice-versa.
   *
   * Structural changes in the base list make the behavior of the view undefined.
   */
  KList<E> subList(int fromIndex, int toIndex);
}

/**
 * A generic ordered collection of elements that supports adding and removing elements.
 * @param E the type of elements contained in the list. The mutable list is invariant on its element type.
 */
abstract class KMutableList<E> implements KList<E>, KMutableCollection<E> {
  /**
   * Inserts all of the elements in the specified collection [elements] into this list at the specified [index].
   *
   * @return `true` if the list was changed as the result of the operation.
   */
  bool addAllAt(int index, KCollection<E> elements);

// Positional Access Operations
  /**
   * Replaces the element at the specified position in this list with the specified element.
   *
   * @return the element previously at the specified position.
   */
  E set(int index, E element);

  /**
   * Inserts an element into the list at the specified [index].
   */
  void addAt(int index, E element);

  /**
   * Removes an element at the specified [index] from the list.
   *
   * @return the element that has been removed.
   */
  E removeAt(int index);
}

/**
 * A generic unordered collection of elements that does not support duplicate elements.
 * Methods in this interface support only read-only access to the set;
 * read/write access is supported through the [KMutableSet] interface.
 * @param E the type of elements contained in the set. The set is covariant on its element type.
 */
abstract class KSet<E> implements KCollection<E> {}

/**
 * A generic unordered collection of elements that does not support duplicate elements, and supports
 * adding and removing elements.
 * @param E the type of elements contained in the set. The mutable set is invariant on its element type.
 */
abstract class KMutableSet<E> implements KSet<E>, KMutableCollection<E> {}

/**
 * A collection that holds pairs of objects (keys and values) and supports efficiently retrieving
 * the value corresponding to each key. Map keys are unique; the map holds only one value for each key.
 * Methods in this interface support only read-only access to the map; read-write access is supported through
 * the [KMutableMap] interface.
 * @param K the type of map keys. The map is invariant on its key type, as it
 *          can accept key as a parameter (of [containsKey] for example) and return it in [keys] set.
 * @param V the type of map values. The map is covariant on its value type.
 */
abstract class KMap<K, V> {
  // Query Operations
  /**
   * Returns the number of key/value pairs in the map.
   */
  int get size;

  /**
   * Returns `true` if the map is empty (contains no elements), `false` otherwise.
   */
  bool isEmpty();

  /**
   * Returns `true` if the map contains the specified [key].
   */
  bool containsKey(K key);

  /**
   * Returns `true` if the map maps one or more keys to the specified [value].
   */
  bool containsValue(V value);

  /**
   * Returns the value corresponding to the given [key], or `null` if such a key is not present in the map.
   */
  // TODO add nullable annotation
  V get(K key);

  /**
   * Returns the value corresponding to the given [key], or [defaultValue] if such a key is not present in the map.
   *
   * @since JDK 1.8
   */
  V getOrDefault(K key, V defaultValue);

  // Views
  /**
   * Returns a read-only [KSet] of all keys in this map.
   */
  KSet<K> get keys;

  /**
   * Returns a read-only [KCollection] of all values in this map. Note that this collection may contain duplicate values.
   */
  KCollection<V> get values;

  /**
   * Returns a read-only [KSet] of all key/value pairs in this map.
   */
  KSet<KMapEntry<K, V>> get entries;
}

/**
 * Represents a key/value pair held by a [KMap].
 */
abstract class KMapEntry<K, V> {
  /**
   * Returns the key of this key/value pair.
   */
  K get key;

  /**
   * Returns the value of this key/value pair.
   */
  V get value;
}

/**
 * A modifiable collection that holds pairs of objects (keys and values) and supports efficiently retrieving
 * the value corresponding to each key. Map keys are unique; the map holds only one value for each key.
 * @param K the type of map keys. The map is invariant on its key type.
 * @param V the type of map values. The mutable map is invariant on its value type.
 */
abstract class KMutableMap<K, V> implements KMap<K, V> {
  // Modification Operations
  /**
   * Associates the specified [value] with the specified [key] in the map.
   *
   * @return the previous value associated with the key, or `null` if the key was not present in the map.
   */
  // TODO add nullable annotation
  V put(K key, V value);

  /**
   * Removes the specified key and its corresponding value from this map.
   *
   * @return the previous value associated with the key, or `null` if the key was not present in the map.
   */
  // TODO add nullable annotation
  V remove(K key);

  /**
   * Removes the entry for the specified key only if it is mapped to the specified value.
   *
   * @return true if entry was removed
   */
  bool removeMapping(K key, V value);

  // Bulk Modification Operations
  /**
   * Updates this map with key/value pairs from the specified map [from].
   */
  void putAll(KMap<K, V> from);

  /**
   * Removes all elements from this map.
   */
  void clear();
}

/**
 * Represents a key/value pair held by a [KMutableMap].
 */
abstract class KMutableEntry<K, V> extends KMapEntry<K, V> {
  /**
   * Changes the value associated with the key of this entry.
   *
   * @return the previous value corresponding to the key.
   */
  V setValue(V newValue);
}
