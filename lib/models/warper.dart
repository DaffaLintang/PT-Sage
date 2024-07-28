import 'package:pt_sage/models/customer.dart';
import 'package:pt_sage/models/product.dart';

class DataWrapper {
  final List<Customers> customers;
  final List<Product> products;

  DataWrapper({required this.customers, required this.products});

  factory DataWrapper.fromJson(Map<String, dynamic> json) {
    var customersList = json['customers'] as List;
    var productsList = json['products'] as List;

    List<Customers> customers =
        customersList.map((i) => Customers.fromJson(i)).toList();
    List<Product> products =
        productsList.map((i) => Product.fromJson(i)).toList();

    return DataWrapper(customers: customers, products: products);
  }

  Map<String, dynamic> toJson() {
    return {
      'customers': customers.map((customer) => customer.toJson()).toList(),
      'products': products.map((product) => product.toJson()).toList(),
    };
  }
}
