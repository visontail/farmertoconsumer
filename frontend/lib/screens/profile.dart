import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/custom_app_bar.dart';
import '../widgets/upgrade_section.dart';
import '../widgets/order_section.dart';
import '../widgets/product_section.dart';

class ProfileScreen extends StatefulWidget {
  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  final String userId = '6';
  final String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NiwiaWF0IjoxNzMyMDQ4MTY5fQ.X7Zfqx6MbHyDAOucSGjJ9r5pDnot0D5f4-mAOJBmM5o';
  //final String userId = '2';
  //final String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNzMyNTI1MjQ5fQ.CtgMkPZz9d66vQHmvTk66jJXtLAcYEfrMwxjGZv1os4';
  //final String userId = '5';
  //final String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiaWF0IjoxNzMyNTI1NjMxfQ.4JK2-zTkqICtoyTnPTk22hT8sSdxPed7vIbEWk2XPQA';


  final Color customGreen = Color(0xFF48872B);

  String userName = "John Doe";
  List<dynamic> currentPurchases = [];
  List<dynamic> purchaseHistory = [];
  List<dynamic> orders = [];
  List<dynamic> products = [];

  bool isLoading = true;

  bool isProducer = false; // Initial state: upgrade not requested
  bool hasPendingUserUpgradeRequest = false;

  // Function to update the upgrade request status
  void updateUpgradeRequestStatus(bool status) {
    setState(() {
      isProducer = status;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchUser(this.userId, this.token); // Fetch orders when the screen is initialized
    _fetchPurchases(this.userId, this.token, this.isProducer ? 'producer' : 'customer'); // Fetch orders when the screen is initialized
  }

  // Fetch orders from the API and store it
  Future<void> _fetchProducts(producerId, token) async {
    print('Fetching products...');

    // Construct the URL for fetching user data by ID
    var url = Uri.parse('http://10.0.2.2:3000/products?producerId=$userId'); // Replace 6 with dynamic user ID if needed

    try {
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });


      if (response.statusCode == 200) {

        var _products = [];
        final data = json.decode(response.body);
        for (var i = 0; i < data["products"].length; i++) {
          var prod = data["products"][i];
          _products.add(prod);
        }
        setState(() {
          products = _products;
        });

        print('_products');
        print(_products);

      } else {
        // Handle failure (non-200 response)
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      print('Error fetching user: $e');
    }    
  }

  // Fetch orders from the API and store it
  Future<void> _fetchOrders(userId, token) async {
    // TODO
  }

  // Fetch user from the API and store it
  Future<void> _fetchUserUpgradeRequest(userId, token) async {
    // TODO
    print('Fetching user data upgrade request...');

    // Construct the URL for fetching user data by ID
    var url = Uri.parse('http://10.0.2.2:3000/user-upgrade-requests?userId=$userId'); // Replace 6 with dynamic user ID if needed

    try {
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });


      final data = json.decode(response.body);
      print('-----userId');
      print(userId);
      print('-----data');
      print(data);
      if (response.statusCode == 200) {

        for (var i = 0; i < data["userUpgradeRequests"].length; i++) {
          var userUpgradeRequest = data["userUpgradeRequests"][i];
          if(userUpgradeRequest["approved"] == null) {
            setState(() {
              hasPendingUserUpgradeRequest = true;
            });
            break;
          }
        }

      } else {
        // Handle failure (non-200 response)
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      print('Error fetching user: $e');
    }    

  }

  // Fetch user from the API and store it
  Future<bool> _fetchUser(userId, token) async {
    print('Fetching user data...');

    // Construct the URL for fetching user data by ID
    var url = Uri.parse('http://10.0.2.2:3000/users/$userId'); // Replace 6 with dynamic user ID if needed

    bool _isProducer = false; 

    try {
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });

      final data = json.decode(response.body);
      print('-data--------------');
      print(data);
      if (response.statusCode == 200) {

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
          this._fetchUserUpgradeRequest(userId, "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTEsImlhdCI6MTczMjA5Njk2MX0.qwb27xKI6XtMAIbjZIneRHeDMWyCK2NrKIAaq1uMifQ");
        } else {
          this.updateUpgradeRequestStatus(true);
          _isProducer = true;
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

    print('_isProducer');
    print(_isProducer);

    if(_isProducer) {
      _fetchOrders(this.userId, this.token); // Fetch orders when the screen is initialized
      _fetchProducts(this.userId, this.token); // Fetch orders when the screen is initialized
    }


    return _isProducer;    
  }


  // Fetch orders from the API and store them in both lists
  Future<void> _fetchPurchases(userId, token, userType) async {
    print('fetching purchases...');
    var url = Uri.parse('http://10.0.2.2:3000/orders?userId=$userId&userType=$userType');
    //String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NiwiaWF0IjoxNzMyMDQ4MTY5fQ.X7Zfqx6MbHyDAOucSGjJ9r5pDnot0D5f4-mAOJBmM5o';

    try {
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });

      final data = json.decode(response.body);
      print('data');
      print(data);
      if (response.statusCode == 200) {
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
            labelColor: customGreen,
            unselectedLabelColor: Colors.black,
            indicatorColor: customGreen,
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
                        OrderSection(title: "Purchases", orders: currentPurchases, customGreen: customGreen),
                        OrderSection(title: "Purchase History", orders: purchaseHistory, customGreen: customGreen),
                        OrderSection(title: "Orders", orders: orders, customGreen: customGreen),
                        ProductSection(title: "Product Management", products: products, customGreen: customGreen),
                      ] :
                      [
                        OrderSection(title: "Purchases", orders: currentPurchases, customGreen: customGreen),
                        OrderSection(title: "Purchase History", orders: purchaseHistory, customGreen: customGreen),
                      ],
                  ),
          ),
        ],
      ),
    );
  }
}
