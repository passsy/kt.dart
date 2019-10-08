import "package:kt_dart/collection.dart";
import "package:kt_dart/src/collection/impl/dart_iterable.dart";
import "package:kt_dart/src/collection/impl/iterator.dart";

class EmptyIterable<T> extends KtIterable<T> {
  @override
  Iterable<T> get iter => EmptyDartIterable<T>();

  @override
  KtIterator<T> iterator() => InterOpKIterator(iter.iterator);
}

class DartIterable<T> extends KtIterable<T> {
  DartIterable(this._iterable);

  final Iterable<T> _iterable;

  @override
  Iterable<T> get iter => _iterable;

  @override
  KtIterator<T> iterator() => InterOpKIterator(_iterable.iterator);
}

class DartMutableIterable<T> extends KtMutableIterable<T> {
  DartMutableIterable(this._iterable);

  // only allow lists for now, because the mutable iterator only supports lists
  final List<T> _iterable;

  @override
  Iterable<T> get iter => _iterable;

  @override
  KtMutableIterator<T> iterator() => InterOpKtListIterator(_iterable, 0);
}
