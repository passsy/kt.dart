import "package:kt_dart/kt.dart";
import "package:test/test.dart";

void main() {
  // https://github.com/passsy/kt.dart/issues/139
  test("issue #139", () {
    final usd = Currency(1, "USD");
    final inr = Currency(2, "INR");
    final KtList<Currency> currency = listOf(usd, inr);
    final KtList<CurrencyConversionData> conversion =
        listOf(CurrencyConversionData(1, 2));
    final KtMap<Currency, KtList<Currency>> conversions =
        _toCurrencyMap(conversion, currency);

    // CRASH HERE (type 'EmptyList<Currency>' is not a subtype of type 'KtMutableList<Currency>' of 'defaultValue')
    final result =
        conversions.getOrDefault(Currency(3, "EUR"), const KtList.empty());
    expect(result, emptyList());
  });
}

KtMap<Currency, KtList<Currency>> _toCurrencyMap(
    KtList<CurrencyConversionData> conversion, KtList<Currency> currency) {
  final KtMap<int, Currency> currencyMap =
      currency.associateBy((cur) => cur.id);
  return conversion.groupByTransform(
    (conv) => currencyMap.get(conv.fromRef)!,
    (conv) => currencyMap.get(conv.toRef)!,
  );
}

class Currency {
  final int id;
  final String ticker;

  Currency(this.id, this.ticker);
}

class CurrencyConversionData {
  final int fromRef;
  final int toRef;

  CurrencyConversionData(this.fromRef, this.toRef);
}
