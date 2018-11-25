import 'package:dart_kollection/dart_kollection.dart';
import 'package:dart_kollection/src/extension/map_extensions_mixin.dart';
import 'package:dart_kollection/src/extension/map_mutable_extensions_mixin.dart';
import 'package:dart_kollection/src/util/hash.dart';

class DartMutableMap<K, V> extends KMutableMap<K, V> with KMutableMapExtensionsMixin<K, V>, KMapExtensionsMixin<K, V> {
  final Map<K, V> _map;

  DartMutableMap([Map<K, V> map = const {}])
      :
        // copy list to prevent external modification
        _map = Map<K, V>.from(map),
        super();

  /// Doesn't copy the incoming list which is more efficient but risks accidental modification of the incoming map.
  ///
  /// Use with care!
  DartMutableMap.noCopy(Map<K, V> map)
      : assert(map != null),
        _map = map,
        super();

  @override
  bool containsKey(K key) => _map.containsKey(key);

  @override
  bool containsValue(V value) => _map.containsValue(value);

  @override
  KMutableSet<KMutableEntry<K, V>> get entries => linkedSetOf(_map.entries.map((entry) => _MutableEntry.from(entry)));

  @override
  V get(K key) => _map[key];

  @override
  V operator [](K key) => get(key);

  @override
  V getOrDefault(K key, V defaultValue) => _map[key] ?? defaultValue;

  @override
  bool isEmpty() => _map.isEmpty;

  @override
  KMutableSet<K> get keys => setOf(_map.keys);

  @override
  int get size => _map.length;

  @override
  KMutableCollection<V> get values => mutableListOf(_map.values);

  @override
  void clear() => _map.clear();

  @override
  V put(K key, V value) {
    final V prev = _map[key];
    _map[key] = value;
    return prev;
  }

  @override
  void putAll(KMap<K, V> from) {
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
    if (other is! KMap) return false;
    if (other.size != size) return false;
    if (other.hashCode != hashCode) return false;
    for (final key in keys.iter) {
      if (other[key] != this[key]) return false;
    }
    return true;
  }

  @override
  int get hashCode =>
      hashObjects(_map.keys.map((key) => hash2(key.hashCode, _map[key].hashCode)).toList(growable: false)..sort());
}

class _Entry<K, V> implements KMapEntry<K, V> {
  _Entry(this.key, this.value);

  _Entry.from(MapEntry<K, V> entry)
      : key = entry.key,
        value = entry.value;

  @override
  final K key;

  @override
  final V value;
}

class _MutableEntry<K, V> implements KMutableEntry<K, V> {
  _MutableEntry(this._key, this._value);

  _MutableEntry.from(MapEntry<K, V> entry)
      : _key = entry.key,
        _value = entry.value;

  K _key;
  V _value;

  @override
  K get key => _key;

  @override
  V get value => _value;

  @override
  V setValue(V newValue) {
    final old = _value;
    _value = value;
    return old;
  }
}
