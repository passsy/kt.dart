import "package:kt_dart/collection.dart";
import "package:kt_dart/src/util/hash.dart";

class DartMap<K, V> extends Object implements KtMap<K, V> {
  DartMap([Map<K, V> map = const {}])
      :
// copy list to prevent external modification
        _map = Map.unmodifiable(map),
        super();

  final Map<K, V> _map;

  @override
  Iterable<KtMapEntry<K, V>> get iter =>
      _map.entries.map((entry) => _Entry.from(entry));

  @override
  Map<K, V> asMap() => _map;

  @override
  bool containsKey(K key) => _map.containsKey(key);

  @override
  bool containsValue(V value) => _map.containsValue(value);

  @override
  KtSet<KtMapEntry<K, V>> get entries =>
      setFrom(_map.entries.map((entry) => _Entry.from(entry)));

  @override
  V? get(K key) => _map[key];

  @override
  V? operator [](K key) => get(key);

  @override
  V getOrDefault(K key, V defaultValue) => _map[key] ?? defaultValue;

  @override
  bool isEmpty() => _map.isEmpty;

  @override
  KtSet<K> get keys => setFrom(_map.keys);

  @override
  int get size => _map.length;

  @override
  KtCollection<V> get values => listFrom(_map.values);

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
  int get hashCode {
    return hashObjects(_map.keys
        .map((key) => hash2(key.hashCode, _map[key].hashCode))
        .toList(growable: false)
          ..sort());
  }

  @override
  String toString() {
    return entries.joinToString(
        separator: ", ", prefix: "{", postfix: "}", transform: _entryToString);
  }

  String _entryToString(KtMapEntry<K, V> entry) =>
      "${_toString(entry.key)}=${_toString(entry.value)}";

  String _toString(Object? o) =>
      identical(o, this) ? "(this Map)" : o.toString();
}

class _Entry<K, V> extends KtMapEntry<K, V> {
  _Entry(this.key, this.value);

  factory _Entry.from(MapEntry<K, V> entry) => _Entry(entry.key, entry.value);

  @override
  final K key;

  @override
  final V value;

  @override
  KtPair<K, V> toPair() => KtPair(key, value);
}
