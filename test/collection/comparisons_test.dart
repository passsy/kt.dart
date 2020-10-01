import 'package:kt_dart/collection.dart';
import 'package:test/test.dart';

void main() {
  group('compare in natural order', () {
    test('naturalOrder', () {
      final list = listOf(3, 4, 5, 2, 1);
      final natural = list.sortedWith(naturalOrder());
      expect(natural, listOf(1, 2, 3, 4, 5));
    });
  });

  group('compare reversed order', () {
    test('reverseOrder', () {
      final list = listOf(3, 4, 5, 2, 1);
      final natural = list.sortedWith(reverseOrder());
      expect(natural, listOf(5, 4, 3, 2, 1));
    });
  });

  group('reverse custom comparator', () {
    test('reverse natural', () {
      final list = listOf(3, 4, 5, 2, 1);
      final reversedNatural = list.sortedWith(reverse(naturalOrder()));
      expect(reversedNatural, listOf(5, 4, 3, 2, 1));
    });
  });
}
