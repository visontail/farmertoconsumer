import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/custom_app_bar.dart';
import '../widgets/upgrade_section.dart';
import '../widgets/order_section.dart';

class ConsumerProfileScreen extends StatefulWidget {
  @override
  _ConsumerProfileScreenState createState() => _ConsumerProfileScreenState();
}

class _ConsumerProfileScreenState extends State<ConsumerProfileScreen> {
  final String userId = '6';
  final String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NiwiaWF0IjoxNzMyMDQ4MTY5fQ.X7Zfqx6MbHyDAOucSGjJ9r5pDnot0D5f4-mAOJBmM5o';

  String userName = "John Doe";
  List<dynamic> currentOrders = [];
  List<dynamic> orderHistory = [];
  final Color customGreen = Color(0xFF48872B);
  bool isLoading = true;

  bool isUpgradeRequested = false; // Initial state: upgrade not requested

  // Function to update the upgrade request status
  void updateUpgradeRequestStatus(bool status) {
    setState(() {
      isUpgradeRequested = status;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchUser(this.userId, this.token); // Fetch orders when the screen is initialized
    _fetchOrders(this.userId, this.token, 'customer'); // Fetch orders when the screen is initialized
  }

  // Fetch iser from the API and store it
  Future<void> _fetchUser(userId, token) async {
    print('Fetching user data...');

    // Construct the URL for fetching user data by ID
    var url = Uri.parse('http://10.0.2.2:3000/users/$userId'); // Replace 6 with dynamic user ID if needed

    try {
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Extract user information from the response
        String userName = data['name']; // Name of the user
        String userEmail = data['email']; // Email of the user
        int userId = data['id']; // ID of the user
        var producerData = data['producerData']; // producerData (could be null)

        // Check if producerData exists and handle accordingly
        String? producerDescription = producerData != null ? producerData['description'] : null;

        // If successful, update the state with the user data
        setState(() {
          this.userName = userName; // Update userName
          //this.userEmail = userEmail; // Update email (if you plan to use it)
          //this.userId = userId; // Update userId (if needed)
          //this.producerDescription = producerDescription; // Update producer description if it exists
          //isLoading = false; // Stop loading after fetching user data
        });
        print('userName');
        print(userName);
        print('userEmail');
        print(userEmail);
        print('userId');
        print(userId);
        print('producerData');
        print(producerData);

        if(producerData == null) {
          this.updateUpgradeRequestStatus(false);
        } else {
          this.updateUpgradeRequestStatus(true);
        }

      } else {
        // Handle failure (non-200 response)
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      setState(() {
        isLoading = false; // Stop loading on error
      });
      print('Error fetching user: $e');
    }
  }


  // Fetch orders from the API and store them in both lists
  Future<void> _fetchOrders(userId, token, userType) async {
    print('fetching orders...');
    var url = Uri.parse('http://10.0.2.2:3000/orders?userId=$userId&userType=$userType');
    String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NiwiaWF0IjoxNzMyMDQ4MTY5fQ.X7Zfqx6MbHyDAOucSGjJ9r5pDnot0D5f4-mAOJBmM5o';

    try {
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<dynamic> orderData = data['orders'];

        // Split orders into current and history based on their approval status
        List<dynamic> current = [];
        List<dynamic> history = [];

        for (var orderJson in orderData) {
          if (orderJson['approved'] == null || !orderJson['approved']) {
            // If the order is not approved or doesn't have an approval status, consider it "current"
            current.add(orderJson);
          } else {
            // If the order is approved, consider it "order history"
            history.add(orderJson);
          }
        }
        setState(() {
          currentOrders = current;
          orderHistory = history;
          isLoading = false; // Stop loading when data is fetched
        });
      } else {
        throw Exception('Failed to load orders');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching orders: $e');
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: customGreen,
      appBar: CustomAppBar(title: 'Profile', customGreen: customGreen),
      body: Container(
        padding: const EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          border: Border.all(color: customGreen, width: 5.0),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 24),
            Text(
              userName,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: customGreen,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 6),
            Text(
              "Consumer Profile",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: customGreen,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            UpgradeSection(
              isUpgradeRequested: isUpgradeRequested,
              onUpgradeRequestChanged: updateUpgradeRequestStatus,
            ),
            SizedBox(height: 24),
            _buildTabSection(),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildTabSection() {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            labelColor: customGreen,
            unselectedLabelColor: Colors.black,
            indicatorColor: customGreen,
            tabs: [
              Tab(text: 'Current Orders'),
              Tab(text: 'Order History'),
            ],
          ),
          Container(
            height: 360,
            child: isLoading
                ? Center(child: CircularProgressIndicator()) // Show loading spinner while fetching
                : TabBarView(
                    children: [
                      OrderSection(title: "Current Orders", orders: currentOrders, customGreen: customGreen),
                      OrderSection(title: "Order History", orders: orderHistory, customGreen: customGreen),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
