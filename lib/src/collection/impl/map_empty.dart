import 'package:kt_dart/collection.dart';
import 'package:kt_dart/src/collection/extension/map_extensions_mixin.dart';

class EmptyMap<K, V> with KtMapExtensionsMixin<K, V> implements KtMap<K, V> {

  @override
  Iterable<MapEntry<K, V>> get iter => [];

  @override
  Map<K, V> asMap() {
    return Map.unmodifiable({});
  }

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
