import "package:kt_dart/collection.dart";
import "package:kt_dart/src/collection/impl/iterable.dart";
import "package:kt_dart/src/collection/impl/list_mutable.dart";
import "package:kt_dart/src/collection/impl/map_mutable.dart";
import "package:kt_dart/src/collection/impl/set_mutable.dart";

extension IterableInterop<T> on Iterable<T> {
  @experimental
  KtIterable<T> get kt => DartIterable(this);
}

extension ListInterop<T> on List<T> {
  @experimental
  KtMutableList<T> get kt => DartMutableList.noCopy(this);

  KtList<T> immutable() => KtList.from(this);
}

extension SetInterop<T> on Set<T> {
  @experimental
  KtMutableSet<T> get kt => DartMutableSet.noCopy(this);

  KtSet<T> immutable() => KtSet.from(this);
}

extension MapInterop<K, V> on Map<K, V> {
  @experimental
  KtMutableMap<K, V> get kt => DartMutableMap.noCopy(this);

  KtMap<K, V> immutable() => KtMap.from(this);
}
