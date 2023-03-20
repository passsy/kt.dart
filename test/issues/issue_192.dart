import 'package:kt_dart/kt.dart';
import 'package:test/test.dart';

void main() {
  // https://github.com/passsy/kt.dart/issues/192
  group('issue #192', () {
    test('mapNotNull', () {
      final KtList<String> resultA = listOf("not null")
          .mapNotNull((it) => it.startsWith("not") ? it : null); // error!!
      final KtList<String> resultB = listOf("not null", null)
          .mapNotNull((it) => it?.startsWith("not") == true ? it : null);
      expect(resultA, resultB);
    });

    test('mapIndexedNotNull', () {
      final KtList<String> resultA = listOf("not null")
          .mapIndexedNotNull((_, it) => it.startsWith("not") ? it : null);
      final KtList<String> resultB = listOf("not null", null).mapIndexedNotNull(
          (_, it) => it?.startsWith("not") == true ? it : null);
      expect(resultA, resultB);
    });

    test('mapNotNullTo', () {
      final results = mutableListOf<String>();
      listOf("not null")
          .mapNotNullTo(results, (it) => it.startsWith("not") ? it : null);
      listOf("not null", null).mapNotNullTo(
          results, (it) => (it?.startsWith("not") ?? false) ? it : null);
      expect(results, listOf("not null", "not null"));
    });

    test('mapIndexedNotNullTo', () {
      final results = mutableListOf<String>();
      final KtMutableList<String> resultA = listOf("not null")
          .mapIndexedNotNullTo(
              results, (_, it) => it.startsWith("not") ? it : null);
      final KtMutableList<String> resultB = listOf("not null", null)
          .mapIndexedNotNullTo(
              results, (_, it) => (it?.startsWith("not") ?? false) ? it : null);
      expect(results, listOf("not null", "not null"));
      expect(resultA, resultB);
    });

    test('filterNotNull', () {
      final KtList<String> noNullsA = listOf("not null").filterNotNull();
      final KtList<String> noNullsB = listOf("not null", null).filterNotNull();
      expect(noNullsA, noNullsB);
    });

    test('filterNotNullTo', () {
      final results = mutableListOf<String>();
      listOf("not null").filterNotNullTo(results);
      listOf("not null", null).filterNotNullTo(results);
      expect(results, listOf("not null", "not null"));
    });
    test('filterNotNullTo', () {
      // KtList
      final KtList<String> resultList = listOf("not null").requireNoNulls();
      expect(resultList, listOf("not null"));
      expect(() => listOf("not null", null).requireNoNulls(),
          throwsA(isA<ArgumentError>()));

      // KtIterable
      final KtIterable<String> resultSet = setOf("not null").requireNoNulls();
      expect(resultSet.toSet(), setOf("not null"));
      expect(() => setOf("not null", null).requireNoNulls(),
          throwsA(isA<ArgumentError>()));
    });
  });
}
