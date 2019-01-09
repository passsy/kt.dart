import 'package:dart_kollection/dart_kollection.dart';
import 'package:dart_kollection/src/collection/set.dart';
import 'package:dart_kollection/src/collection/set_empty.dart';
import 'package:dart_kollection/src/util/arguments.dart';

/**
 * A generic unordered collection of elements that does not support duplicate elements.
 * Methods in this interface support only read-only access to the set;
 * read/write access is supported through the [KMutableSet] interface.
 * @param E the type of elements contained in the set. The set is covariant on its element type.
 */
@Deprecated(
    "Please migrate to kotlin.dart https://github.com/passsy/kotlin.dart")
abstract class KSet<T> implements KCollection<T> {
  @Deprecated(
      "Please migrate to kotlin.dart https://github.com/passsy/kotlin.dart")
  factory KSet.empty() => EmptySet<T>();

  @Deprecated(
      "Please migrate to kotlin.dart https://github.com/passsy/kotlin.dart")
  factory KSet.from([Iterable<T> elements = const []]) {
    if (elements.isEmpty) return EmptySet<T>();
    return DartSet(elements);
  }

  @Deprecated(
      "Please migrate to kotlin.dart https://github.com/passsy/kotlin.dart")
  factory KSet.of(
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
    return KSet.from(args);
  }

  /**
   * dart interop set for time critical operations such as sorting
   */
  Set<T> get set;

  // Query Operations
  @override
  int get size;

  @override
  bool isEmpty();

  @override
  bool contains(T element);

  @override
  bool containsAll(KCollection<T> elements);

  // Bulk Operations
  @override
  KIterator<T> iterator();
}
