import "package:kt_dart/collection.dart";
import "package:kt_dart/src/util/hash.dart";

class DartMutableMap<K, V> extends Object implements KtMutableMap<K, V> {
  DartMutableMap([Map<K, V> map = const {}])
      :
        // copy list to prevent external modification
        _map = Map<K, V>.from(map),
        super();

  /// Doesn't copy the incoming list which is more efficient but risks accidental modification of the incoming map.
  ///
  /// Use with care!
  const DartMutableMap.noCopy(Map<K, V> map)
      : _map = map,
        super();

  final Map<K, V> _map;

  @override
  Iterable<KtMapEntry<K, V>> get iter =>
      _map.entries.map((entry) => _MutableEntry.from(entry, this));

  @override
  Map<K, V> asMap() => _map;

  @override
  bool containsKey(K key) => _map.containsKey(key);

  @override
  bool containsValue(V value) => _map.containsValue(value);

  @override
  KtMutableSet<KtMutableMapEntry<K, V>> get entries => linkedSetFrom(
      _map.entries.map((entry) => _MutableEntry.from(entry, this)));

  @override
  V? get(K key) => _map[key];

  @override
  V? operator [](K key) => get(key);

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
  V? put(K key, V value) {
    final V? prev = _map[key];
    _map[key] = value;
    return prev;
  }

  @override
  void operator []=(K key, V value) => put(key, value);

  @override
  void putAll(KtMap<K, V> from) {
    for (final entry in from.entries.iter) {
      _map[entry.key] = entry.value;
    }
  }

  @override
  V? remove(K key) => _map.remove(key);

  @override
  bool removeMapping(K key, V value) {
    for (final entry in _map.entries) {
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
  KtMutableIterator<KtMutableMapEntry<K, V>> iterator() => _MapIterator(this);

  @override
  int get hashCode => hashObjects(_map.keys
      .map((key) => hash2(key.hashCode, _map[key].hashCode))
      .toList(growable: false)
    ..sort());

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

class _MutableEntry<K, V> implements KtMutableMapEntry<K, V> {
  _MutableEntry(this._key, this._value, this._parent);

  factory _MutableEntry.from(
    MapEntry<K, V> entry,
    DartMutableMap<K, V> parent,
  ) =>
      _MutableEntry(entry.key, entry.value, parent);

  K _key;
  V _value;

  /// Object reference for the [DartMutableMap] which contains this
  /// [_MutableEntry].
  DartMutableMap<K, V> _parent;

  @override
  K get key => _key;

  @override
  V get value => _value;

  @override
  V setValue(V newValue) {
    final oldValue = _value;
    _parent._map.update(key, (value) => value = newValue);
    return oldValue;
  }

  @override
  KtPair<K, V> toPair() => KtPair(_key, _value);
}

class _MapIterator<K, V> implements KtMutableIterator<KtMutableMapEntry<K, V>> {
  _MapIterator(this.map) : entriesIterator = map.entries.iterator();

  final DartMutableMap<K, V> map;
  final KtMutableIterator<KtMutableMapEntry<K, V>> entriesIterator;
  K? lastReturnedKey;

  @override
  bool hasNext() => entriesIterator.hasNext();

  @override
  KtMutableMapEntry<K, V> next() {
    final nextEntry = entriesIterator.next();
    lastReturnedKey = nextEntry.key;
    return nextEntry;
  }

  @override
  void remove() {
    final lastReturnedKey = this.lastReturnedKey;
    if (lastReturnedKey == null) {
      throw StateError("next() must be called before remove()");
    }
    map.remove(lastReturnedKey);
    this.lastReturnedKey = null;
  }
}
