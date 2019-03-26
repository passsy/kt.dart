import 'package:kt_dart/collection.dart';
import 'package:kt_dart/src/collection/extension/map_extensions_mixin.dart';
import 'package:kt_dart/src/collection/extension/map_mutable_extensions_mixin.dart';
import 'package:kt_dart/src/util/hash.dart';

class DartMutableMap<K, V>
    with KtMapExtensionsMixin<K, V>, KtMutableMapExtensionsMixin<K, V>
    implements KtMutableMap<K, V> {
  DartMutableMap([Map<K, V> map = const {}])
      :
        // copy list to prevent external modification
        _map = Map<K, V>.from(map),
        super();

  /// Doesn't copy the incoming list which is more efficient but risks accidental modification of the incoming map.
  ///
  /// Use with care!
  DartMutableMap.noCopy(Map<K, V> map)
      : _map = map,
        super();

  final Map<K, V> _map;

  @override
  Iterable<MapEntry<K, V>> get iter => _map.entries;

  @override
  Map<K, V> asMap() => _map;

  @override
  bool containsKey(K key) => _map.containsKey(key);

  @override
  bool containsValue(V value) => _map.containsValue(value);

  @override
  KtMutableSet<KtMutableMapEntry<K, V>> get entries =>
      linkedSetFrom(_map.entries.map((entry) => _MutableEntry.from(entry)));

  @override
  V get(K key) => _map[key];

  @override
  V operator [](K key) => get(key);

  @override
  V getOrDefault(K key, V defaultValue) => _map[key] ?? defaultValue;

  @override
  bool isEmpty() => _map.isEmpty;

  @override
  KtMutableSet<K> get keys => linkedSetFrom(_map.keys);

  @override
  int get size => _map.length;

  @override
  KtMutableCollection<V> get values => mutableListFrom(_map.values);

  @override
  void clear() => _map.clear();

  @override
  V put(K key, V value) {
    final V prev = _map[key];
    _map[key] = value;
    return prev;
  }

  @override
  void operator []=(K key, V value) => put(key, value);

  @override
  void putAll(KtMap<K, V> from) {
    assert(() {
      if (from == null) throw ArgumentError("from can't be null");
      return true;
    }());
    for (var entry in from.entries.iter) {
      _map[entry.key] = entry.value;
    }
  }

  @override
  V remove(K key) {
    return _map.remove(key);
  }

  @override
  bool removeMapping(K key, V value) {
    for (var entry in _map.entries) {
      if (entry.key == key && entry.value == value) {
        _map.remove(key);
        return true;
      }
    }
    return false;
  }

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! KtMap) return false;
    if (other.size != size) return false;
    if (other.hashCode != hashCode) return false;
    for (final key in keys.iter) {
      if (other[key] != this[key]) return false;
    }
    return true;
  }

  @override
  int get hashCode => hashObjects(_map.keys
      .map((key) => hash2(key.hashCode, _map[key].hashCode))
      .toList(growable: false)
        ..sort());
}

class _MutableEntry<K, V> implements KtMutableMapEntry<K, V> {
  _MutableEntry(this._key, this._value);

  factory _MutableEntry.from(MapEntry<K, V> entry) =>
      _MutableEntry(entry.key, entry.value);

  K _key;
  V _value;

  @override
  K get key => _key;

  @override
  V get value => _value;

  @override
  V setValue(V newValue) {
    // setting _value here is wrong because is is a copy of the original value.
    // setValue should modify the underlying list, not the copy
    // see how kotlin solved this:
    // https://github.com/JetBrains/kotlin/blob/ba6da7c40a6cc502508faf6e04fa105b96bc7777/libraries/stdlib/js/src/kotlin/collections/InternalHashCodeMap.kt
    throw UnimplementedError(
        "setValue() in not yet implemented. Please vote for https://github.com/passsy/dart_kollection/issues/55 for prioritization");
  }

  @override
  KtPair<K, V> toPair() => KtPair(_key, _value);
}
