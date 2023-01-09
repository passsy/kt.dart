import "package:kt_dart/collection.dart";
import 'package:meta/meta.dart';

/// Represents a generic pair of two values.
///
/// There is no meaning attached to values in this class, it can be used for any purpose.
/// Pair exhibits value semantics, i.e. two pairs are equal if both components are equal.
///
/// @param A type of the first value.
/// @param B type of the second value.
/// @property first First value.
/// @property second Second value.
class KtPair<A, B> {
  const KtPair(this.first, this.second);

  final A first;
  final B second;

  @override
  String toString() => "($first, $second)";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KtPair &&
          runtimeType == other.runtimeType &&
          first == other.first &&
          second == other.second;

  @override
  int get hashCode => first.hashCode ^ second.hashCode;
}

extension PairDeconstruction<T> on KtPair<T, T> {
  /// Converts this pair into a list.
  @useResult
  KtList<T> toList() => KtList.from([first, second]);
}

/// Represents a triad of values
///
/// There is no meaning attached to values in this class, it can be used for any purpose.
/// Triple exhibits value semantics, i.e. two triples are equal if all three components are equal.
///
/// @param A type of the first value.
/// @param B type of the second value.
/// @param C type of the third value.
/// @property first First value.
/// @property second Second value.
/// @property third Third value.
class KtTriple<A, B, C> {
  const KtTriple(this.first, this.second, this.third);

  final A first;
  final B second;
  final C third;

  @override
  String toString() => "($first, $second, $third)";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KtTriple &&
          runtimeType == other.runtimeType &&
          first == other.first &&
          second == other.second &&
          third == other.third;

  @override
  int get hashCode => first.hashCode ^ second.hashCode ^ third.hashCode;
}

extension TripleDeconstruction<T> on KtTriple<T, T, T> {
  /// Returns string representation of the [KtTriple] including its [first], [second] and [third] values.
  @useResult
  KtList<T> toList() => KtList.from([first, second, third]);
}
