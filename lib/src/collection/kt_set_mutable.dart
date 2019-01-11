import 'package:kotlin_dart/collection.dart';
import 'package:kotlin_dart/src/collection/impl/set_mutable.dart';
import 'package:kotlin_dart/src/util/arguments.dart';

/**
 * A generic unordered collection of elements that does not support duplicate elements, and supports
 * adding and removing elements.
 * @param [T] the type of elements contained in the set. The mutable set is invariant on its element type.
 */
@Deprecated("Please migrate to kt.dart https://github.com/passsy/kt.dart")
abstract class KtMutableSet<T> implements KtSet<T>, KtMutableCollection<T> {
  @Deprecated("Please migrate to kt.dart https://github.com/passsy/kt.dart")
  factory KtMutableSet.empty() => KtMutableSet.from();

  @Deprecated("Please migrate to kt.dart https://github.com/passsy/kt.dart")
  factory KtMutableSet.from([Iterable<T> elements = const []]) {
    return DartMutableSet(elements);
  }

  @Deprecated("Please migrate to kt.dart https://github.com/passsy/kt.dart")
  factory KtMutableSet.of(
      [T arg0,
      T arg1,
      T arg2,
      T arg3,
      T arg4,
      T arg5,
      T arg6,
      T arg7,
      T arg8,
      T arg9]) {
    final args =
        argsToList(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    return KtMutableSet.from(args);
  }

  // Query Operations
  @override
  KtMutableIterator<T> iterator();

  // Modification Operations
  @override
  bool add(T element);

  @override
  bool remove(T element);

  // Bulk Modification Operations
  @override
  bool addAll(KtIterable<T> elements);

  @override
  bool removeAll(KtIterable<T> elements);

  @override
  bool retainAll(KtIterable<T> elements);

  @override
  void clear();
}
