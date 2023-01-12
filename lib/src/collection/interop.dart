import "package:kt_dart/collection.dart";
import "package:kt_dart/src/collection/impl/iterable.dart";
import "package:kt_dart/src/collection/impl/list_mutable.dart";
import "package:kt_dart/src/collection/impl/map_mutable.dart";
import "package:kt_dart/src/collection/impl/set_mutable.dart";
import 'package:meta/meta.dart';

extension IterableInterop<T> on Iterable<T> {
  KtIterable<T> get kt => DartIterable(this);

  /// Converts the [Iterable] to a truly immutable [KtList]
  @useResult
  KtList<T> toImmutableList() => KtList.from(this);

  /// Converts the [Iterable] to a truly immutable [KtSet]
  @useResult
  KtSet<T> toImmutableSet() => KtSet.from(this);
}

extension ListInterop<T> on List<T> {
  /// Wraps this [List] with a [KtMutableList] interface.
  ///
  /// In most cases you don't want mutability. Use [toImmutableList] instead.
  ///
  /// Mutations on the [KtMutableList] are operated on the original [List].
  KtMutableList<T> get kt => DartMutableList.noCopy(this);

  /// Converts the [List] to a truly immutable [KtList]
  KtList<T> toImmutableList() => KtList.from(this);
}

extension SetInterop<T> on Set<T> {
  /// Wraps this [Set] with a [KtMutableSet] interface.
  ///
  /// In most cases you don't want mutability. Use [toImmutableSet] instead.
  ///
  /// Mutations on the [KtMutableSet] are operated on the original [Set].
  KtMutableSet<T> get kt => DartMutableSet.noCopy(this);

  /// Converts the [Set] to a truly immutable [KtSet]
  @useResult
  KtSet<T> toImmutableSet() => KtSet.from(this);
}

extension MapInterop<K, V> on Map<K, V> {
  /// Wraps this [Map] with a [KtMutableMap] interface.
  ///
  /// In most cases you don't want mutability. Use [toImmutableMap] instead.
  ///
  /// Mutations on the [KtMutableMap] are operated on the original [Map].
  KtMutableMap<K, V> get kt => DartMutableMap.noCopy(this);

  /// Converts the [Map] to a truly immutable [KtMap]
  @useResult
  KtMap<K, V> toImmutableMap() => KtMap.from(this);
}
