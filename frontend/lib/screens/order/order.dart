import 'package:farmertoconsumer/widgets/custom_app_bar.dart';
import 'package:farmertoconsumer/styles/colors.dart';
import 'package:farmertoconsumer/models/order.dart'; // assuming QuantityUnit is in this file
import 'package:farmertoconsumer/screens/order/order_data_provider.dart';
import 'package:farmertoconsumer/screens/profile/profile.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderScreen extends StatefulWidget {
  final String orderId;
  const OrderScreen({super.key, required this.orderId});

  @override
  OrderScreenState createState() => OrderScreenState();
}

class OrderScreenState extends State<OrderScreen> {
  final dataProvider = OrderDataProvider();

  bool isOrderConfirmed = false;
  bool isRelevantProducer = false;//true;

  Order? order; // We will store the fetched order here


  @override
  void initState() {
    super.initState();
    Future<Order?> future_order = dataProvider.fetchOrderDetails(widget.orderId);
    future_order.then((Order? order) {
      if (order != null) {
        // Successfully retrieved the order
        print('Order retrieved: $order');
        setState(() {
          this.order = order;
        });
        if(order.approved != null) {
          setState(() {
            this.isOrderConfirmed = true;            
          });
        } else {
          setState(() {
            this.isRelevantProducer = dataProvider.isRelevantProducer(order);
          });
        }
      } else {
        // Handle case when the order is null
        print('No order found');
      }
    }).catchError((e) {
      // Handle any error that occurred during the fetch
      print('Error fetching order: $e');
    });

  }


  Future<void> replyToOrder(id, approve) async {
    String token = dataProvider.getToken();
    bool _approve = approve;
    var data = {
      'approve': approve
    };
    // Send the POST request
    try {
      var response = await http.post(
        Uri.parse('http://10.0.2.2:3000/orders/$id/reply'),
        body: json.encode(data),  // Convert the data to JSON
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',  // Set the Content-Type header
        },
      );

      // Check the response status code
      if (response.statusCode == 200) {
        print('Request successful');
        setState(() {
          isOrderConfirmed = _approve;
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreen()),
        );
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (order == null) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    String title = isRelevantProducer && !isOrderConfirmed ? 'Confirm Order' : 'Your order summary';

    int? orderId = order?.id ?? null;
    String productName = order?.product?.name ?? ''; // Product name
    String productCategory = order?.product?.category?.name ?? ''; // Product category
    String quantityUnit = order?.product?.quantityUnit?.name ?? '';
    int q = order?.quantity ?? 1;
    String quantity = q.toString() + ' ' + quantityUnit; // Order quantity
    String status = order?.approved == null ? 'Pending' : (order?.approved == true ? 'Approved' : 'Declined');
    int p = order?.price ?? 0;
    String price = (p * q).toString() + ' Ft'; // Order price
    String unitPrice = p.toString() + ' Ft/' + quantityUnit; // Order price
    String imgSrc = 'assets/images/product.jpg'; // Placeholder image source

    return Scaffold(
      backgroundColor: mainGreen,
      appBar: CustomAppBar(title: title, color: mainGreen),
      body: Container(
        padding: const EdgeInsets.all(6.0),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(color: mainGreen, width: 5.0),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 12),
            Text(
              'Order ID - ${orderId}',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: mainGreen,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 6),
            // Add Image below the Order ID and align to the left
            Row(
              children: [
                Image.asset(imgSrc, height: 100),
              ],
            ),
            SizedBox(height: 12),
            // Conditional Rendering Based on Producer Status
            Row(
              children: [
                // First column takes up 50% of the space
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${productName}', style: TextStyle(fontWeight: FontWeight.bold, color: mainGreen)),
                      Text('${productCategory}', style: TextStyle(color: mainGreen)),
                      Text('Quantity: ${quantity}', style: TextStyle(color: mainGreen)),
                    ],
                  ),
                ),
                
                // Second column takes up 50% of the space
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('\$${price}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: mainGreen)),
                      Text('\$${unitPrice}', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: mainGreen)),
                    ],
                  ),
                ),
              ],
            ),
            if (!isRelevantProducer || isOrderConfirmed) ...[
              // When isRelevantProducer is false (Customer view)
              SizedBox(height: 12),
              Text(
                'Order Status: ${status}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: mainGreen),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12),
              Column(
                children: [
                  Text('Producer: John Producer', style: TextStyle(fontWeight: FontWeight.bold, color: mainGreen)),
                  Text('Contact: 123-456-7890', style: TextStyle(color: mainGreen)),
                ],
              ),
              SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Small Heading', style: TextStyle(fontWeight: FontWeight.bold, color: mainGreen)),
                    SizedBox(height: 6),
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam.',
                      style: TextStyle(color: loremIpsumColor),
                    ),
                  ],
                ),
              ),
            ] else ...[
              // When isRelevantProducer is true (Producer view)
              // Display the buyer's name and buttons
              SizedBox(height: 12),
              Text(
                'Buyer: ${order!.customer.name}',
                style: TextStyle(fontWeight: FontWeight.bold, color: mainGreen),
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Confirm button (Green with tick)
                  ElevatedButton.icon(
                    onPressed: () {replyToOrder(widget.orderId, true);},
                    icon: Icon(Icons.check, color: Colors.white),
                    label: Text('Confirm', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6),
                          topRight: Radius.circular(6),
                          bottomLeft: Radius.circular(6),
                          bottomRight: Radius.circular(6),
                        ),
                      ),
                      backgroundColor: mainGreen,
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    ),
                  ),
                  // Deny button (Red with X)
                  ElevatedButton.icon(
                    onPressed: () {replyToOrder(widget.orderId, false);},
                    icon: Icon(Icons.close, color: Colors.white),
                    label: Text('Deny', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(6),
                              topRight: Radius.circular(6),
                              bottomLeft: Radius.circular(6),
                              bottomRight: Radius.circular(6),
                            ),
                          ),
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
