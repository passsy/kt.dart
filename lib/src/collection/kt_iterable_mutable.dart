import 'package:kt_dart/collection.dart';

/// Classes that inherit from this interface can be represented as a sequence of elements that can
/// be iterated over and that supports removing elements during iteration.
/// @param T the type of element being iterated over. The mutable iterator is invariant on its element type.
// ignore: one_member_abstracts
abstract class KtMutableIterable<T> implements KtIterable<T> {
  /// Returns an iterator over the elements of this sequence that supports removing elements during iteration.
  @override
  KtMutableIterator<T> iterator();
}
