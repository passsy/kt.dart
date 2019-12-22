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
  /// Wraps this [List] with a [KtMutableList] interface.
  ///
  /// In most cases you don't want mutability. Use [toImmutableList] instead.
  ///
  /// Mutations on the [KtMutableList] are operated on the original [List].
  @experimental
  KtMutableList<T> get kt => DartMutableList.noCopy(this);

  /// Converts the [List] to a truly immutable [KtList]
  @experimental
  KtList<T> toImmutableList() => KtList.from(this);
}

extension SetInterop<T> on Set<T> {
  /// Wraps this [Set] with a [KtMutableSet] interface.
  ///
  /// In most cases you don't want mutability. Use [toImmutableList] instead.
  ///
  /// Mutations on the [KtMutableSet] are operated on the original [Set].
  @experimental
  KtMutableSet<T> get kt => DartMutableSet.noCopy(this);

  /// Converts the [Set] to a truly immutable [KtSet]
  @experimental
  KtSet<T> toImmutableList() => KtSet.from(this);
}

extension MapInterop<K, V> on Map<K, V> {
  /// Wraps this [Map] with a [KtMutableMap] interface.
  ///
  /// In most cases you don't want mutability. Use [toImmutableList] instead.
  ///
  /// Mutations on the [KtMutableMap] are operated on the original [Map].
  @experimental
  KtMutableMap<K, V> get kt => DartMutableMap.noCopy(this);

  /// Converts the [Map] to a truly immutable [KtMap]
  @experimental
  KtMap<K, V> toImmutableList() => KtMap.from(this);
}
