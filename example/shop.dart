// ignore_for_file: type_annotate_public_apis
import "package:kt_dart/kt.dart";

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

KtSet<Product> getOrderedProducts(Customer customer) {
  return customer.orders.flatMap((it) => it.products).toSet();
}

KtList<KtTriple<Product, int, int>> getAllOrderedProducts(Shop shop) {
  return shop.customers
      .flatMap((it) => getOrderedProducts(it))
      .groupBy((it) => it)
      .mapValues((entry) => entry.value.count())
      .entries
      .map((entry) => KtTriple(
          entry.key, entry.value, (entry.value * entry.key.price).toInt()))
      .sortedByDescending<num>((entry) => entry.third);
}

class Shop {
  Shop(this.name, this.customers);

  final String name;
  final KtList<Customer> customers;
}

class Customer {
  Customer(this.name, this.city, this.orders);

  final String name;
  final City city;
  final KtList<Order> orders;

  @override
  String toString() => "$name from ${city.name}";
}

class Order {
  Order(this.products, {this.isDelivered});

  final KtList<Product> products;
  final bool isDelivered;
}

class Product {
  Product(this.name, this.price);

  final String name;
  final double price;

  @override
  String toString() => "$name for $price";
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
const lucas = "Lucas";
const cooper = "Cooper";
const nathan = "Nathan";
const reka = "Reka";
const bajram = "Bajram";
const asuka = "Asuka";
const riku = "Riku";

//cities
final canberra = City("Canberra");
final vancouver = City("Vancouver");
final budapest = City("Budapest");
final ankara = City("Ankara");
final tokyo = City("Tokyo");

Customer customer(String name, City city, [List<Order> orders = const []]) =>
    Customer(name, city, listFrom(orders));

Order order(List<Product> products, {bool delivered = true}) =>
    Order(listFrom(products), isDelivered: delivered);

Shop shop(String name, List<Customer> customers) =>
    Shop(name, listFrom(customers));

final jbShop = shop("jb test shop", [
  customer(lucas, canberra, [
    order([reSharper]),
    order([reSharper, dotMemory, dotTrace])
  ]),
  customer(cooper, canberra),
  customer(nathan, vancouver, [
    order([rubyMine, webStorm])
  ]),
  customer(reka, budapest, [
    order([idea], delivered: false),
    order([idea], delivered: false),
    order([idea])
  ]),
  customer(bajram, ankara, [
    order([reSharper])
  ]),
  customer(asuka, tokyo, [
    order([idea])
  ]),
  customer(riku, tokyo, [
    order([phpStorm, phpStorm]),
    order([phpStorm])
  ])
]);

final KtMap<String, Customer> jbCustomers =
    jbShop.customers.fold(hashMapFrom<String, Customer>(), (map, customer) {
  (map as KtMutableMap<String, Customer>)[customer.name] = customer;
  return map;
});

final orderedProducts =
    setOf(idea, reSharper, dotTrace, dotMemory, rubyMine, webStorm, phpStorm);

// TODO type inference bug https://github.com/dart-lang/sdk/issues/38755
//final sortedCustomers = listOf(cooper, nathan, bajram, asuka, lucas, riku, reka)
//    .map((it) => jbCustomers[it]);

//final groupedByCities = mapFrom({
//  canberra: listOf(lucas, cooper),
//  vancouver: listOf(nathan),
//  budapest: listOf(reka),
//  ankara: listOf(bajram),
//  tokyo: listOf(asuka, riku),
//}).mapValues((it) => it.value.map((name) => jbCustomers[name]));
