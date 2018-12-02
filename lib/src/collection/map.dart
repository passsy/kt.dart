import 'package:dart_kollection/dart_kollection.dart';
import 'package:dart_kollection/src/extension/map_extensions_mixin.dart';
import 'package:dart_kollection/src/util/hash.dart';

class DartMap<K, V> with KMapExtensionsMixin<K, V> implements KMap<K, V> {
  final Map<K, V> _map;
  int _hashCode;

  DartMap([Map<K, V> map = const {}])
      :
// copy list to prevent external modification
        _map = Map.unmodifiable(map),
        super();

  @override
  Map<K, V> get map => _map;

  @override
  bool containsKey(K key) => _map.containsKey(key);

  @override
  bool containsValue(V value) => _map.containsValue(value);

  @override
  KSet<KMapEntry<K, V>> get entries => setOf(_map.entries.map((entry) => _Entry.from(entry)));

  @override
  V get(K key) => _map[key];

  @override
  V operator [](K key) => get(key);

  @override
  V getOrDefault(K key, V defaultValue) => _map[key] ?? defaultValue;

  @override
  bool isEmpty() => _map.isEmpty;

  @override
  KSet<K> get keys => setOf(_map.keys);

  @override
  int get size => _map.length;

  @override
  KCollection<V> get values => listOf(_map.values);

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
  int get hashCode {
    if (_hashCode == null) {
      _hashCode =
          hashObjects(_map.keys.map((key) => hash2(key.hashCode, _map[key].hashCode)).toList(growable: false)..sort());
    }
    return _hashCode;
  }
}

class _Entry<K, V> extends KMapEntry<K, V> {
  @override
  final K key;

  @override
  final V value;

  _Entry(this.key, this.value);

  _Entry.from(MapEntry<K, V> entry)
      : key = entry.key,
        value = entry.value;

  @override
  KPair<K, V> toPair() => KPair(key, value);
}
