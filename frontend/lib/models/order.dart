import 'package:farmertoconsumer/models/user.dart';
import 'package:farmertoconsumer/models/product.dart';
import 'package:farmertoconsumer/models/quantityUnit.dart';

class Order {
  final int id;
  final User user; // Replacing Customer with User
  final Product product;
  final int quantity;
  final QuantityUnit quantityUnit;
  final double price;
  final bool? approved;

  Order({
    required this.id,
    required this.user, // Updated to use the User model
    required this.product,
    required this.quantity,
    required this.quantityUnit,
    required this.price,
    this.approved,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      user: User.fromJson(json['customer']), // Map 'customer' to User
      product: Product.fromJson(json['product']),
      quantity: json['quantity'],
      quantityUnit: QuantityUnit.fromJson(json['quantityUnit']),
      price: json['price'].toDouble(),
      approved: json['approved'],
    );
  }
}
