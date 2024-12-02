import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/custom_app_bar.dart';
import '../widgets/profile/profile_hero.dart';
import '../widgets/profile/profile_orders.dart';
import '../widgets/profile/profile_products.dart';
import '../styles/colors.dart';
import '../models/order.dart'; // assuming QuantityUnit is in this file
import '../models/product.dart'; // assuming Product is defined in this file
import '../models/quantityUnit.dart'; // assuming QuantityUnit is in this file
import '../models/user.dart'; // using the new User model
import '../models/producerData.dart'; // assuming ProducerData is in this file
import '../models/productCategory.dart'; // assuming ProductCategory is in this file

class OrderScreen extends StatefulWidget {
  final String orderId;
  const OrderScreen({super.key, required this.orderId});

  @override
  OrderScreenState createState() => OrderScreenState();
}

class OrderScreenState extends State<OrderScreen> {
  bool isOrderConfirmed = false;

  // TODO
  //final String userId = '5';
  //final String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiaWF0IjoxNzMyNTI1NjMxfQ.4JK2-zTkqICtoyTnPTk22hT8sSdxPed7vIbEWk2XPQA';
  final String userId = '6';
  final String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NiwiaWF0IjoxNzMyMDQ4MTY5fQ.X7Zfqx6MbHyDAOucSGjJ9r5pDnot0D5f4-mAOJBmM5o';
  bool isRelevantProducer = true;

  final String productImage = 'assets/images/product.jpg';

  Order? order; // We will store the fetched order here

  @override
  void initState() {
    super.initState();
    fetchOrderDetails(widget.orderId);
  }

  // Fetch order details from the backend
  Future<void> fetchOrderDetails(id) async {
    print('id');
    print(id);
    final response = await http.get(
      Uri.parse('http://10.0.2.2:3000/orders/$id'), // Update URL with actual endpoint
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

      final body = json.decode(response.body);
      print('body');
      print(body);
      print('response.statusCodes');
      print(response.statusCode);

    if (response.statusCode == 200) {
      print('******TEST----1');
      final data = json.decode(response.body);
      print('******TEST----2');
      final _order = Order.fromJson(data);
      print('******TEST----3');
      setState(() {
        order = _order;
      });
      print('******TEST----4');
      if(_order.approved != null) {
        setState(() {
          isOrderConfirmed = true;
        });
      }
    } else {
      throw Exception('Failed to load order');
    }
    print('VALAMI____________________');
  }

  Future<void> replyToOrder(id, approve) async {
    var data = {
      'approve': approve
    };
  // Send the POST request
  var _approve = approve;
  try {
    var response = await http.post(
      Uri.parse('http://10.0.2.2:3000/orders/$id/reply'),
      body: json.encode(data),  // Convert the data to JSON
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',  // Set the Content-Type header
      },
    );

    var responseData = json.decode(response.body);  // Decode JSON if needed
    print('responseData');
    print(responseData);

    // Check the response status code
    if (response.statusCode == 200) {
      print('Request successful');
      setState(() {
        isOrderConfirmed = _approve;
      });
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

    var title = isRelevantProducer && !isOrderConfirmed ? 'Confirm Order' : 'Your order summary';

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
              'Order ID - ${order!.id}',
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
                Image.asset(productImage, height: 100),
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
                      Text('${order!.product.name}', style: TextStyle(fontWeight: FontWeight.bold, color: mainGreen)),
                      Text('${order!.product.category.name}', style: TextStyle(color: mainGreen)),
                      Text('Quantity: ${order!.quantity}', style: TextStyle(color: mainGreen)),
                    ],
                  ),
                ),
                
                // Second column takes up 50% of the space
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('\$${order!.price}', style: TextStyle(fontWeight: FontWeight.bold, color: mainGreen)),
                    ],
                  ),
                ),
              ],
            ),
            if (!isRelevantProducer || isOrderConfirmed) ...[
              // When isRelevantProducer is false (Customer view)
              SizedBox(height: 12),
              Text(
                'Order Status: ${order!.approved == null ? "pending" : (order!.approved == true ? "Approved" : "Declined")}',
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
                'Buyer: ${order!.user.name}',
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
