import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../screens/order.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderSection extends StatelessWidget {
  final String title;
  final List<dynamic> orders;
  final Color color;
  
  OrderSection({
    required this.title, 
    required this.orders, 
    required this.color
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
          child: orders.length == 0 ? 
            Text("You don't have any orders yet.")
          : ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              // Extract order data
              var order = orders[index];
              var orderId = order['id'];
              var productName = order['product']['name']; // Product name
              var productCategory = order['product']['category']['name']; // Product category
              var quantity = order['quantity']; // Order quantity
              //var status = order['approved'] != null && order['approved'] 
              //             ? 'Approved' : 'In Progress'; // Order status
              var status = order['approved'] == null ? 'Pending' : (order['approved'] ? 'Approved' : 'Declined');
              var price = order['price']; // Order price
              var imgSrc = 'assets/images/product.jpg'; // TODO

              return GestureDetector(
                onTap: () {
                  // Navigate to NextPage when the card is tapped
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OrderScreen(orderId: orderId.toString())),
                  );
                },
                child: Card(
                  color: color,  // Green background for the card
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6), // Set the border radius here
                  ),
                  elevation: 0, // Remove the default elevation to use custom shadow
                  child: Container(
                    decoration: BoxDecoration(
                      color: color, // Keep the card background green
                      borderRadius: BorderRadius.circular(6), // Border radius same as card's
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x55000000), // Shadow color with opacity for a subtle effect
                          offset: Offset(0, 4), // Shadow position: x: 0, y: 4
                          blurRadius: 4, // Blur radius
                          spreadRadius: 0, // Spread radius
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      child: Row(
                        children: [
                          // Image and caption section (taking 60% of width)
                          Container(
                            width: MediaQuery.of(context).size.width * 0.45, // Set image to take 60% width
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(6), // Apply border radius to image
                                  child: Image.asset(
                                    imgSrc,
                                    width: double.infinity, // Make the image fill its container
                                    height: 100, // Set height of the image
                                    fit: BoxFit.cover, // Use BoxFit to adjust the image's aspect ratio
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  productName, // Display the product name
                                  style: TextStyle(fontSize: 12, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 0),
                          // Right-side info section (taking 40% of width)
                          Container(
                            width: MediaQuery.of(context).size.width * 0.3, // Set text section to take 40% width
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                // Display quantity and status
                                Center(
                                  child: Text(
                                    '$quantity',  // Display the quantity from order
                                    style: TextStyle(fontSize: 18, color: Colors.white),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    productCategory,  // Display product category
                                    style: TextStyle(fontSize: 12, color: Colors.white),
                                  ),
                                ),
                                SizedBox(height: 6),
                                Center(
                                  child: Text(
                                    status,  // Display the status ("In Progress" or "Approved")
                                    style: TextStyle(fontSize: 14, color: Colors.white),
                                  ),
                                ),
                                SizedBox(height: 0),
                                // Button positioned at the bottom-right corner
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: TextButton(
                                    onPressed: () {
                                      // Navigate to the next page when the button is clicked
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => OrderScreen(orderId: orderId.toString())),
                                      );
                                    },
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero, // No padding for the button
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6), // Set the border radius here
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
            },
          ),
        ),
      ],
    );
  }
}