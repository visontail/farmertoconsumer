import 'package:farmertoconsumer/models/productCategory.dart';

class Product {
  final int id;
  final String name;
  final ProductCategory category;
  final int price;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      category: ProductCategory.fromJson(json['category']),
      price: json['price']
    );
  }
}