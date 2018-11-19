import 'package:dart_kollection/dart_kollection.dart';

/**
 * A generic unordered collection of elements that does not support duplicate elements, and supports
 * adding and removing elements.
 * @param E the type of elements contained in the set. The mutable set is invariant on its element type.
 */
abstract class KMutableSet<E> implements KSet<E>, KMutableCollection<E> {}
