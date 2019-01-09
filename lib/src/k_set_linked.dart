import 'package:dart_kollection/dart_kollection.dart';
import 'package:dart_kollection/src/collection/set_hash_linked.dart';
import 'package:dart_kollection/src/util/arguments.dart';

@Deprecated(
    "Please migrate to kotlin.dart https://github.com/passsy/kotlin.dart")
abstract class KLinkedSet<T> implements KMutableSet<T> {
  @Deprecated(
      "Please migrate to kotlin.dart https://github.com/passsy/kotlin.dart")
  factory KLinkedSet.empty() => KLinkedSet.from();

  @Deprecated(
      "Please migrate to kotlin.dart https://github.com/passsy/kotlin.dart")
  factory KLinkedSet.from([Iterable<T> elements = const []]) {
    return DartLinkedSet<T>(elements);
  }

  @Deprecated(
      "Please migrate to kotlin.dart https://github.com/passsy/kotlin.dart")
  factory KLinkedSet.of(
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
    return KLinkedSet.from(args);
  }
}
