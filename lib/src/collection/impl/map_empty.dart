import "package:kt_dart/collection.dart";

class EmptyMap<K, V> extends Object implements KtMap<K, V> {
  EmptyMap();

  @override
  Iterable<KtMapEntry<K, V>> get iter => List.unmodifiable(const []);

  @override
  Map<K, V> asMap() => Map.unmodifiable(const {});

  @override
  V operator [](K key) => null;

  @override
  bool containsKey(K key) => false;

  @override
  bool containsValue(V value) => false;

  @override
  KtSet<KtMapEntry<K, V>> get entries => emptySet();

  @override
  V get(K key) => null;

  @override
  V getOrDefault(K key, V defaultValue) => defaultValue;

  @override
  bool isEmpty() => true;

  @override
  KtSet<K> get keys => emptySet();

  @override
  int get size => 0;

  @override
  KtCollection<V> get values => emptySet();

  @override
  bool operator ==(Object other) => other is KtMap && other.isEmpty();

  @override
  int get hashCode => 0;

  @override
  String toString() => "{}";
}
