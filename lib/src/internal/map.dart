import 'package:dart_kollection/dart_kollection.dart';

class DartMap<K, V> extends KMap<K, V> {
  final Map _map;

  DartMap([Map<K, V> map = const {}])
      :
// copy list to prevent external modification
        _map = Map.from(map),
        super();

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
}
