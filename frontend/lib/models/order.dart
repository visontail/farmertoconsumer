import 'package:farmertoconsumer/models/product.dart';
import 'package:farmertoconsumer/models/quantityUnit.dart';
import 'package:farmertoconsumer/models/user.dart';

class Order {
  final int _id;
  final User _customer;
  final Product _product;
  final int _price;
  final int _quantity;
  final QuantityUnit _quantityUnit;
  final bool? _approved;

  Order({
    required int id,
    required User customer,
    required Product product,
    required int price,
    required int quantity,
    required QuantityUnit quantityUnit,
    bool? approved,
  })  : _id = id,
        _customer = customer,
        _product = product,
        _price = price,
        _quantity = quantity,
        _quantityUnit = quantityUnit,
        _approved = approved;

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      customer: User.fromJson(json['customer']),
      product: Product.fromJson(json['product']),
      price: json['price'],
      quantity: json['quantity'],
      quantityUnit: QuantityUnit.fromJson(json['quantityUnit']),
      approved: json['approved'] == null ? null : json['approved'] as bool,
    );
  }

  int get id => _id;
  User get customer => _customer;
  Product get product => _product;
  int get price => _price;
  int get quantity => _quantity;
  QuantityUnit get quantityUnit => _quantityUnit;
  bool? get approved => _approved;
}