import 'package:dart_kollection/dart_kollection.dart';

/**
 * Classes that inherit from this interface can be represented as a sequence of elements that can
 * be iterated over.
 * @param T the type of element being iterated over. The iterator is covariant on its element type.
 */
abstract class KIterable<T> implements KIterableExtensions<T> {
  /**
   * dart interop iterable for loops
   */
  Iterable<T> get iter;

  /**
   * Returns an iterator over the elements of this object.
   */
  KIterator<T> iterator();
}

abstract class KIterableExtensions<T> {
  /**
   * Returns `true` if at least one element matches the given [predicate].
   */
  bool any([bool Function(T element) test = null]);

  /**
   * Performs the given [action] on each element.
   */
  void forEach(void action(T element));
}
