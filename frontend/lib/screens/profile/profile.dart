import 'package:farmertoconsumer/screens/login.dart';
import 'package:farmertoconsumer/models/authenticated_user.dart';
import 'package:farmertoconsumer/widgets/custom_app_bar.dart';
import 'package:farmertoconsumer/widgets/profile/profile_hero.dart';
import 'package:farmertoconsumer/widgets/profile/profile_orders.dart';
import 'package:farmertoconsumer/widgets/profile/profile_products.dart';
import 'package:farmertoconsumer/styles/colors.dart';
import 'package:farmertoconsumer/storages/user_storage.dart';

import 'package:farmertoconsumer/screens/profile/profile_data_provider.dart';

import 'package:farmertoconsumer/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileScreen extends StatefulWidget {
  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  final dataProvider = ProfileDataProvider();

  final UserStorage _userStorage = UserStorage();

  bool isLoading = true;

  int? userId = null;
  String token = '';

  AuthenticatedUser? user = null;
  String userName = "";
  bool isProducer = false; // Initial state: upgrade not requested
  bool hasPendingUserUpgradeRequest = false;

  String subHeading = "Profile";

  List<dynamic> currentPurchases = [];
  List<dynamic> purchaseHistory = [];
  List<dynamic> orders = [];
  List<dynamic> products = [];


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
    
    final AuthenticatedUser? _user =_userStorage.user.get() ?? null;
    final int? _userId = _user?.id ?? null;
    final String _token = _userStorage.token.get() ?? "";

    setState(() {
      userId = _userId;
      token = _token;
    });

    //_loadData(this.userId, this.token);
    _loadData(_userId, _token);
  }

  Future<void> _loadData(userId, token) async {
    _fetchUser(this.userId, this.token); // Fetch user 
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
    final responseBody = json.decode(response.body);
    AuthenticatedUser? _user = AuthenticatedUser.fromJson(responseBody);

    String? _userName = user?.name; // Name of the user

    // Check if producerData exists and handle accordingly
    String? producerDescription = user?.producerData != null ? user?.producerData?.description : null;

    // If successful, update the state with the user data
    setState(() {
      user = _user;
      userName = _userName ?? ''; // Update userName
    });

    if(user?.producerData == null) {
      this.updateUpgradeRequestStatus(false, hasPendingUserUpgradeRequest);
      await this._fetchUserUpgradeRequests(userId, token);
      setState(() {
        subHeading = "Consumer Profile";
      });
    } else {
      this.updateUpgradeRequestStatus(true, hasPendingUserUpgradeRequest);
      _isProducer = true;
      setState(() {
        subHeading = "Producer Profile";
      });
    }

    await _fetchPurchases(this.userId, this.token);
    if(_isProducer) {
      await _fetchOrders(this.userId, this.token); // Fetch orders when the screen is initialized
      await _fetchProducts(this.userId, this.token); // Fetch orders when the screen is initialized
    }

    updateIsLoadingStatus(false);
  }
  
  Future<void> _recievePurchases(response) async {
    final data = json.decode(response.body);
    List<dynamic> orderData = data['orders'];

    List<dynamic> current = [];
    List<dynamic> history = [];

    for (var orderJson in orderData) {
      if (orderJson['approved'] == null) {
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
    var url = Uri.parse('http://10.0.2.2:3000/orders?userId=$userId&userType=producer'); // Replace 6 with dynamic user ID if needed
    _fetchThings(url, token, _recieveOrders);
  }

  // Fetch orders from the API and store them in both lists
  Future<void> _fetchPurchases(userId, token) async {
    var url = Uri.parse('http://10.0.2.2:3000/orders?userId=$userId&userType=customer');
    _fetchThings(url, token, _recievePurchases);
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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: mainGreen, // Change to 'mainGreen' if needed
      appBar: CustomAppBar(title: 'Profile', color: mainGreen), // Keep your custom AppBar
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height, // Ensure 100% minimum height
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
            decoration: BoxDecoration(
              border: Border.all(color: mainGreen, width: 5.0),
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: Stack(
              children: [
                // The rest of your existing content inside the container
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 6),
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
                      subHeading,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: mainGreen,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    this.user == null ? SizedBox(width: 360) : SizedBox(height: 0),
                    this.user == null ? SizedBox(height: 120) :
                    UpgradeSection(
                      user: this.user,
                      token: this.token,
                      isProducer: this.isProducer,
                      hasPendingUserUpgradeRequest: this.hasPendingUserUpgradeRequest,
                      onUpgradeRequestChanged: updateUpgradeRequestStatus,
                    ),
                    SizedBox(height: 0),
                    this.user == null ? CircularProgressIndicator() :
                    _buildTabSection(),
                    SizedBox(height: 12),
                  ],
                ),

                // Log out link in the top right corner
                Positioned(
                  top: 8,
                  right: 12,
                  child: GestureDetector(
                    onTap: () {
                      // Add log out functionality here
                      print('Log Out clicked');
                      _showConfirmationDialog(context);
                    },
                    child: Text(
                      'Log Out',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: mainGreen, // Make sure to use the appropriate color
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
            unselectedLabelColor: paleGreen,
            indicatorColor: loremIpsumColor,
            indicatorSize: TabBarIndicatorSize.tab,
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
            height: this.isProducer ? 340 : 360,
            child: isLoading
                ? Center(child: CircularProgressIndicator()) // Show loading spinner while fetching
                : TabBarView(
                    children: this.isProducer ? 
                      [
                        OrderSection(title: "Purchases", orders: currentPurchases, color: mainGreen),
                        OrderSection(title: "Purchase History", orders: purchaseHistory, color: mainGreen),
                        OrderSection(title: "Orders", orders: orders, color: mainGreen),
                        ProductSection(title: "Product Management", products: products, color: darkGreen),
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

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Log out?'),
          content: Text('Please confirm to log out.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                print('CANCEL');
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                // Handle the action to deny the request (e.g., delete or reject)
                print('LOG OUT');
                performLogout();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text('Log out'),
            ),
          ],
        );
      },
    );
  }

  void performLogout() {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      authProvider.logout();
  }

}
