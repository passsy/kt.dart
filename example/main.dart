import 'package:dart_kollection/dart_kollection.dart';

import 'shop.dart';

main() {
  final rekasPrducts = getOrderedProducts(jbCustomers[reka]);
  print("reka bought $rekasPrducts");

  final allOrdersOfJbShop = getAllOrderedProducts(jbShop);
  var formattedSales = allOrdersOfJbShop
      .map((it) => "Sold ${it.second}x '${it.first}', revenue ${it.third}\$")
      .joinToString(separator: "\n");
  print("total jbShop sales:\n${formattedSales}");

  final revenue = allOrdersOfJbShop.map((it) => it.third).sum();
  print("total jbShop revenue ${revenue}\$");
}

KSet<Product> getOrderedProducts(Customer customer) {
  return customer.orders.flatMap((it) => it.products).toSet();
}

KList<KTriple<Product, int, int>> getAllOrderedProducts(Shop shop) {
  return shop.customers
      .flatMap((it) => getOrderedProducts(it))
      .groupBy((it) => it)
      .mapValues((entry) => entry.value.count())
      .entries
      .map((entry) => KTriple(entry.key, entry.value, (entry.value * entry.key.price).toInt()))
      .sortedByDescending<num>((entry) => entry.third);
}
