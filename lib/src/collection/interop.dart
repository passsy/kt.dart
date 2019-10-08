import "package:kt_dart/collection.dart";

extension ListInterop<T> on List<T> {
  @experimental
  KtList<T> get kt => KtList.from(this);
}

extension SetInterop<T> on Set<T> {
  @experimental
  KtSet<T> get kt => KtSet.from(this);
}

extension MapInterop<K, V> on Map<K, V> {
  @experimental
  KtMap<K, V> get kt => KtMap.from(this);
}
