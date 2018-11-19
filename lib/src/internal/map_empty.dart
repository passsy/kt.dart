import 'package:dart_kollection/dart_kollection.dart';

import 'iterable_extensions.dart';

class EmptyMap<K, V> implements KMap<K, V> {
  @override
  operator [](K key) => null;

  @override
  bool containsKey(K key) => false;

  @override
  bool containsValue(V value) => false;

  @override
  KSet<KMapEntry<K, V>> get entries => emptySet();

  @override
  V get(K key) => null;

  @override
  V getOrDefault(K key, V defaultValue) => defaultValue;

  @override
  bool isEmpty() => true;

  @override
  KSet<K> get keys => emptySet();

  @override
  int get size => 0;

  @override
  KCollection<V> get values => emptySet();

  @override
  bool operator ==(Object other) => other is KMap && other.isEmpty();

  @override
  int get hashCode => 0;

  @override
  String toString() => "{}";
}
