import 'package:dart_kollection/dart_kollection.dart';
import 'package:dart_kollection/src/collection/dart_iterable.dart';
import 'package:dart_kollection/src/collection/iterator.dart';
import 'package:dart_kollection/src/extension/iterable_extension_mixin.dart';
import 'package:dart_kollection/src/extension/iterable_mutable_extension_mixin.dart';

class EmptyIterable<T> extends KIterable<T> with KIterableExtensionsMixin<T> {
  @override
  Iterable<T> get iter => EmptyDartIterable<T>();

  @override
  KIterator<T> iterator() => InterOpKIterator(iter.iterator);
}

class DartIterable<T> extends KIterable<T> with KIterableExtensionsMixin<T> {
  DartIterable(this._iterable);

  Iterable<T> _iterable;

  @override
  Iterable<T> get iter => _iterable;

  @override
  KIterator<T> iterator() => InterOpKIterator(_iterable.iterator);
}

class DartMutableIterable<T> extends KMutableIterable<T>
    with KIterableExtensionsMixin<T>, KMutableIterableExtensionsMixin<T> {
  DartMutableIterable(this._iterable);

  // only allow lists for now, because the mutable iterator only supports lists
  List<T> _iterable;

  @override
  Iterable<T> get iter => _iterable;

  @override
  KMutableIterator<T> iterator() => InterOpKListIterator(_iterable, 0);
}
