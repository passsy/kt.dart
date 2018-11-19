/**
 * Represents a generic pair of two values.
 *
 * There is no meaning attached to values in this class, it can be used for any purpose.
 * Pair exhibits value semantics, i.e. two pairs are equal if both components are equal.
 *
 * @param A type of the first value.
 * @param B type of the second value.
 * @property first First value.
 * @property second Second value.
 */
class KPair<A, B> {
  KPair(this.first, this.second);
  final A first;
  final B second;

  @override
  String toString() => "($first, $second)";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KPair && runtimeType == other.runtimeType && first == other.first && second == other.second;

  @override
  int get hashCode => first.hashCode ^ second.hashCode;
}

/**
 * Represents a triad of values
 *
 * There is no meaning attached to values in this class, it can be used for any purpose.
 * Triple exhibits value semantics, i.e. two triples are equal if all three components are equal.
 *
 * @param A type of the first value.
 * @param B type of the second value.
 * @param C type of the third value.
 * @property first First value.
 * @property second Second value.
 * @property third Third value.
 */
class KTriple<A, B, C> {
  KTriple(this.first, this.second, this.third);
  final A first;
  final B second;
  final C third;

  @override
  String toString() => "($first, $second, $third)";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KTriple &&
          runtimeType == other.runtimeType &&
          first == other.first &&
          second == other.second &&
          third == other.third;

  @override
  int get hashCode => first.hashCode ^ second.hashCode ^ third.hashCode;
}
