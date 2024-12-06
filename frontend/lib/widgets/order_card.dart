import 'package:farmertoconsumer/screens/order/order.dart';
import 'package:farmertoconsumer/models/order.dart';
import 'package:farmertoconsumer/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    child: Stack(
      children: [
        // Main Card content
        Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Color(0x55000000),
                offset: Offset(0, 4),
                blurRadius: 4,
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              children: [
                // Left side: Image and caption
                Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.asset(
                          imgSrc, // Image path
                          width: double.infinity,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        productName,
                        style: TextStyle(fontSize: 12, color: white),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 0),
                // Right side: Information section (now centered horizontally, aligned to top vertically)
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: 125,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start, // Align items to the top
                    crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
                    children: [
                      Text(
                        '$quantity',
                        style: TextStyle(fontSize: 14, color: white),
                      ),
                      Text(
                        productCategory,
                        style: TextStyle(fontSize: 12, color: white),
                      ),
                      SizedBox(height: 6),
                      Text(
                        price,
                        style: TextStyle(fontSize: 14, color: white),
                      ),
                      SizedBox(height: 0),
                      Text(
                        unitPrice,
                        style: TextStyle(fontSize: 10, color: white),
                      ),
                      SizedBox(height: 6),
                      Text(
                        status,
                        //style: TextStyle(fontSize: 16, color: status == 'Declined' ? red : (status == 'Approved' ? paleGreen : white)),
                        style: TextStyle(fontSize: 16, color: white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // Positioned Edit Button (Bottom-right)
        Positioned(
          bottom: -4, // Adjusted position for closer placement
          right: 16,
          child: TextButton(
            onPressed: () {
              // Handle View Details button click
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
                  style: TextStyle(fontSize: 12, color: white),
                ),
                SizedBox(width: 8),
                SvgPicture.asset(
                  'assets/icons/right-arrow-2.svg',
                  width: 8.0,
                  height: 8.0,
                  color: white,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);

  }
}