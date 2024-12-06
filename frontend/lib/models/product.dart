import 'package:farmertoconsumer/models/productCategory.dart';
import 'package:farmertoconsumer/models/quantityUnit.dart';
import 'package:farmertoconsumer/models/user.dart';

class Product {
  final int _id;
  final String _name;
  final int _price;
  final ProductCategory _category;
  final User _user;
  final int _quantity;
  final QuantityUnit _quantityUnit;
  final String _description;

  Product({
    required int id,
    required String name,
    required ProductCategory category,
    required int price,
    required QuantityUnit quantityUnit,
    required User user,
    required int quantity,
    required String description,
  })  : _id = id,
        _name = name,
        _category = category,
        _price = price,
        _quantityUnit = quantityUnit,
        _user = user,
        _quantity = quantity,
        _description = description;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      category: ProductCategory.fromJson(json['category']),
      price: json['price'],
      quantityUnit: QuantityUnit.fromJson(json['quantityUnit']),
      quantity: json['quantity'],
      user: User.fromJson(json['producer']),
        description: json['description'] ?? ""
    );
  }

  int get id => _id;
  String get name => _name;
  int get price => _price;
  ProductCategory get category => _category;
  User get user => _user;
  int get quantity => _quantity;
  QuantityUnit get quantityUnit => _quantityUnit;
  String get description => _description;
}
