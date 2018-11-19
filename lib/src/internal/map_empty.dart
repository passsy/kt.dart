import 'package:dart_kollection/dart_kollection.dart';

import 'iterable_extensions.dart';

final KMap<Object, Object> kEmptyMap = new _EmptyMap();

class _EmptyMap implements KMap<Object, Object> {
  @override
  operator [](Object key) => null;

  @override
  bool containsKey(Object key) => false;

  @override
  bool containsValue(Object value) => false;

  @override
  KSet<KMapEntry<Object, Object>> get entries => emptySet();

  @override
  Object get(Object key) => null;

  @override
  Object getOrDefault(Object key, Object defaultValue) => defaultValue;

  @override
  bool isEmpty() => true;

  @override
  KSet<Object> get keys => emptySet();

  @override
  int get size => 0;

  @override
  KCollection<Object> get values => emptySet();

  @override
  bool operator ==(Object other) => other is KMap && other.isEmpty();

  @override
  int get hashCode => 0;

  @override
  String toString() => "{}";
}
