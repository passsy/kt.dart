import "package:kt_dart/collection.dart";
import "package:kt_dart/src/collection/impl/map.dart";
import "package:kt_dart/src/collection/impl/map_empty.dart";
import "package:kt_dart/src/util/errors.dart";

/// A collection that holds pairs of objects (keys and values) and supports efficiently retrieving
/// the value corresponding to each key. Map keys are unique; the map holds only one value for each key.
/// Methods in this interface support only read-only access to the map; read-write access is supported through
/// the [KtMutableMap] interface.
/// @param K the type of map keys. The map is invariant on its key type, as it
///          can accept key as a parameter (of [containsKey] for example) and return it in [keys] set.
/// @param V the type of map values. The map is covariant on its value type.
abstract class KtMap<K, V> {
  const factory KtMap.empty() = EmptyMap<K, V>;

  factory KtMap.from([Map<K, V> map = const {}]) {
    if (map.isEmpty) return EmptyMap<K, V>();
    return DartMap(map);
  }

  // Query Operations
  /// Returns the number of key/value pairs in the map.
  int get size;

  /// Access to a `Iterable` to be used in for-loops
  Iterable<KtMapEntry<K, V>> get iter;

  /// Returns a read-only dart:core [Map]
  ///
  /// This method can be used to interop between the dart:collection and the
  /// kt.dart world.
  ///
  /// - Use [iter] to iterate over the elements of this [KtMap] using a for-loop
  // ignore: comment_references
  /// - Use [KtMapExtensions.toMap] to copy the map
  Map<K, V> asMap();

  /// Returns `true` if the map is empty (contains no elements), `false` otherwise.
  bool isEmpty();

  /// Returns `true` if the map contains the specified [key].
  bool containsKey(K key);

  /// Returns `true` if the map maps one or more keys to the specified [value].
  bool containsValue(V value);

  /// Returns the value corresponding to the given [key], or `null` if such a key is not present in the map.
  V? get(K key);

  /// Returns the value corresponding to the given [key], or `null` if such a key is not present in the map.
  V? operator [](K key);

  /// Returns the value corresponding to the given [key], or [defaultValue] if such a key is not present in the map.
  V getOrDefault(K key, V defaultValue);

  // Views
  /// Returns a read-only [KtSet] of all keys in this map.
  KtSet<K> get keys;

  /// Returns a read-only [KtCollection] of all values in this map. Note that this collection may contain duplicate values.
  KtCollection<V> get values;

  /// Returns a read-only [KtSet] of all key/value pairs in this map.
  KtSet<KtMapEntry<K, V>> get entries;
}

/// Represents a key/value pair held by a [KtMap].
abstract class KtMapEntry<K, V> {
  /// Returns the key of this key/value pair.
  K get key;

  /// Returns the value of this key/value pair.
  V get value;

  /// Converts entry to [KtPair] with key being first component and value being second.
  KtPair<K, V> toPair();
}

extension KtMapExtensions<K, V> on KtMap<K, V> {
  /// Returns a read-only dart:core [Map]
  ///
  /// This method can be used to interop between the dart:collection and the
  /// kt.dart world.
  Map<K, V> get dart => asMap();

  /// Returns true if all entries match the given [predicate].
  /// [predicate] must not be null.
  bool all(bool Function(K key, V value) predicate) {
    if (isEmpty()) {
      return true;
    }
    for (final KtMapEntry<K, V> entry in iter) {
      if (!predicate(entry.key, entry.value)) {
        return false;
      }
    }
    return true;
  }

  /// Returns true if there is at least one entry that matches the given [predicate].
  /// [predicate] must not be null.
  bool any(bool Function(K key, V value) predicate) {
    if (isEmpty()) {
      return false;
    }
    for (final KtMapEntry<K, V> entry in iter) {
      if (predicate(entry.key, entry.value)) {
        return true;
      }
    }
    return false;
  }

  /// Returns the number of entries matching the given [predicate] or the number of entries when `predicate = null`.
  int count([bool Function(KtMapEntry<K, V>)? predicate]) {
    if (predicate == null) {
      return size;
    }
    var count = 0;
    final KtIterator<KtMapEntry<K, V>> i = iterator();
    while (i.hasNext()) {
      if (predicate(i.next())) {
        count++;
      }
    }
    return count;
  }

  /// Returns a new map containing all key-value pairs matching the given [predicate].
  ///
  /// The returned map preserves the entry iteration order of the original map.
  KtMap<K, V> filter(bool Function(KtMapEntry<K, V> entry) predicate) {
    final filtered = filterTo(linkedMapFrom<K, V>(), predicate);
    // TODO ping dort-lang/sdk team to check type bug
    return filtered;
  }

  /// Returns a map containing all key-value pairs with keys matching the given [predicate].
  ///
  /// The returned map preserves the entry iteration order of the original map.
  KtMap<K, V> filterKeys(bool Function(K) predicate) {
    final result = linkedMapFrom<K, V>();
    for (final entry in iter) {
      if (predicate(entry.key)) {
        result.put(entry.key, entry.value);
      }
    }
    return result;
  }

  /// Returns a new map containing all key-value pairs not matching the given [predicate].
  ///
  /// The returned map preserves the entry iteration order of the original map.
  KtMap<K, V> filterNot(bool Function(KtMapEntry<K, V> entry) predicate) {
    final filtered = filterNotTo(linkedMapFrom<K, V>(), predicate);
    // TODO ping dort-lang/sdk team to check type bug
    return filtered;
  }

  /// Appends all entries not matching the given [predicate] into the given [destination].
  ///
  /// [destination] is not type checked by the compiler due to https://github.com/dart-lang/sdk/issues/35518,
  /// but will be checked at runtime.
  /// [M] actually is expected to be `M extends KtMutableMap<K, V>`
  ///
  /// @return the destination map.
  // TODO Change to `M extends KtMutableMap<K, V>` once https://github.com/dart-lang/sdk/issues/35518 has been fixed
  M filterNotTo<M extends KtMutableMap<dynamic, dynamic>>(
      M destination, bool Function(KtMapEntry<K, V> entry) predicate) {
    assert(() {
      if (destination is! KtMutableMap<K, V> && mutableMapFrom<K, V>() is! M) {
        throw ArgumentError("filterNotTo destination has wrong type parameters."
            "\nExpected: KtMutableMap<$K, $V>, Actual: ${destination.runtimeType}"
            "\ndestination (${destination.runtimeType}) entries aren't subtype of "
            "map ($runtimeType) entries. Entries can't be copied to destination."
            "\n\n$kBug35518GenericTypeError");
      }
      return true;
    }());
    for (final element in iter) {
      if (!predicate(element)) {
        destination.put(element.key, element.value);
      }
    }
    return destination;
  }

  /// Appends all entries matching the given [predicate] into the mutable map given as [destination] parameter.
  ///
  /// [destination] is not type checked by the compiler due to https://github.com/dart-lang/sdk/issues/35518,
  /// but will be checked at runtime.
  /// [M] actually is expected to be `M extends KtMutableMap<K, V>`
  ///
  /// @return the destination map.
  // TODO Change to `M extends KtMutableMap<K, V>` once https://github.com/dart-lang/sdk/issues/35518 has been fixed
  M filterTo<M extends KtMutableMap<dynamic, dynamic>>(
      M destination, bool Function(KtMapEntry<K, V> entry) predicate) {
    assert(() {
      if (destination is! KtMutableMap<K, V> && mutableMapFrom<K, V>() is! M) {
        throw ArgumentError("filterTo destination has wrong type parameters."
            "\nExpected: KtMutableMap<$K, $V>, Actual: ${destination.runtimeType}"
            "\ndestination (${destination.runtimeType}) entries aren't subtype of "
            "map ($runtimeType) entries. Entries can't be copied to destination."
            "\n\n$kBug35518GenericTypeError");
      }
      return true;
    }());
    for (final element in iter) {
      if (predicate(element)) {
        destination.put(element.key, element.value);
      }
    }
    return destination;
  }

  /// Returns a map containing all key-value pairs with values matching the given [predicate].
  ///
  /// The returned map preserves the entry iteration order of the original map.
  KtMap<K, V> filterValues(bool Function(V) predicate) {
    final result = linkedMapFrom<K, V>();
    for (final entry in iter) {
      if (predicate(entry.value)) {
        result.put(entry.key, entry.value);
      }
    }
    return result;
  }

  /// Performs given [action] on each key/value pair from this map.
  ///
  /// [action] must not be null.
  void forEach(void Function(K key, V value) action) {
    entries.forEach((entry) => action(entry.key, entry.value));
  }

  /// Returns the value for the given key, or the result of the [defaultValue] function if there was no entry for the given key.
  V getOrElse(K key, V Function() defaultValue) {
    return get(key) ?? defaultValue();
  }

  /// Returns the value for the given [key] or throws an exception if there is no such key in the map.
  ///
  /// @throws NoSuchElementException when the map doesn't contain a value for the specified key
  V getValue(K key) {
    final value = get(key);
    if (value == null) {
      throw NoSuchElementException("Key $key is missing in the map.");
    }
    return value;
  }

  /// Returns this map if it's not empty
  /// or the result of calling [defaultValue] function if the map is empty.
  R ifEmpty<R extends KtMap<K, V>>(R Function() defaultValue) {
    if (isEmpty()) return defaultValue();
    return this as R;
  }

  /// Returns `true` if this map is not empty.
  bool isNotEmpty() => !isEmpty();

  /// Returns an [Iterator] over the entries in the [Map].
  KtIterator<KtMapEntry<K, V>> iterator() => entries.iterator();

  /// Returns a list containing the results of applying the given [transform] function
  /// to each entry in the original map.
  KtList<R> map<R>(R Function(KtMapEntry<K, V> entry) transform) {
    final mapped = mapTo(mutableListOf<R>(), transform);
    return mapped;
  }

  /// Returns a new Map with entries having the keys obtained by applying the [transform] function to each entry in this
  /// [Map] and the values of this map.
  ///
  /// In case if any two entries are mapped to the equal keys, the value of the latter one will overwrite
  /// the value associated with the former one.
  ///
  /// The returned map preserves the entry iteration order of the original map.
  KtMap<R, V> mapKeys<R>(R Function(KtMapEntry<K, V>) transform) {
    final mapped = mapKeysTo(linkedMapFrom<R, V>(), transform);
    return mapped;
  }

  /// Populates the given [destination] map with entries having the keys obtained
  /// by applying the [transform] function to each entry in this [Map] and the values of this map.
  ///
  /// In case if any two entries are mapped to the equal keys, the value of the latter one will overwrite
  /// the value associated with the former one.
  ///
  /// [destination] is not type checked by the compiler due to https://github.com/dart-lang/sdk/issues/35518,
  /// but will be checked at runtime.
  /// [M] actually is expected to be `M extends KtMutableMap<R, V>`
  // TODO Change to `M extends KtMutableMap<R, V>` once https://github.com/dart-lang/sdk/issues/35518 has been fixed
  M mapKeysTo<R, M extends KtMutableMap<dynamic, dynamic>>(
      M destination, R Function(KtMapEntry<K, V> entry) transform) {
    assert(() {
      if (destination is! KtMutableMap<R, V> && mutableMapFrom<R, V>() is! M) {
        throw ArgumentError("mapKeysTo destination has wrong type parameters."
            "\nExpected: KtMutableMap<$R, $V>, Actual: ${destination.runtimeType}"
            "\nEntries after key transformation with $transform have type KtMapEntry<$R, $V> "
            "and can't be copied into destination of type ${destination.runtimeType}."
            "\n\n$kBug35518GenericTypeError");
      }
      return true;
    }());
    for (final element in iter) {
      destination.put(transform(element), element.value);
    }
    return destination;
  }

  /// Applies the given [transform] function to each entry of the original map
  /// and appends the results to the given [destination].
  // TODO Change to `M extends KtMutableCollection<R>` once https://github.com/dart-lang/sdk/issues/35518 has been fixed
  M mapTo<R, M extends KtMutableCollection<dynamic>>(
      M destination, R Function(KtMapEntry<K, V> entry) transform) {
    assert(() {
      if (destination is! KtMutableCollection<R> &&
          mutableListFrom<R>() is! M) {
        throw ArgumentError("mapTo destination has wrong type parameters."
            "\nExpected: KtMutableCollection<$R>, Actual: ${destination.runtimeType}"
            "\nEntries after key transformation with $transform have type $R "
            "and can't be copied into destination of type ${destination.runtimeType}."
            "\n\n$kBug35518GenericTypeError");
      }
      return true;
    }());
    for (final item in iter) {
      destination.add(transform(item));
    }
    return destination;
  }

  /// Returns a new map with entries having the keys of this map and the values obtained by applying the [transform]
  /// function to each entry in this [Map].
  ///
  /// The returned map preserves the entry iteration order of the original map.
  KtMap<K, R> mapValues<R>(R Function(KtMapEntry<K, V>) transform) {
    final mapped = mapValuesTo(linkedMapFrom<K, R>(), transform);
    return mapped;
  }

  /// Populates the given [destination] map with entries having the keys of this map and the values obtained
  /// by applying the [transform] function to each entry in this [Map].
  ///
  /// [destination] is not type checked by the compiler due to https://github.com/dart-lang/sdk/issues/35518,
  /// but will be checked at runtime.
  /// [M] actually is expected to be `M extends KtMutableMap<K, R>`
  // TODO Change to `M extends KtMutableMap<K, R>` once https://github.com/dart-lang/sdk/issues/35518 has been fixed
  M mapValuesTo<R, M extends KtMutableMap<dynamic, dynamic>>(
      M destination, R Function(KtMapEntry<K, V> entry) transform) {
    assert(() {
      if (destination is! KtMutableMap<K, R> && mutableMapFrom<K, R>() is! M) {
        throw ArgumentError("mapValuesTo destination has wrong type parameters."
            "\nExpected: KtMutableMap<$K, $R>, Actual: ${destination.runtimeType}"
            "\nEntries after key transformation with $transform have type KtMapEntry<$K, $R> "
            "and can't be copied into destination of type ${destination.runtimeType}."
            "\n\n$kBug35518GenericTypeError");
      }
      return true;
    }());
    for (final element in iter) {
      destination.put(element.key, transform(element));
    }
    return destination;
  }

  /// Returns the first entry yielding the largest value of the given function or `null` if there are no entries.
  KtMapEntry<K, V>? maxBy<R extends Comparable>(
      R Function(KtMapEntry<K, V>) selector) {
    final i = iterator();
    if (!iterator().hasNext()) return null;
    KtMapEntry<K, V> maxElement = i.next();
    R maxValue = selector(maxElement);
    while (i.hasNext()) {
      final e = i.next();
      final v = selector(e);
      if (maxValue.compareTo(v) < 0) {
        maxElement = e;
        maxValue = v;
      }
    }
    return maxElement;
  }

  /// Returns the first entry having the largest value according to the provided [comparator] or `null` if there are no entries.
  KtMapEntry<K, V>? maxWith(Comparator<KtMapEntry<K, V>> comparator) {
    final i = iterator();
    if (!i.hasNext()) return null;
    var max = i.next();
    while (i.hasNext()) {
      final e = i.next();
      if (comparator(max, e) < 0) {
        max = e;
      }
    }
    return max;
  }

  /// Returns a map containing all entries of the original map except the entry with the given [key].
  ///
  /// The returned map preserves the entry iteration order of the original map.
  KtMap<K, V> minus(K key) => toMutableMap()..remove(key);

  /// Returns a map containing all entries of the original map except the entry with the given [key].
  ///
  /// The returned map preserves the entry iteration order of the original map.
  KtMap<K, V> operator -(K key) => minus(key);

  /// Returns the first entry yielding the smallest value of the given function or `null` if there are no entries.
  KtMapEntry<K, V>? minBy<R extends Comparable>(
      R Function(KtMapEntry<K, V>) selector) {
    final i = iterator();
    if (!iterator().hasNext()) return null;
    KtMapEntry<K, V> minElement = i.next();
    R minValue = selector(minElement);
    while (i.hasNext()) {
      final e = i.next();
      final v = selector(e);
      if (minValue.compareTo(v) > 0) {
        minElement = e;
        minValue = v;
      }
    }
    return minElement;
  }

  /// Returns the first entry having the smallest value according to the provided [comparator] or `null` if there are no entries.
  KtMapEntry<K, V>? minWith(Comparator<KtMapEntry<K, V>> comparator) {
    final i = iterator();
    if (!i.hasNext()) return null;
    var min = i.next();
    while (i.hasNext()) {
      final e = i.next();
      if (comparator(min, e) > 0) {
        min = e;
      }
    }
    return min;
  }

  /// Returns `true` if there is no entries in the map that match the given [predicate].
  /// [predicate] must not be null.
  bool none(bool Function(K key, V value) predicate) {
    if (isEmpty()) {
      return true;
    }
    for (final KtMapEntry<K, V> entry in iter) {
      if (predicate(entry.key, entry.value)) {
        return false;
      }
    }
    return true;
  }

  /// Creates a new read-only map by replacing or adding entries to this map from another [map].
  ///
  /// The returned map preserves the entry iteration order of the original map.
  /// Those entries of another [map] that are missing in this map are iterated in the end in the order of that [map].
  KtMap<K, V> plus(KtMap<K, V> map) {
    return toMutableMap()..putAll(map);
  }

  /// Creates a new read-only map by replacing or adding entries to this map from another [map].
  ///
  /// The returned map preserves the entry iteration order of the original map.
  /// Those entries of another [map] that are missing in this map are iterated in the end in the order of that [map].
  KtMap<K, V> operator +(KtMap<K, V> map) => plus(map);

  /// Returns a [KtList] containing all key-value pairs.
  KtList<KtPair<K, V>> toList() => listFrom(iter.map((it) => it.toPair()));

  /// Returns a new read-only map containing all key-value pairs from the original map.
  ///
  /// The returned map preserves the entry iteration order of the original map.
  KtMap<K, V> toMap() {
    if (size == 0) return emptyMap();
    return toMutableMap();
  }

  /// Returns a new mutable map containing all key-value pairs from the original map.
  ///
  /// The returned map preserves the entry iteration order of the original map.
  KtMutableMap<K, V> toMutableMap() => mutableMapFrom(asMap());
}

extension NullableKtMapExtensions<K, V> on KtMap<K, V>? {
  /// Returns the [KtMap] if its not `null`, or the empty [KtMap] otherwise.
  KtMap<K, V> orEmpty() => this ?? KtMap<K, V>.empty();
}
