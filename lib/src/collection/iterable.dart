import 'package:dart_kollection/dart_kollection.dart';
import 'package:dart_kollection/src/collection/dart_iterable.dart';
import 'package:dart_kollection/src/collection/iterator.dart';
import 'package:dart_kollection/src/extension/iterable_extension_mixin.dart';

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
