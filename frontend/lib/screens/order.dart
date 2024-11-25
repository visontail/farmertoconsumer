import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/custom_app_bar.dart';
import '../widgets/upgrade_section.dart';
import '../widgets/order_section.dart';
import '../widgets/product_section.dart';

class OrderScreen extends StatefulWidget {
  @override
  OrderScreenState createState() => OrderScreenState();
}

class OrderScreenState extends State<OrderScreen> {
  final String userId = '6';
  final String token = 'your-token-here';

  final Color customGreen = Color(0xFF48872B);
  final Color loremIpsumColor = Color(0xFF39542C);

  String userName = "John Doe";
  String buyerName = "Buyer Name"; // Add a buyer name for producer
  List<dynamic> currentPurchases = [];
  List<dynamic> purchaseHistory = [];
  List<dynamic> orders = [];
  List<dynamic> products = [];

  bool isLoading = true;
  bool isProducer = false;

  @override
  void initState() {
    super.initState();
    _fetchUser(this.userId, this.token);
    _fetchPurchases(this.userId, this.token, this.isProducer ? 'producer' : 'customer');
  }

  Future<void> _fetchProducts(producerId, token) async {
    var url = Uri.parse('http://10.0.2.2:3000/products?producerId=$userId');
    try {
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          products = data['products'];
        });
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  Future<void> _fetchPurchases(userId, token, userType) async {
    var url = Uri.parse('http://10.0.2.2:3000/orders?userId=$userId&userType=$userType');
    try {
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          currentPurchases = data['orders'];
        });
      } else {
        throw Exception('Failed to load orders');
      }
    } catch (e) {
      print('Error fetching orders: $e');
    }
  }

  Future<void> _fetchUser(userId, token) async {
    var url = Uri.parse('http://10.0.2.2:3000/users/$userId');
    try {
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          userName = data['name'];
          isProducer = data['producerData'] != null;
        });
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      print('Error fetching user: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var title = isProducer ? 'Confirm Order' : 'Your order summary';

    return Scaffold(
      backgroundColor: customGreen,
      appBar: CustomAppBar(title: title, customGreen: customGreen),
      body: Container(
        padding: const EdgeInsets.all(6.0),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(color: customGreen, width: 5.0),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 12),
            Text(
              'Order ID - 100009',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: customGreen,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 6),
            // Add Image below the Order ID and align to the left
            Row(
              children: [
                Image.asset('assets/images/product.jpg', height: 100),
              ],
            ),
            SizedBox(height: 12),
            // Conditional Rendering Based on Producer Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Product Title', style: TextStyle(fontWeight: FontWeight.bold, color: customGreen)),
                    Text('Product Type', style: TextStyle(color: customGreen)),
                    Text('Quantity: 1', style: TextStyle(color: customGreen)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('\$100.00', style: TextStyle(fontWeight: FontWeight.bold, color: customGreen)),
                  ],
                ),
              ],
            ),
            if (!isProducer) ...[
              // When isProducer is false (Customer view)
              SizedBox(height: 12),
              Text(
                'Order Status: Pending',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: customGreen),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12),
              Column(
                children: [
                  Text('Producer: John Producer', style: TextStyle(fontWeight: FontWeight.bold, color: customGreen)),
                  Text('Contact: 123-456-7890', style: TextStyle(color: customGreen)),
                ],
              ),
              SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Small Heading', style: TextStyle(fontWeight: FontWeight.bold, color: customGreen)),
                    SizedBox(height: 6),
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam.',
                      style: TextStyle(color: loremIpsumColor),
                    ),
                  ],
                ),
              ),
            ] else ...[
              // When isProducer is true (Producer view)
              // Display the buyer's name and buttons
              SizedBox(height: 12),
              Text(
                'Buyer: $buyerName',
                style: TextStyle(fontWeight: FontWeight.bold, color: customGreen),
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Confirm button (Green with tick)
                  ElevatedButton.icon(
                    onPressed: () {},
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
                      backgroundColor: customGreen,
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    ),
                  ),
                  // Deny button (Red with X)
                  ElevatedButton.icon(
                    onPressed: () {},
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
