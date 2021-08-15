import "dart:math" as math;

import "package:kt_dart/collection.dart";
import "package:kt_dart/src/util/errors.dart";

/// Classes that inherit from this interface can be represented as a sequence of elements that can
/// be iterated over.
/// @param T the type of element being iterated over. The iterator is covariant on its element type.
abstract class KtIterable<T> {
  /// Access to a [Iterable] to be used in for-loops
  Iterable<T> get iter;

  /// Returns an iterator over the elements of this object.
  KtIterator<T> iterator();
}

extension KtComparableIterableExtension<T extends Comparable<T>>
    on KtIterable<T> {
  /// Returns the largest element or `null` if there are no elements.
  T? max() {
    final i = iterator();
    if (!iterator().hasNext()) return null;
    T max = i.next();
    while (i.hasNext()) {
      final T e = i.next();
      if (Comparable.compare(max, e) < 0) {
        max = e;
      }
    }
    return max;
  }

  /// Returns the smallest element or `null` if there are no elements.
  T? min() {
    final i = iterator();
    if (!iterator().hasNext()) return null;
    T min = i.next();
    while (i.hasNext()) {
      final T e = i.next();
      if (Comparable.compare(min, e) > 0) {
        min = e;
      }
    }
    return min;
  }
}

extension KtNumIterableExtension<T extends num> on KtIterable<T> {
  /// Returns the largest element or `null` if there are no elements.
  T? max() {
    final i = iterator();
    if (!iterator().hasNext()) return null;
    T max = i.next();
    if (max.isNaN) return max;
    while (i.hasNext()) {
      final T e = i.next();
      if (e.isNaN) return e;
      if (max < e) {
        max = e;
      }
    }
    return max;
  }

  /// Returns the smallest element or `null` if there are no elements.
  T? min() {
    final i = iterator();
    if (!iterator().hasNext()) return null;
    T min = i.next();
    if (min.isNaN) return min;
    while (i.hasNext()) {
      final T e = i.next();
      if (e.isNaN) return e;
      if (min > e) {
        min = e;
      }
    }
    return min;
  }

  /// Returns the average or `null` if there are no elements.
  double average() {
    var count = 0;
    num sum = 0;
    final i = iterator();
    if (!iterator().hasNext()) return double.nan;
    while (i.hasNext()) {
      final next = i.next();
      // nan values are ignored
      if (!next.isNaN) {
        sum += next;
        count++;
      }
    }
    return sum / count;
  }
}

extension KtIntIterableExtension on KtIterable<int> {
  /// Returns the sum of all elements in the collection.
  int sum() {
    int sum = 0;
    for (final element in iter) {
      sum += element;
    }
    return sum;
  }
}

extension KtDoubleIterableExtension on KtIterable<double> {
  /// Returns the sum of all elements in the collection.
  double sum() {
    double sum = 0.0;
    for (final element in iter) {
      sum += element;
    }
    return sum;
  }
}

extension KtIterableExtensions<T> on KtIterable<T> {
  /// Returns a dart:core [Iterable]
  ///
  /// This method can be used to interop between the dart:collection and the
  /// kt.dart world.
  Iterable<T> get dart => iter;

  /// Returns `true` if all elements match the given [predicate].
  bool all(bool Function(T element) predicate) {
    if (this is KtCollection && (this as KtCollection).isEmpty()) return true;
    for (final element in iter) {
      if (!predicate(element)) {
        return false;
      }
    }
    return true;
  }

  /// Returns `true` if at least one element matches the given [predicate].
  ///
  /// Returns `true` if collection has at least one element when no [predicate] is provided
  bool any([bool Function(T element)? predicate]) {
    if (predicate == null) {
      if (this is KtCollection) return !(this as KtCollection).isEmpty();
      return iterator().hasNext();
    }
    if (this is KtCollection && (this as KtCollection).isEmpty()) return false;
    for (final element in iter) {
      if (predicate(element)) return true;
    }
    return false;
  }

  /// Returns this collection as an [Iterable].
  KtIterable<T> asIterable() => this;

  /// Returns a [Map] containing key-value pairs provided by [transform] function
  /// applied to elements of the given collection.
  ///
  /// If any of two pairs would have the same key the last one gets added to the map.
  ///
  /// The returned map preserves the entry iteration order of the original collection.
  KtMap<K, V> associate<K, V>(KtPair<K, V> Function(T) transform) {
    final map = associateTo(linkedMapFrom<K, V>(), transform);
    // TODO ping dort-lang/sdk team to check type bug
    // When in single line: type 'DartLinkedHashMap<String, String>' is not a subtype of type 'Null'
    return map;
  }

  /// Returns a [Map] containing the elements from the given collection indexed by the key
  /// returned from [keySelector] function applied to each element.
  ///
  /// If any two elements would have the same key returned by [keySelector] the last one gets added to the map.
  ///
  /// The returned map preserves the entry iteration order of the original collection.
  KtMap<K, T> associateBy<K>(K Function(T) keySelector) {
    return associateByTo<K, T, KtMutableMap<K, T>>(
        linkedMapFrom<K, T>(), keySelector, null);
  }

  /// Returns a [Map] containing the elements from the given collection indexed by the key
  /// returned from [keySelector] function applied to each element. The element can be transformed with [valueTransform].
  ///
  /// If any two elements would have the same key returned by [keySelector] the last one gets added to the map.
  ///
  /// The returned map preserves the entry iteration order of the original collection.
  KtMap<K, V> associateByTransform<K, V>(
      K Function(T) keySelector, V Function(T) valueTransform) {
    final map =
        associateByTo(linkedMapFrom<K, V>(), keySelector, valueTransform);
    // TODO ping dort-lang/sdk team to check type bug
    // When in single line: type 'DartLinkedHashMap<int, String>' is not a subtype of type 'Null'
    return map;
  }

  /// Populates and returns the [destination] mutable map with key-value pairs,
  /// where key is provided by the [keySelector] function and
  /// and value is provided by the [valueTransform] function applied to elements of the given collection.
  ///
  /// If any two elements would have the same key returned by [keySelector] the last one gets added to the map.
  M associateByTo<K, V, M extends KtMutableMap<K, V>>(
      M destination, K Function(T) keySelector,
      [V Function(T)? valueTransform]) {
    for (final element in iter) {
      final key = keySelector(element);
      final V value =
          valueTransform == null ? element as V : valueTransform(element);
      destination.put(key, value);
    }
    return destination;
  }

  /// Populates and returns the [destination] mutable map with key-value pairs
  /// provided by [transform] function applied to each element of the given collection.
  ///
  /// If any of two pairs would have the same key the last one gets added to the map.
  M associateTo<K, V, M extends KtMutableMap<K, V>>(
      M destination, KtPair<K, V> Function(T) transform) {
    for (final element in iter) {
      final pair = transform(element);
      destination.put(pair.first, pair.second);
    }
    return destination;
  }

  /// Returns a [Map] where keys are elements from the given collection and values are
  /// produced by the [valueSelector] function applied to each element.
  ///
  /// If any two elements are equal, the last one gets added to the map.
  ///
  /// The returned map preserves the entry iteration order of the original collection.

  KtMap<T, V> associateWith<V>(V Function(T) valueSelector) {
    final associated = associateWithTo(linkedMapFrom<T, V>(), valueSelector);
    // TODO ping dort-lang/sdk team to check type bug
    // When in single line: type "DartMutableList<String>' is not a subtype of type 'Null"
    return associated;
  }

  /// Populates and returns the [destination] mutable map with key-value pairs for each element of the given collection,
  /// where key is the element itself and value is provided by the [valueSelector] function applied to that key.
  ///
  /// If any two elements are equal, the last one overwrites the former value in the map.
  ///
  /// [destination] is not type checked by the compiler due to https://github.com/dart-lang/sdk/issues/35518,
  /// but will be checked at runtime.
  /// [M] actually is expected to be `M extends KtMutableMap<T, V>`
  // TODO Change to `M extends KtMutableMap<T, V>` once https://github.com/dart-lang/sdk/issues/35518 has been fixed
  M associateWithTo<V, M extends KtMutableMap<dynamic, dynamic>>(
      M destination, V Function(T) valueSelector) {
    assert(() {
      if (destination is! KtMutableMap<T, V> && mutableMapFrom<T, V>() is! M) {
        throw ArgumentError(
            "associateWithTo destination has wrong type parameters."
            "\nExpected: KtMutableMap<$T, $V>, Actual: ${destination.runtimeType}"
            "\ndestination (${destination.runtimeType}) items aren't subtype of "
            "$runtimeType items. Items can't be copied to destination."
            "\n\n$kBug35518GenericTypeError");
      }
      return true;
    }());
    for (final element in iter) {
      destination.put(element, valueSelector(element));
    }
    return destination;
  }

  /// Returns an average value produced by [selector] function applied to each element in the collection.
  double averageBy(num Function(T) selector) {
    num sum = 0.0;
    var count = 0;
    for (final element in iter) {
      final value = selector(element);
      // nan values are ignored
      if (!value.isNaN) {
        sum += value;
        count++;
      }
    }
    if (count == 0) {
      return double.nan;
    }
    return sum / count;
  }

  /// Provides a view of this [KtIterable] as an iterable of [R] instances.
  ///
  /// If this [KtIterable] only contains instances of [R], all operations will work correctly.
  /// If any operation tries to access an element that is not an instance of [R], the access will throw a [TypeError] instead.
  ///
  /// When the returned [KtIterable] creates a new object that depends on the type [R], e.g., from [toList], it will have exactly the type [R].
  KtIterable<R> cast<R>() => _CastKtIterable<T, R>(this);

  /// Splits this collection into a list of lists each not exceeding the given [size].
  ///
  /// The last list in the resulting list may have less elements than the given [size].
  ///
  /// @param [size] the number of elements to take in each list, must be positive and can be greater than the number of elements in this collection.
  KtList<KtList<T>> chunked(int size) {
    return windowed(size, step: size, partialWindows: true);
  }

  /// Splits this collection into several lists each not exceeding the given [size]
  /// and applies the given [transform] function to an each.
  ///
  /// @return list of results of the [transform] applied to an each list.
  ///
  /// Note that the list passed to the [transform] function is ephemeral and is valid only inside that function.
  /// You should not store it or allow it to escape in some way, unless you made a snapshot of it.
  /// The last list may have less elements than the given [size].
  ///
  /// @param [size] the number of elements to take in each list, must be positive and can be greater than the number of elements in this collection.
  ///
  KtList<R> chunkedTransform<R>(int size, R Function(KtList<T>) transform) {
    return windowedTransform(size, transform, step: size, partialWindows: true);
  }

  /// Returns `true` if [element] is found in the collection.
  bool contains(T element) {
    if (this is KtCollection) return (this as KtCollection).contains(element);
    return indexOf(element) >= 0;
  }

  /// Returns the number of elements matching the given [predicate] or the number of elements when `predicate = null`.
  int count([bool Function(T)? predicate]) {
    if (predicate == null && this is KtCollection) {
      return (this as KtCollection).size;
    }
    var count = 0;
    final Iterator<T> i = iter.iterator;
    while (i.moveNext()) {
      if (predicate == null) {
        count++;
      } else {
        if (predicate(i.current)) {
          count++;
        }
      }
    }
    return count;
  }

  /// Returns a list containing only distinct elements from the given collection.
  ///
  /// The elements in the resulting list are in the same order as they were in the source collection.
  KtList<T> distinct() => KtIterableExtensions<T>(toMutableSet()).toList();

  /// Returns a list containing only elements from the given collection
  /// having distinct keys returned by the given [selector] function.
  ///
  /// The elements in the resulting list are in the same order as they were in the source collection.
  KtList<T> distinctBy<K>(K Function(T) selector) {
    final set = hashSetOf<K>();
    final list = mutableListOf<T>();
    for (final element in iter) {
      final key = selector(element);
      if (set.add(key)) {
        list.add(element);
      }
    }
    return list;
  }

  /// Returns a list containing all elements except first [n] elements.
  KtList<T> drop(int n) {
    // TODO add exception if n is negative
    final list = mutableListOf<T>();
    var count = 0;
    for (final item in iter) {
      if (count++ >= n) {
        list.add(item);
      }
    }
    return list;
  }

  /// Returns a list containing all elements except first elements that satisfy the given [predicate].
  KtList<T> dropWhile(bool Function(T) predicate) {
    var yielding = false;
    final list = mutableListOf<T>();
    for (final item in iter) {
      if (yielding) {
        list.add(item);
      } else {
        if (!predicate(item)) {
          list.add(item);
          yielding = true;
        }
      }
    }
    return list;
  }

  /// Returns an element at the given [index] or throws an [IndexOutOfBoundsException] if the [index] is out of bounds of this collection.
  T elementAt(int index) {
    return elementAtOrElse(index, (int index) {
      throw IndexOutOfBoundsException(
          "Collection doesn't contain element at index: $index.");
    });
  }

  /// Returns an element at the given [index] or the result of calling the [defaultValue] function if the [index] is out of bounds of this collection.
  T elementAtOrElse(int index, T Function(int) defaultValue) {
    if (index < 0) {
      return defaultValue(index);
    }
    final i = iterator();
    int count = 0;
    while (i.hasNext()) {
      final element = i.next();
      if (index == count++) {
        return element;
      }
    }
    return defaultValue(index);
  }

  /// Returns an element at the given [index] or `null` if the [index] is out of bounds of this collection.
  T? elementAtOrNull(int index) {
    if (index < 0) {
      return null;
    }
    final i = iterator();
    int count = 0;
    while (i.hasNext()) {
      final element = i.next();
      if (index == count++) {
        return element;
      }
    }
    return null;
  }

  /// Returns a list containing only elements matching the given [predicate].
  KtList<T> filter(bool Function(T) predicate) {
    final filtered = filterTo(mutableListOf<T>(), predicate);
    // TODO ping dort-lang/sdk team to check type bug
    // When in single line: type "DartMutableList<String>' is not a subtype of type 'Null"
    return filtered;
  }

  /// Returns a list containing only elements matching the given [predicate].
  /// @param [predicate] function that takes the index of an element and the element itself
  /// and returns the result of predicate evaluation on the element.
  KtList<T> filterIndexed(bool Function(int index, T) predicate) {
    final filtered = filterIndexedTo(mutableListOf<T>(), predicate);
    // TODO ping dort-lang/sdk team to check type bug
    // When in single line: type "DartMutableList<String>' is not a subtype of type 'Null"
    return filtered;
  }

  /// Appends all elements matching the given [predicate] to the given [destination].
  /// @param [predicate] function that takes the index of an element and the element itself
  /// and returns the result of predicate evaluation on the element.
  ///
  /// [destination] is not type checked by the compiler due to https://github.com/dart-lang/sdk/issues/35518,
  /// but will be checked at runtime.
  /// [C] actually is expected to be `C extends KtMutableCollection<T>`
  // TODO Change to `C extends KtMutableCollection<T>` once https://github.com/dart-lang/sdk/issues/35518 has been fixed
  C filterIndexedTo<C extends KtMutableCollection<dynamic>>(
      C destination, bool Function(int index, T) predicate) {
    assert(() {
      if (destination is! KtMutableCollection<T> && mutableListOf<T>() is! C) {
        throw ArgumentError(
            "filterIndexedTo destination has wrong type parameters."
            "\nExpected: KtMutableCollection<$T>, Actual: ${destination.runtimeType}"
            "\ndestination (${destination.runtimeType}) entries aren't subtype of "
            "map ($runtimeType) entries. Entries can't be copied to destination."
            "\n\n$kBug35518GenericTypeError");
      }
      return true;
    }());
    var i = 0;
    for (final element in iter) {
      if (predicate(i++, element)) {
        destination.add(element);
      }
    }
    return destination;
  }

  /// Returns a list containing all elements that are instances of specified type parameter R.
  KtList<R> filterIsInstance<R>() {
    final destination = mutableListOf<R>();
    for (final element in iter) {
      if (element is R) {
        destination.add(element);
      }
    }
    return destination;
  }

  /// Returns a list containing all elements not matching the given [predicate].
  KtList<T> filterNot(bool Function(T) predicate) {
    final list = filterNotTo(mutableListOf<T>(), predicate);
    // TODO ping dort-lang/sdk team to check type bug
    // When in single line: type "DartMutableList<String>' is not a subtype of type 'Null"
    return list;
  }

  /// Appends all elements not matching the given [predicate] to the given [destination].
  ///
  /// [destination] is not type checked by the compiler due to https://github.com/dart-lang/sdk/issues/35518,
  /// but will be checked at runtime.
  /// [C] actually is expected to be `C extends KtMutableCollection<T>`
  // TODO Change to `C extends KtMutableCollection<T>` once https://github.com/dart-lang/sdk/issues/35518 has been fixed
  C filterNotTo<C extends KtMutableCollection<dynamic>>(
      C destination, bool Function(T) predicate) {
    assert(() {
      if (destination is! KtMutableCollection<T> && mutableListOf<T>() is! C) {
        throw ArgumentError("filterNotTo destination has wrong type parameters."
            "\nExpected: KtMutableCollection<$T>, Actual: ${destination.runtimeType}"
            "\ndestination (${destination.runtimeType}) entries aren't subtype of "
            "map ($runtimeType) entries. Entries can't be copied to destination."
            "\n\n$kBug35518GenericTypeError");
      }
      return true;
    }());
    for (final element in iter) {
      if (!predicate(element)) {
        destination.add(element);
      }
    }
    return destination;
  }

  /// Appends all elements matching the given [predicate] to the given [destination].
  ///
  /// [destination] is not type checked by the compiler due to https://github.com/dart-lang/sdk/issues/35518,
  /// but will be checked at runtime.
  /// [C] actually is expected to be `C extends KtMutableCollection<T>`
  // TODO Change to `C extends KtMutableCollection<T>` once https://github.com/dart-lang/sdk/issues/35518 has been fixed
  C filterTo<C extends KtMutableCollection<dynamic>>(
      C destination, bool Function(T) predicate) {
    assert(() {
      if (destination is! KtMutableCollection<T> && mutableListOf<T>() is! C) {
        throw ArgumentError("filterTo destination has wrong type parameters."
            "\nExpected: KtMutableCollection<$T>, Actual: ${destination.runtimeType}"
            "\ndestination (${destination.runtimeType}) entries aren't subtype of "
            "map ($runtimeType) entries. Entries can't be copied to destination."
            "\n\n$kBug35518GenericTypeError");
      }
      return true;
    }());
    for (final element in iter) {
      if (predicate(element)) {
        destination.add(element);
      }
    }
    return destination;
  }

  /// Returns the first element matching the given [predicate], or `null` if no such element was found.
  T? find(bool Function(T) predicate) {
    return firstOrNull(predicate);
  }

  /// Returns the last element matching the given [predicate], or `null` if no such element was found.
  T? findLast(bool Function(T) predicate) {
    return lastOrNull(predicate);
  }

  /// Returns first element.
  ///
  /// Use [predicate] to return the first element matching the given [predicate]
  ///
  /// @throws [NoSuchElementException] if the collection is empty.
  T first([bool Function(T)? predicate]) {
    if (predicate == null) {
      final i = iterator();
      if (!i.hasNext()) {
        throw const NoSuchElementException("Collection is empty");
      }
      return i.next();
    } else {
      for (final element in iter) {
        if (predicate(element)) return element;
      }
      throw const NoSuchElementException(
          "Collection contains no element matching the predicate.");
    }
  }

  /// Returns the first element (matching [predicate] when provided), or `null` if the collection is empty.
  T? firstOrNull([bool Function(T)? predicate]) {
    if (predicate == null) {
      if (this is KtList) {
        final list = this as KtList<T>;
        if (list.isEmpty()) {
          return null;
        } else {
          return list[0];
        }
      }
      final i = iterator();
      if (!i.hasNext()) {
        return null;
      }
      return i.next();
    } else {
      for (final element in iter) {
        if (predicate(element)) return element;
      }
      return null;
    }
  }

  /// Returns a single list of all elements yielded from results of [transform] function being invoked on each element of original collection.
  KtList<R> flatMap<R>(KtIterable<R> Function(T) transform) {
    final list = flatMapTo(mutableListOf<R>(), transform);
    // making a temp variable here, it helps dart to get types right ¯\_(ツ)_/¯
    // TODO ping dort-lang/sdk team to check that bug
    return list;
  }

  /// Appends all elements yielded from results of [transform] function being invoked on each element of original collection, to the given [destination].
  C flatMapTo<R, C extends KtMutableCollection<R>>(
      C destination, KtIterable<R> Function(T) transform) {
    for (final element in iter) {
      final list = transform(element);
      destination.addAll(list);
    }
    return destination;
  }

  /// Accumulates value starting with [initial] value and applying [operation] from left to right to current accumulator value and each element.
  R fold<R>(R initial, R Function(R acc, T) operation) {
    var accumulator = initial;
    for (final element in iter) {
      accumulator = operation(accumulator, element);
    }
    return accumulator;
  }

  /// Accumulates value starting with [initial] value and applying [operation] from left to right
  /// to current accumulator value and each element with its index in the original collection.
  /// @param [operation] function that takes the index of an element, current accumulator value
  /// and the element itself, and calculates the next accumulator value.
  R foldIndexed<R>(R initial, R Function(int index, R acc, T) operation) {
    var index = 0;
    var accumulator = initial;
    for (final element in iter) {
      accumulator = operation(index++, accumulator, element);
    }
    return accumulator;
  }

  /// Performs the given [action] on each element.
  void forEach(void Function(T element) action) {
    final i = iterator();
    while (i.hasNext()) {
      final element = i.next();
      action(element);
    }
  }

  /// Performs the given [action] on each element, providing sequential index with the element.
  /// @param [action] function that takes the index of an element and the element itself
  /// and performs the desired action on the element.
  void forEachIndexed(void Function(int index, T element) action) {
    var index = 0;
    for (final item in iter) {
      action(index++, item);
    }
  }

  /// Groups elements of the original collection by the key returned by the given [keySelector] function
  /// applied to each element and returns a map where each group key is associated with a list of corresponding elements.
  ///
  /// The returned map preserves the entry iteration order of the keys produced from the original collection.
  KtMap<K, KtList<T>> groupBy<K>(K Function(T) keySelector) {
    final groups = linkedMapFrom<K, KtList<T>>();
    for (final element in iter) {
      final key = keySelector(element);
      final list = KtMutableMapExtensions(groups)
          .getOrPut(key, () => mutableListOf<T>()) as KtMutableList<T>;
      list.add(element);
    }
    return groups;
  }

  /// Groups values returned by the [valueTransform] function applied to each element of the original collection
  /// by the key returned by the given [keySelector] function applied to the element
  /// and returns a map where each group key is associated with a list of corresponding values.
  ///
  /// The returned map preserves the entry iteration order of the keys produced from the original collection.
  KtMap<K, KtList<V>> groupByTransform<K, V>(
      K Function(T) keySelector, V Function(T) valueTransform) {
    final groups = linkedMapFrom<K, KtList<V>>();
    for (final element in iter) {
      final key = keySelector(element);
      final list = KtMutableMapExtensions(groups)
          .getOrPut(key, () => mutableListOf<V>()) as KtMutableList<V>;
      list.add(valueTransform(element));
    }
    return groups;
  }

  /// Groups elements of the original collection by the key returned by the given [keySelector] function
  /// applied to each element and puts to the [destination] map each group key associated with a list of corresponding elements.
  ///
  /// [destination] is not type checked by the compiler due to https://github.com/dart-lang/sdk/issues/35518,
  /// but will be checked at runtime.
  /// `C` actually is expected to be `C extends KtMutableCollection<T>`
  // TODO Change to `M extends KtMutableMap<K, KtMutableList<T>` once https://github.com/dart-lang/sdk/issues/35518 has been fixed
  M groupByTo<K, M extends KtMutableMap<K, KtMutableList<dynamic>>>(
      M destination, K Function(T) keySelector) {
    assert(() {
      if (destination is! KtMutableMap<K, KtMutableList<T>> &&
          mutableMapFrom<K, KtMutableList<T>>() is! M) {
        throw ArgumentError("groupByTo destination has wrong type parameters."
            "\nExpected: KtMutableMap<K, KtMutableList<$T>, Actual: ${destination.runtimeType}"
            "\ndestination (${destination.runtimeType}) entries aren't subtype of "
            "map ($runtimeType) entries. Entries can't be copied to destination."
            "\n\n$kBug35518GenericTypeError");
      }
      return true;
    }());
    for (final element in iter) {
      final key = keySelector(element);
      final list = KtMutableMapExtensions(destination)
          .getOrPut(key, () => mutableListOf<T>());
      list.add(element);
    }
    return destination;
  }

  /// Groups values returned by the [valueTransform] function applied to each element of the original collection
  /// by the key returned by the given [keySelector] function applied to the element
  /// and puts to the [destination] map each group key associated with a list of corresponding values.
  ///
  /// @return The [destination] map.
  M groupByToTransform<K, V, M extends KtMutableMap<K, KtMutableList<V>>>(
      M destination, K Function(T) keySelector, V Function(T) valueTransform) {
    for (final element in iter) {
      final key = keySelector(element);
      final list = destination.getOrPut(key, () => mutableListOf<V>());
      list.add(valueTransform(element));
    }
    return destination;
  }

  /// Returns first index of [element], or -1 if the collection does not contain element.
  int indexOf(T element) {
    if (this is KtList) return (this as KtList).indexOf(element);
    var index = 0;
    for (final item in iter) {
      if (element == item) return index;
      index++;
    }
    return -1;
  }

  /// Returns index of the first element matching the given [predicate], or -1 if the collection does not contain such element.
  int indexOfFirst(bool Function(T) predicate) {
    var index = 0;
    for (final item in iter) {
      if (predicate(item)) {
        return index;
      }
      index++;
    }
    return -1;
  }

  /// Returns index of the last element matching the given [predicate], or -1 if the collection does not contain such element.
  int indexOfLast(bool Function(T) predicate) {
    var lastIndex = -1;
    var index = 0;
    for (final item in iter) {
      if (predicate(item)) {
        lastIndex = index;
      }
      index++;
    }
    return lastIndex;
  }

  /// Returns a set containing all elements that are contained by both this set and the specified collection.
  ///
  /// The returned set preserves the element iteration order of the original collection.
  KtSet<T> intersect(KtIterable<T> other) {
    final set = toMutableSet();
    set.retainAll(other);
    return set;
  }

  /// Creates a string from all the elements separated using [separator] and using the given [prefix] and [postfix] if supplied.
  ///
  /// If the collection could be huge, you can specify a non-negative value of [limit], in which case only the first [limit]
  /// elements will be appended, followed by the [truncated] string (which defaults to "...").
  String joinToString(
      {String separator = ", ",
      String prefix = "",
      String postfix = "",
      int limit = -1,
      String truncated = "...",
      String Function(T)? transform}) {
    final buffer = StringBuffer();
    buffer.write(prefix);
    var count = 0;
    for (final element in iter) {
      if (++count > 1) buffer.write(separator);
      if (limit >= 0 && count > limit) {
        break;
      } else {
        if (transform == null) {
          buffer.write(element);
        } else {
          buffer.write(transform(element));
        }
      }
    }
    if (limit >= 0 && count > limit) {
      buffer.write(truncated);
    }
    buffer.write(postfix);
    return buffer.toString();
  }

  /// Returns the last element matching the given [predicate].
  /// @throws [NoSuchElementException] if no such element is found.
  T last([bool Function(T)? predicate]) {
    if (predicate == null) {
      if (this is KtList) return (this as KtList<T>).last();
      final i = iterator();
      if (!i.hasNext()) {
        throw const NoSuchElementException("Collection is empty");
      }
      var last = i.next();
      while (i.hasNext()) {
        last = i.next();
      }
      return last;
    } else {
      T? last;
      var found = false;
      for (final element in iter) {
        if (predicate(element)) {
          last = element;
          found = true;
        }
      }
      if (!found) {
        throw const NoSuchElementException(
            "Collection contains no element matching the predicate.");
      }
      return last!;
    }
  }

  /// Returns last index of [element], or -1 if the collection does not contain element.
  int lastIndexOf(T element) {
    if (this is KtList) return (this as KtList).lastIndexOf(element);
    var lastIndex = -1;
    var index = 0;
    for (final item in iter) {
      if (element == item) {
        lastIndex = index;
      }
      index++;
    }
    return lastIndex;
  }

  /// Returns the last element matching the given [predicate], or `null` if no such element was found.
  T? lastOrNull([bool Function(T)? predicate]) {
    if (predicate == null) {
      if (this is KtList) {
        final list = this as KtList<T>;
        return list.isEmpty() ? null : list.get(list.lastIndex);
      } else {
        final i = iterator();
        if (!i.hasNext()) {
          return null;
        }
        var last = i.next();
        while (i.hasNext()) {
          last = i.next();
        }
        return last;
      }
    } else {
      T? last;
      for (final element in iter) {
        if (predicate(element)) {
          last = element;
        }
      }
      return last;
    }
  }

  /// Returns a list containing the results of applying the given [transform] function
  /// to each element in the original collection.
  KtList<R> map<R>(R Function(T) transform) {
    final KtMutableList<R> list = mutableListOf<R>();
    final mapped = mapTo(list, transform);
    // TODO ping dort-lang/sdk team to check type bug
    // When in single line: type "DartMutableList<String>' is not a subtype of type 'Null"
    return mapped;
  }

  /// Returns a list containing the results of applying the given [transform] function
  /// to each element and its index in the original collection.
  /// @param [transform] function that takes the index of an element and the element itself
  /// and returns the result of the transform applied to the element.
  KtList<R> mapIndexed<R>(R Function(int index, T) transform) {
    final mapped = mapIndexedTo(mutableListOf<R>(), transform);
    // TODO ping dort-lang/sdk team to check type bug
    // When in single line: type "DartMutableList<String>' is not a subtype of type 'Null"
    return mapped;
  }

  /// Applies the given [transform] function to each element and its index in the original collection
  /// and appends the results to the given [destination].
  /// @param [transform] function that takes the index of an element and the element itself
  /// and returns the result of the transform applied to the element.
  C mapIndexedTo<R, C extends KtMutableCollection<R>>(
      C destination, R Function(int index, T) transform) {
    var index = 0;
    for (final item in iter) {
      destination.add(transform(index++, item));
    }
    return destination;
  }

  /// Applies the given [transform] function to each element of the original collection
  /// and appends the results to the given [destination].
  C mapTo<R, C extends KtMutableCollection<R>>(
      C destination, R Function(T) transform) {
    for (final item in iter) {
      destination.add(transform(item));
    }
    return destination;
  }

  /// Returns the first element yielding the largest value of the given function or `null` if there are no elements.
  T? maxBy<R extends Comparable>(R Function(T) selector) {
    final i = iterator();
    if (!iterator().hasNext()) return null;
    T maxElement = i.next();
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

  /// Returns the first element having the largest value according to the provided [comparator] or `null` if there are no elements.
  T? maxWith(Comparator<T> comparator) {
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

  /// Returns a list containing all elements of the original collection except the elements contained in the given [elements] collection.
  KtList<T> minus(KtIterable<T> elements) {
    if (this is KtCollection && (this as KtCollection).isEmpty()) {
      return toList();
    }
    return filterNot((it) => KtIterableExtensions(elements).contains(it));
  }

  /// Returns a list containing all elements of the original collection except the elements contained in the given [elements] collection.
  KtList<T> operator -(KtIterable<T> elements) => minus(elements);

  /// Returns a list containing all elements of the original collection without the first occurrence of the given [element].
  KtList<T> minusElement(T element) {
    final result = mutableListOf<T>();
    var removed = false;
    filterTo(result, (it) {
      if (!removed && it == element) {
        removed = true;
        return false;
      } else {
        return true;
      }
    });
    return result;
  }

  /// Returns the first element yielding the smallest value of the given function or `null` if there are no elements.
  T? minBy<R extends Comparable>(R Function(T) selector) {
    final i = iterator();
    if (!iterator().hasNext()) return null;
    T minElement = i.next();
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

  /// Returns the first element having the smallest value according to the provided [comparator] or `null` if there are no elements.
  T? minWith(Comparator<T> comparator) {
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

  /// Returns `true` if the collection has no elements or no elements match the given [predicate].
  bool none([bool Function(T)? predicate]) {
    if (this is KtCollection && (this as KtCollection).isEmpty()) return true;
    if (predicate == null) return !iterator().hasNext();
    for (final element in iter) {
      if (predicate(element)) {
        return false;
      }
    }
    return true;
  }

  /// Splits the original collection into pair of lists,
  /// where *first* list contains elements for which [predicate] yielded `true`,
  /// while *second* list contains elements for which [predicate] yielded `false`.
  KtPair<KtList<T>, KtList<T>> partition(bool Function(T) predicate) {
    final first = mutableListOf<T>();
    final second = mutableListOf<T>();
    for (final element in iter) {
      if (predicate(element)) {
        first.add(element);
      } else {
        second.add(element);
      }
    }
    return KtPair(first, second);
  }

  /// Returns a list containing all elements of the original collection and then all elements of the given [elements] collection.
  KtList<T> plus(KtIterable<T> elements) {
    final result = mutableListOf<T>();
    result.addAll(asIterable());
    result.addAll(elements);
    return result;
  }

  /// Returns a list containing all elements of the original collection and then all elements of the given [elements] collection.
  KtList<T> operator +(KtIterable<T> elements) => plus(elements);

  /// Returns a list containing all elements of the original collection and then the given [element].
  KtList<T> plusElement(T element) {
    final result = mutableListOf<T>();
    result.addAll(asIterable());
    result.add(element);
    return result;
  }

  /// Accumulates value starting with the first element and applying [operation] from left to right to current accumulator value and each element.
  S reduce<S>(S Function(S acc, T) operation) {
    final i = iterator();
    if (!i.hasNext()) {
      throw UnsupportedError("Empty collection can't be reduced.");
    }
    S accumulator = i.next() as S;
    while (i.hasNext()) {
      accumulator = operation(accumulator, i.next());
    }
    return accumulator;
  }

  /// Accumulates value starting with the first element and applying [operation] from left to right
  /// to current accumulator value and each element with its index in the original collection.
  /// @param [operation] function that takes the index of an element, current accumulator value
  /// and the element itself and calculates the next accumulator value.
  S reduceIndexed<S>(S Function(int index, S acc, T) operation) {
    final i = iterator();
    if (!i.hasNext()) {
      throw UnsupportedError("Empty collection can't be reduced.");
    }
    var index = 1;
    S accumulator = i.next() as S;
    while (i.hasNext()) {
      accumulator = operation(index++, accumulator, i.next());
    }
    return accumulator;
  }

  /// Returns a list with elements in reversed order.
  KtList<T> reversed() {
    if (this is KtCollection && (this as KtCollection).size <= 1) {
      return toList();
    }
    final list = toMutableList();
    list.reverse();
    return list;
  }

  /// Returns the single element matching the given [predicate], or throws an exception if the list is empty or has more than one element.
  T single([bool Function(T)? predicate]) {
    if (predicate == null) {
      final i = iterator();
      if (!i.hasNext()) {
        throw const NoSuchElementException("Collection is empty.");
      }
      final single = i.next();
      if (i.hasNext()) {
        throw ArgumentError("Collection has more than one element.");
      }
      return single;
    } else {
      T? single;
      var found = false;
      for (final element in iter) {
        if (predicate(element)) {
          if (found) {
            throw ArgumentError(
                "Collection contains more than one matching element.");
          }
          single = element;
          found = true;
        }
      }
      if (!found) {
        throw const NoSuchElementException(
            "Collection contains no element matching the predicate.");
      }
      return single!;
    }
  }

  /// Returns the single element matching the given [predicate], or `null` if element was not found or more than one element was found.
  T? singleOrNull([bool Function(T)? predicate]) {
    if (predicate == null) {
      final i = iterator();
      if (!i.hasNext()) return null;
      final single = i.next();
      if (i.hasNext()) {
        return null;
      }
      return single;
    } else {
      T? single;
      var found = false;
      for (final element in iter) {
        if (predicate(element)) {
          if (found) return null;
          single = element;
          found = true;
        }
      }
      if (!found) return null;
      return single;
    }
  }

  /// Returns a list of all elements sorted according to their natural sort order.
  KtList<T> sorted() => sortedWith(naturalOrder());

  /// Returns a list of all elements sorted according to natural sort order of the value returned by specified [selector] function.
  KtList<T> sortedBy<R extends Comparable>(R Function(T) selector) {
    return sortedWith(compareBy(selector));
  }

  /// Returns a list of all elements sorted descending according to natural sort order of the value returned by specified [selector] function.
  KtList<T> sortedByDescending<R extends Comparable>(R Function(T) selector) {
    return sortedWith(compareByDescending(selector));
  }

  /// Returns a list of all elements sorted descending according to their natural sort order.
  KtList<T> sortedDescending() => sortedWith(reverseOrder());

  /// Returns a list of all elements sorted according to the specified [comparator].
  KtList<T> sortedWith(Comparator<T> comparator) {
    final mutableList = toMutableList();
    // delegate to darts list implementation for sorting which is highly optimized
    mutableList.asList().sort(comparator);
    return mutableList;
  }

  /// Returns a set containing all elements that are contained by this collection and not contained by the specified collection.
  ///
  /// The returned set preserves the element iteration order of the original collection.
  KtSet<T> subtract(KtIterable<T> other) {
    final set = toMutableSet();
    set.removeAll(other);
    return set;
  }

  /// Returns the sum of all values produced by [selector] function applied to each element in the collection.
  R sumBy<R extends num>(R Function(T) selector) {
    var sum = R == double ? 0.0 : 0;
    for (final element in iter) {
      sum += selector(element);
    }
    return sum as R;
  }

  /// Returns the sum of all values produced by [selector] function applied to each element in the collection.
  @Deprecated("Use sumBy")
  double sumByDouble(double Function(T) selector) {
    return sumBy(selector);
  }

  /// Returns a list containing first [n] elements.
  KtList<T> take(int n) {
    if (n < 0) {
      throw ArgumentError("Requested element count $n is less than zero.");
    }
    if (n == 0) return emptyList();
    if (this is KtCollection) {
      final collection = this as KtCollection;
      if (n >= collection.size) return toList();

      if (n == 1) {
        // can't use listOf here because first() might return null
        return listFrom([first()]);
      }
    }
    var count = 0;
    final list = mutableListOf<T>();
    for (final item in iter) {
      if (count++ == n) {
        break;
      }
      list.add(item);
    }
    return KtIterableExtensions<T>(list).toList();
  }

  /// Returns a list containing first elements satisfying the given [predicate].
  KtList<T> takeWhile(bool Function(T) predicate) {
    final list = mutableListOf<T>();
    for (final item in iter) {
      if (!predicate(item)) {
        break;
      }
      list.add(item);
    }
    return list;
  }

  /// Appends all elements to the given [destination] collection.
  ///
  /// [destination] is not type checked by the compiler due to https://github.com/dart-lang/sdk/issues/35518,
  /// but will be checked at runtime.
  /// `M` actually is expected to be `M extends KtMutableCollection<T>`
  // TODO Change to `M extends KtMutableCollection<T>` once https://github.com/dart-lang/sdk/issues/35518 has been fixed
  C toCollection<C extends KtMutableCollection<dynamic>>(C destination) {
    assert(() {
      if (mutableListOf<T>() is! C) {
        throw ArgumentError(
            "toCollection destination has wrong type parameters."
            "\nExpected: KtMutableCollection<$T>, Actual: ${destination.runtimeType}"
            "\ndestination (${destination.runtimeType}) entries aren't subtype of "
            "map ($runtimeType) entries. Entries can't be copied to destination."
            "\n\n$kBug35518GenericTypeError");
      }
      return true;
    }());
    for (final item in iter) {
      destination.add(item);
    }
    return destination;
  }

  /// Returns a HashSet of all elements.
  KtMutableSet<T> toHashSet() => hashSetFrom(iter);

  /// Returns a [KtList] containing all elements.
  KtList<T> toList() => listFrom(iter);

  /// Returns a [KtMutableList] filled with all elements of this collection.
  KtMutableList<T> toMutableList() => mutableListFrom(iter);

  /// Returns a mutable set containing all distinct elements from the given collection.
  ///
  /// The returned set preserves the element iteration order of the original collection.
  KtMutableSet<T> toMutableSet() => linkedSetFrom(iter);

  /// Returns a [KtSet] of all elements.
  ///
  /// The returned set preserves the element iteration order of the original collection.
  KtSet<T> toSet() => linkedSetFrom(iter);

  /// Returns a set containing all distinct elements from both collections.
  ///
  /// The returned set preserves the element iteration order of the original collection.
  /// Those elements of the [other] collection that are unique are iterated in the end
  /// in the order of the [other] collection.
  KtSet<T> union(KtIterable<T> other) {
    final set = toMutableSet();
    set.addAll(other);
    return set;
  }

  /// Returns a list of snapshots of the window of the given [size]
  /// sliding along this collection with the given [step], where each
  /// snapshot is a list.
  ///
  /// Several last lists may have less elements than the given [size].
  ///
  /// Both [size] and [step] must be positive and can be greater than the number of elements in this collection.
  /// @param [size] the number of elements to take in each window
  /// @param [step] the number of elements to move the window forward by on an each step, by default 1
  /// @param [partialWindows] controls whether or not to keep partial windows in the end if any,
  /// by default `false` which means partial windows won't be preserved
  KtList<KtList<T>> windowed(int size,
      {int step = 1, bool partialWindows = false}) {
    final list = toList();
    final thisSize = list.size;
    final result = mutableListOf<KtList<T>>();
    final window = _MovingSubList(list);
    var index = 0;
    while (index < thisSize) {
      window.move(index, math.min(thisSize, index + size));
      if (!partialWindows && window.size < size) break;
      result.add(window.snapshot());
      index += step;
    }
    return result;
  }

  /// Returns a list of results of applying the given [transform] function to
  /// an each list representing a view over the window of the given [size]
  /// sliding along this collection with the given [step].
  ///
  /// Both [size] and [step] must be positive and can be greater than the number of elements in this collection.
  /// @param [size] the number of elements to take in each window
  /// @param [step] the number of elements to move the window forward by on an each step, by default 1
  /// @param [partialWindows] controls whether or not to keep partial windows in the end if any,
  /// by default `false` which means partial windows won't be preserved
  KtList<R> windowedTransform<R>(int size, R Function(KtList<T>) transform,
      {int step = 1, bool partialWindows = false}) {
    final list = toList();
    final thisSize = list.size;
    final result = mutableListOf<R>();
    final window = _MovingSubList(list);
    var index = 0;
    while (index < thisSize) {
      window.move(index, math.min(thisSize, index + size));
      if (!partialWindows && window.size < size) break;
      result.add(transform(window.snapshot()));
      index += step;
    }
    return result;
  }

  /// Returns a list of pairs built from the elements of `this` collection and [other] collection with the same index.
  /// The returned list has length of the shortest collection.
  KtList<KtPair<T, R>> zip<R>(KtIterable<R> other) =>
      zipTransform(other, (T a, R b) => KtPair(a, b));

  /// Returns a list of values built from the elements of `this` collection and the [other] collection with the same index
  /// using the provided [transform] function applied to each pair of elements.
  /// The returned list has length of the shortest collection.
  KtList<V> zipTransform<R, V>(
      KtIterable<R> other, V Function(T a, R b) transform) {
    final first = iterator();
    final second = other.iterator();
    final list = mutableListOf<V>();
    while (first.hasNext() && second.hasNext()) {
      list.add(transform(first.next(), second.next()));
    }
    return list;
  }

  /// Returns a list of pairs of each two adjacent elements in this collection.
  ///
  /// The returned list is empty if this collection contains less than two elements.
  KtList<KtPair<T, T>> zipWithNext() =>
      zipWithNextTransform((a, b) => KtPair(a, b));

  /// Returns a list containing the results of applying the given [transform] function
  /// to an each pair of two adjacent elements in this collection.
  ///
  /// The returned list is empty if this collection contains less than two elements.
  KtList<R> zipWithNextTransform<R>(R Function(T a, T b) transform) {
    final i = iterator();
    if (!i.hasNext()) {
      return emptyList();
    }
    final list = mutableListOf<R>();
    var current = i.next();
    while (i.hasNext()) {
      final next = i.next();
      list.add(transform(current, next));
      current = next;
    }
    return list;
  }
}

extension RequireNoNullsKtIterableExtension<T> on KtIterable<T?> {
  /// Returns an original collection containing all the non-`null` elements, throwing an [ArgumentError] if there are any `null` elements.
  KtIterable<T> requireNoNulls() {
    for (final element in iter) {
      if (element == null) {
        throw ArgumentError("null element found in $this.");
      }
    }
    return cast<T>();
  }

  /// Returns a list containing all elements that are not `null`.
  KtList<T> filterNotNull() {
    final list = filterNotNullTo(mutableListOf<T>());
    // TODO ping dort-lang/sdk team to check type bug
    // When in single line: type "DartMutableList<String>' is not a subtype of type 'Null"
    return list;
  }

  /// Appends all elements that are not `null` to the given [destination].
  ///
  /// [destination] is not type checked by the compiler due to https://github.com/dart-lang/sdk/issues/35518,
  /// but will be checked at runtime.
  /// [C] actually is expected to be `C extends KtMutableCollection<T>`
  // TODO Change to `C extends KtMutableCollection<T>` once https://github.com/dart-lang/sdk/issues/35518 has been fixed
  C filterNotNullTo<C extends KtMutableCollection<dynamic>>(C destination) {
    assert(() {
      if (destination is! KtMutableCollection<T> && mutableListOf<T>() is! C) {
        throw ArgumentError(
            "filterNotNullTo destination has wrong type parameters."
            "\nExpected: KtMutableCollection<$T>, Actual: ${destination.runtimeType}"
            "\ndestination (${destination.runtimeType}) entries aren't subtype of "
            "map ($runtimeType) entries. Entries can't be copied to destination."
            "\n\n$kBug35518GenericTypeError");
      }
      return true;
    }());
    for (final element in iter) {
      if (element != null) {
        destination.add(element);
      }
    }
    return destination;
  }

  /// Returns a list containing only the non-null results of applying the given [transform] function
  /// to each element and its index in the original collection.
  /// @param [transform] function that takes the index of an element and the element itself
  /// and returns the result of the transform applied to the element.
  KtList<R> mapIndexedNotNull<R>(R? Function(int index, T?) transform) {
    final mapped = mapIndexedNotNullTo(mutableListOf<R>(), transform);
    // TODO ping dort-lang/sdk team to check type bug
    // When in single line: type "DartMutableList<String>' is not a subtype of type 'Null"
    return mapped;
  }

  /// Applies the given [transform] function to each element and its index in the original collection
  /// and appends only the non-null results to the given [destination].
  /// @param [transform] function that takes the index of an element and the element itself
  /// and returns the result of the transform applied to the element.
  C mapIndexedNotNullTo<R, C extends KtMutableCollection<R>>(
      C destination, R? Function(int index, T?) transform) {
    var index = 0;
    for (final item in iter) {
      final element = transform(index++, item);
      if (element != null) {
        destination.add(element);
      }
    }
    return destination;
  }

  /// Returns a list containing the results of applying the given [transform] function
  /// to each element in the original collection.
  KtList<R> mapNotNull<R>(R? Function(T?) transform) {
    final mapped = mapNotNullTo(mutableListOf<R>(), transform);
    // TODO ping dort-lang/sdk team to check type bug
    // When in single line: type "DartMutableList<String>' is not a subtype of type 'Null"
    return mapped;
  }

  /// Applies the given [transform] function to each element in the original collection
  /// and appends only the non-null results to the given [destination].
  C mapNotNullTo<R, C extends KtMutableCollection<R>>(
      C destination, R? Function(T?) transform) {
    for (final item in iter) {
      final result = transform(item);
      if (result != null) {
        destination.add(result);
      }
    }
    return destination;
  }
}

// TODO: Should be <T, C extends KtIterable<T>> on C but then T resolves to dynamic
// https://github.com/dart-lang/sdk/issues/46117
extension ChainableKtIterableExtensions<T> on KtIterable<T> {
  /// Performs the given [action] on each element. Use with cascade syntax to return self.
  ///
  /// final result = listOf("a", "b", "c")
  ///     .onEach(print)
  ///     .map((it) => it.toUpperCase())
  ///     .getOrNull(0);
  /// // result: A
  ///
  /// Without the cascade syntax (..) [KtListExtensions.getOrNull] wouldn't be available.
  KtIterable<T> onEach(void Function(T item) action) {
    for (final element in iter) {
      action(element);
    }
    return this;
  }

  /// Performs the given action on each element, providing sequential index with the element, and returns the collection itself afterwards.
  KtIterable<T> onEachIndexed(void Function(int index, T item) action) {
    var index = 0;
    for (final item in iter) {
      action(index++, item);
    }
    return this;
  }
}

class _MovingSubList<T> {
  _MovingSubList(this.list);

  KtList<T> list;
  int _fromIndex = 0;
  int _size = 0;

  void move(int fromIndex, int toIndex) {
    if (fromIndex < 0 || toIndex > list.size) {
      throw IndexOutOfBoundsException(
          "fromIndex: $fromIndex, toIndex: $toIndex, size: ${list.size}");
    }
    if (fromIndex > toIndex) {
      throw ArgumentError("fromIndex: $fromIndex > toIndex: $toIndex");
    }
    _fromIndex = fromIndex;
    _size = toIndex - fromIndex;
  }

  KtList<T> snapshot() => list.subList(_fromIndex, _fromIndex + _size);

  int get size => _size;
}

extension NestedKtIterableExtensions<T> on KtIterable<KtIterable<T>> {
  /// Returns a single list of all elements from all collections in the given collection.
  KtList<T> flatten() {
    final result = KtMutableList<T>.empty();
    for (final element in iter) {
      result.addAll(element);
    }
    return result;
  }
}

extension UnzipKtIterableExtensions<T, R> on KtIterable<KtPair<T, R>> {
  /// Returns a pair of lists, where
  /// *first* list is built from the first values of each pair from this collection,
  /// *second* list is built from the second values of each pair from this collection.
  KtPair<KtList<T>, KtList<R>> unzip() {
    final listT = KtMutableList<T>.empty();
    final listR = KtMutableList<R>.empty();
    for (final pair in iter) {
      listT.add(pair.first);
      listR.add(pair.second);
    }
    return KtPair(listT, listR);
  }
}

/// View on an [KtIterable] casting each item when accessed
class _CastKtIterable<Source, T> extends KtIterable<T> {
  _CastKtIterable(this.iterable);

  KtIterable<Source> iterable;

  @override
  Iterable<T> get iter => iterable.dart.cast();

  @override
  KtIterator<T> iterator() {
    return _CastKtIterator(iterable.dart.iterator);
  }
}

class _CastKtIterator<Source, T> implements KtIterator<T> {
  _CastKtIterator(this.iterator) : _hasNext = iterator.moveNext() {
    if (_hasNext) {
      _nextValue = iterator.current as T;
    }
  }

  final Iterator<Source> iterator;
  T? _nextValue;
  bool _hasNext;

  @override
  bool hasNext() => _hasNext;

  @override
  T next() {
    if (!_hasNext) throw const NoSuchElementException();
    final e = _nextValue;
    _hasNext = iterator.moveNext();
    if (_hasNext) {
      _nextValue = iterator.current as T;
    }
    return e as T;
  }
}
