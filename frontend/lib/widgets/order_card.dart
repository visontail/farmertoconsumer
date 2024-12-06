import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../screens/order/order.dart';
import '../models/order.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// OrderCard Widget: Extracted from OrderSection
class OrderCard extends StatelessWidget {
  final Order? order;
  final Color color;

  OrderCard({
    required this.order,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    int? orderId = order?.id ?? null;
    String productName = order?.product?.name ?? ''; // Product name
    String productCategory = order?.product?.category?.name ?? ''; // Product category
    String quantityUnit = order?.product?.quantityUnit?.name ?? '';
    int q = order?.quantity ?? 1;
    String quantity = q.toString() + ' ' + quantityUnit; // Order quantity
    String status = order?.approved == null ? 'Pending' : (order?.approved == true ? 'Approved' : 'Declined');
    double p = order?.price ?? 0;
    String price = (p * q).toString() + ' Ft'; // Order price
    String unitPrice = p.toString() + ' Ft/' + quantityUnit; // Order price
    String imgSrc = 'assets/images/product.jpg'; // Placeholder image source

    return GestureDetector(
      onTap: () {
        // Navigate to OrderScreen when tapped
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OrderScreen(orderId: orderId.toString())),
        );
      },
      child: Card(
        color: color,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        elevation: 0,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Color(0x55000000),
                offset: Offset(0, 4),
                blurRadius: 4,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              children: [
                // Image and caption section (60% width)
                Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.asset(
                          imgSrc,
                          width: double.infinity,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        productName,
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 0),
                // Right-side info section (40% width)
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Center(
                        child: Text(
                          '$quantity',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ),
                      Center(
                        child: Text(
                          productCategory,
                          style: TextStyle(fontSize: 10, color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 6),
                      Center(
                        child: Text(
                          price,
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 0),
                      Center(
                        child: Text(
                          unitPrice,
                          style: TextStyle(fontSize: 10, color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 6),
                      Center(
                        child: Text(
                          status,
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 0),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => OrderScreen(orderId: orderId.toString())),
                            );
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'View Details',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              SvgPicture.asset(
                                'assets/icons/right-arrow-2.svg',
                                width: 10.0,
                                height: 10.0,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}