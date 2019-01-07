import 'package:dart_kollection/dart_kollection.dart';

void main() {
  final rekasProducts = getOrderedProducts(jbCustomers[reka]);
  print("reka bought $rekasProducts");

  final allOrdersOfJbShop = getAllOrderedProducts(jbShop);
  final formattedSales = allOrdersOfJbShop
      .map((it) => "Sold ${it.second}x '${it.first}', revenue ${it.third}\$")
      .joinToString(separator: "\n");
  print("total jbShop sales:\n$formattedSales");

  final revenue = allOrdersOfJbShop.map((it) => it.third).sum();
  print("total jbShop revenue $revenue\$");
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
      .map((entry) => KTriple(
          entry.key, entry.value, (entry.value * entry.key.price).toInt()))
      .sortedByDescending<num>((entry) => entry.third);
}

class Shop {
  Shop(this.name, this.customers);

  final String name;
  final KList<Customer> customers;
}

class Customer {
  Customer(this.name, this.city, this.orders);

  final String name;
  final City city;
  final KList<Order> orders;

  @override
  String toString() => '$name from ${city.name}';
}

class Order {
  Order(this.products, {this.isDelivered});

  final KList<Product> products;
  final bool isDelivered;
}

class Product {
  Product(this.name, this.price);

  final String name;
  final double price;

  @override
  String toString() => '$name for $price';
}

class City {
  City(this.name);

  final String name;

  @override
  String toString() => name;
}

//products
final idea = Product("IntelliJ IDEA Ultimate", 199.0);
final reSharper = Product("ReSharper", 149.0);
final dotTrace = Product("DotTrace", 159.0);
final dotMemory = Product("DotTrace", 129.0);
final dotCover = Product("DotCover", 99.0);
final appCode = Product("AppCode", 99.0);
final phpStorm = Product("PhpStorm", 99.0);
final pyCharm = Product("PyCharm", 99.0);
final rubyMine = Product("RubyMine", 99.0);
final webStorm = Product("WebStorm", 49.0);
final teamCity = Product("TeamCity", 299.0);
final youTrack = Product("YouTrack", 500.0);

//customers
final lucas = "Lucas";
final cooper = "Cooper";
final nathan = "Nathan";
final reka = "Reka";
final bajram = "Bajram";
final asuka = "Asuka";
final riku = "Riku";

//cities
final Canberra = City("Canberra");
final Vancouver = City("Vancouver");
final Budapest = City("Budapest");
final Ankara = City("Ankara");
final Tokyo = City("Tokyo");

Customer customer(String name, City city, [List<Order> orders = const []]) =>
    Customer(name, city, listFrom(orders));

Order order(List<Product> products, {bool delivered = true}) =>
    Order(listFrom(products), isDelivered: delivered);

Shop shop(String name, List<Customer> customers) =>
    Shop(name, listFrom(customers));

final jbShop = shop("jb test shop", [
  customer(lucas, Canberra, [
    order([reSharper]),
    order([reSharper, dotMemory, dotTrace])
  ]),
  customer(cooper, Canberra),
  customer(nathan, Vancouver, [
    order([rubyMine, webStorm])
  ]),
  customer(reka, Budapest, [
    order([idea], delivered: false),
    order([idea], delivered: false),
    order([idea])
  ]),
  customer(bajram, Ankara, [
    order([reSharper])
  ]),
  customer(asuka, Tokyo, [
    order([idea])
  ]),
  customer(riku, Tokyo, [
    order([phpStorm, phpStorm]),
    order([phpStorm])
  ])
]);

final KMap<String, Customer> jbCustomers =
    jbShop.customers.fold(hashMapFrom<String, Customer>(), (map, customer) {
  (map as KMutableMap<String, Customer>)[customer.name] = customer;
  return map;
});

final orderedProducts =
    setOf(idea, reSharper, dotTrace, dotMemory, rubyMine, webStorm, phpStorm);

final sortedCustomers = listOf(cooper, nathan, bajram, asuka, lucas, riku, reka)
    .map((it) => jbCustomers[it]);

final groupedByCities = mapFrom({
  Canberra: listOf(lucas, cooper),
  Vancouver: listOf(nathan),
  Budapest: listOf(reka),
  Ankara: listOf(bajram),
  Tokyo: listOf(asuka, riku),
}).mapValues((it) => it.value.map((name) => jbCustomers[name]));
