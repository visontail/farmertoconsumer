import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../screens/order/order.dart';
import '../order_card.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// OrderSection Widget: Now uses OrderCard
class OrderSection extends StatelessWidget {
  final String title;
  final List<dynamic> orders;
  final Color color;

  OrderSection({
    required this.title,
    required this.orders,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title
        SizedBox(height: 0),
        // Wrap the ListView in an Expanded widget to take the remaining space
        Expanded(
          child:  orders.isEmpty
              ? Padding(padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0), child: Text("You don't have any orders yet."))
              : ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    var order = orders[index];
                    return OrderCard(
                      order: order,
                      color: color,
                    );
                  },
                ),
          ),
      ],
    );
  }
}
