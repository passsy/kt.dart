import 'package:dart_kollection/dart_kollection.dart';

/**
 * Classes that inherit from this interface can be represented as a sequence of elements that can
 * be iterated over and that supports removing elements during iteration.
 * @param T the type of element being iterated over. The mutable iterator is invariant on its element type.
 */
abstract class KMutableIterable<T> implements KIterable<T> {
  /**
   * Returns an iterator over the elements of this sequence that supports removing elements during iteration.
   */
  KMutableIterator<T> iterator();
}
