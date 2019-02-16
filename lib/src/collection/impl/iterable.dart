import 'package:kt_dart/collection.dart';
import 'package:kt_dart/src/collection/extension/iterable_extension_mixin.dart';
import 'package:kt_dart/src/collection/extension/iterable_mutable_extension_mixin.dart';
import 'package:kt_dart/src/collection/impl/dart_iterable.dart';
import 'package:kt_dart/src/collection/impl/iterator.dart';

class EmptyIterable<T> extends KtIterable<T> with KtIterableExtensionsMixin<T> {
  @override
  Iterable<T> get iter => EmptyDartIterable<T>();

  @override
  KtIterator<T> iterator() => InterOpKtIterator(iter.iterator);
}

class KtToDartIterable<T> extends Iterable<T> {
  KtToDartIterable(this.iterable);

  final KtIterable<T> iterable;

  @override
  Iterator<T> get iterator => DartToKtIterator(iterable.iterator());
}

class DartIterable<T> extends KtIterable<T> with KtIterableExtensionsMixin<T> {
  DartIterable(this._iterable);

  Iterable<T> _iterable;

  @override
  Iterable<T> get iter => _iterable;

  @override
  KtIterator<T> iterator() => InterOpKtIterator(_iterable.iterator);
}

class DartMutableIterable<T> extends KtMutableIterable<T>
    with KtIterableExtensionsMixin<T>, KtMutableIterableExtensionsMixin<T> {
  DartMutableIterable(this._iterable);

  // only allow lists for now, because the mutable iterator only supports lists
  List<T> _iterable;

  @override
  Iterable<T> get iter => _iterable;

  @override
  KtMutableIterator<T> iterator() => InterOpKtListIterator(_iterable, 0);
}
