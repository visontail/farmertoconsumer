import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//import '../services/profile_service.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/upgrade_section.dart';
import '../widgets/order_section.dart';
import '../widgets/product_section.dart';
import '../styles/colors.dart';

class ProfileScreen extends StatefulWidget {
  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  bool isLoading = true;

  final String userId = '6';
  final String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NiwiaWF0IjoxNzMyMDQ4MTY5fQ.X7Zfqx6MbHyDAOucSGjJ9r5pDnot0D5f4-mAOJBmM5o';
  //final String userId = '2';
  //final String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNzMyNTI1MjQ5fQ.CtgMkPZz9d66vQHmvTk66jJXtLAcYEfrMwxjGZv1os4';
  //final String userId = '5';
  //final String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiaWF0IjoxNzMyNTI1NjMxfQ.4JK2-zTkqICtoyTnPTk22hT8sSdxPed7vIbEWk2XPQA';
  String userName = "John Doe";
  bool isProducer = false; // Initial state: upgrade not requested
  bool hasPendingUserUpgradeRequest = false;

  List<dynamic> currentPurchases = [];
  List<dynamic> purchaseHistory = [];
  List<dynamic> orders = [];
  List<dynamic> products = [];


  //final profileService = ProfileService();


  // Function to update the upgrade request status
  void updateUpgradeRequestStatus(bool status1, bool status2) {
    setState(() {
      isProducer = status1;
      hasPendingUserUpgradeRequest = status2;
    });
  }

  void updateIsLoadingStatus(bool status) {
    setState(() {
      isLoading = status;
    });
  }


  @override
  void initState() {
    super.initState();
    _fetchUser(this.userId, this.token); // Fetch orders when the screen is initialized
    _fetchPurchases(this.userId, this.token, this.isProducer ? 'producer' : 'customer'); // Fetch orders when the screen is initialized
  }


  Future<void> _fetchThings(url, token, callback) async {
    try {
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        callback(response);
      } else {
        // Handle failure (non-200 response)
        throw Exception('Failed to fetch');
      }
    } catch (e) {
      print('Error fetching: $e');
      updateIsLoadingStatus(false);
    }    

  }

  Future<void> _recieveOrders(response) async {
    var _orders = [];
    final data = json.decode(response.body);
    for (var i = 0; i < data["orders"].length; i++) {
      var prod = data["orders"][i];
      _orders.add(prod);
    }
    setState(() {
      orders = _orders;
    });
  }

  Future<void> _recieveUserUpgradeRequests(response) async {
    final data = json.decode(response.body);
    for (var i = 0; i < data["userUpgradeRequests"].length; i++) {
      var userUpgradeRequest = data["userUpgradeRequests"][i];
      if(userUpgradeRequest["approved"] == null) {
        this.updateUpgradeRequestStatus(false, true);
        break;
      }
    }
  }

  Future<void> _recieveProducts(response) async {
    var _products = [];
    final data = json.decode(response.body);
    for (var i = 0; i < data["products"].length; i++) {
      var prod = data["products"][i];
      _products.add(prod);
    }
    setState(() {
      products = _products;
    });
  }

  Future<void> _recieveUser(response) async {
    bool _isProducer = false; 
    final data = json.decode(response.body);

    // Extract user information from the response
    String userName = data['name']; // Name of the user
    String userEmail = data['email']; // Email of the user
    //int userId = data['id']; // ID of the user
    var producerData = data['producerData']; // producerData (could be null)

    // Check if producerData exists and handle accordingly
    String? producerDescription = producerData != null ? producerData['description'] : null;

    // If successful, update the state with the user data
    setState(() {
      this.userName = userName; // Update userName
      //this.userEmail = userEmail; // Update email (if you plan to use it)
      //this.producerDescription = producerDescription; // Update producer description if it exists
      //isLoading = false; // Stop loading after fetching user data
    });

    if(producerData == null) {
      this.updateUpgradeRequestStatus(false, hasPendingUserUpgradeRequest);
      this._fetchUserUpgradeRequests(userId, "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTEsImlhdCI6MTczMjA5Njk2MX0.qwb27xKI6XtMAIbjZIneRHeDMWyCK2NrKIAaq1uMifQ");
    } else {
      this.updateUpgradeRequestStatus(true, hasPendingUserUpgradeRequest);
      _isProducer = true;
    }

    if(_isProducer) {
      _fetchOrders(this.userId, this.token); // Fetch orders when the screen is initialized
      _fetchProducts(this.userId, this.token); // Fetch orders when the screen is initialized
    }
  }
  
  Future<void> _recievePurchases(response) async {
    final data = json.decode(response.body);
    //final data = json.decode(response.body);
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
      currentPurchases = current;
      purchaseHistory = history;
      isLoading = false; // Stop loading when data is fetched
    });
  }


  // Fetch orders from the API and store it
  Future<void> _fetchOrders(userId, token) async {
    var userType = isProducer ? "producer" : "customer";
    var url = Uri.parse('http://10.0.2.2:3000/orders?userId=$userId&userType=$userType'); // Replace 6 with dynamic user ID if needed
    _fetchThings(url, token, _recieveOrders);
  }

  // Fetch user from the API and store it
  Future<void> _fetchUserUpgradeRequests(userId, token) async {
    // Construct the URL for fetching user data by ID
    var url = Uri.parse('http://10.0.2.2:3000/user-upgrade-requests?userId=$userId'); // Replace 6 with dynamic user ID if needed
    _fetchThings(url, token, _recieveUserUpgradeRequests);
  }

  // Fetch user from the API and store it
  Future<void> _fetchUser(userId, token) async {
    // Construct the URL for fetching user data by ID
    var url = Uri.parse('http://10.0.2.2:3000/users/$userId'); // Replace 6 with dynamic user ID if needed
    _fetchThings(url, token, _recieveUser);
  }

  // Fetch products from the API and store it
  Future<void> _fetchProducts(producerId, token) async {
    // Construct the URL for fetching user data by ID
    var url = Uri.parse('http://10.0.2.2:3000/products?producerId=$userId'); // Replace 6 with dynamic user ID if needed
    _fetchThings(url, token, _recieveProducts);
  }

  // Fetch orders from the API and store them in both lists
  Future<void> _fetchPurchases(userId, token, userType) async {
    var url = Uri.parse('http://10.0.2.2:3000/orders?userId=$userId&userType=$userType');
    _fetchThings(url, token, _recievePurchases);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: mainGreen,
      appBar: CustomAppBar(title: 'Profile', color: mainGreen),
      body: Container(
        padding: const EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          border: Border.all(color: mainGreen, width: 5.0),
          borderRadius: BorderRadius.circular(12),
          color: white,
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
                color: mainGreen,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 6),
            Text(
              "Consumer Profile",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: mainGreen,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12),
            UpgradeSection(
              isProducer: this.isProducer,
              hasPendingUserUpgradeRequest: this.hasPendingUserUpgradeRequest,
              onUpgradeRequestChanged: updateUpgradeRequestStatus,
            ),
            SizedBox(height: 12),
            _buildTabSection(),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildTabSection() {
    return DefaultTabController(
      length: this.isProducer ? 4 : 2,
      child: Column(
        children: [
          TabBar(
            isScrollable: true, 
            labelColor: mainGreen,
            unselectedLabelColor: black,
            indicatorColor: mainGreen,
            tabs: this.isProducer ? [
              Tab(text: 'Purchases'),
              Tab(text: 'Purchase History'),
              Tab(text: 'Orders'),
              Tab(text: 'Product Management'),
            ] :
            [
              Tab(text: 'Purchases'),
              Tab(text: 'Purchase History'),
            ],
            labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold), 
          ),
          Container(
            height: this.isProducer ? 300 : 360,
            child: isLoading
                ? Center(child: CircularProgressIndicator()) // Show loading spinner while fetching
                : TabBarView(
                    children: this.isProducer ? 
                      [
                        OrderSection(title: "Purchases", orders: currentPurchases, color: mainGreen),
                        OrderSection(title: "Purchase History", orders: purchaseHistory, color: mainGreen),
                        OrderSection(title: "Orders", orders: orders, color: mainGreen),
                        ProductSection(title: "Product Management", products: products, color: mainGreen),
                      ] :
                      [
                        OrderSection(title: "Purchases", orders: currentPurchases, color: mainGreen),
                        OrderSection(title: "Purchase History", orders: purchaseHistory, color: mainGreen),
                      ],
                  ),
          ),
        ],
      ),
    );
  }
}
