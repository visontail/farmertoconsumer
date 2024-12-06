//import 'package:farmertoconsumer/models/product.dart';
//import 'package:farmertoconsumer/models/productCategory.dart';
//import 'package:farmertoconsumer/services/category_service.dart';
//import 'package:farmertoconsumer/services/product_service.dart';
import 'package:farmertoconsumer/storages/user_storage.dart';
import 'package:farmertoconsumer/models/authenticated_user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileDataProvider extends ChangeNotifier {
  final UserStorage _userStorage = UserStorage();
  int? userId = null;
  String? token = null;
  bool isProducer = false;

  ProfileDataProvider() {
    final AuthenticatedUser? _user = _userStorage.user.get() ?? null;
    final int? _userId = _user?.id ?? null;
    final String _token = _userStorage.token.get() ?? "";
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
    //setState(() {
    //  orders = _orders;
    //});
  }

  Future<void> _recieveUserUpgradeRequests(response) async {
    final data = json.decode(response.body);
    for (var i = 0; i < data["userUpgradeRequests"].length; i++) {
      var userUpgradeRequest = data["userUpgradeRequests"][i];
      if(userUpgradeRequest["approved"] == null) {
        //this.updateUpgradeRequestStatus(false, true);
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
    //setState(() {
    //  products = _products;
    //});
  }

  Future<void> _recieveUser(response) async {
    bool _isProducer = false; 
    final user = json.decode(response.body);

    String userName = user['name']; // Name of the user
    var producerData = user['producerData']; // producerData (could be null)

    // Check if producerData exists and handle accordingly
    String? producerDescription = producerData != null ? producerData['description'] : null;

    // If successful, update the state with the user data
    //setState(() {
    //  this.user = user;
    //  this.userName = userName; // Update userName
    //});

    if(producerData == null) {
      //this.updateUpgradeRequestStatus(false, hasPendingUserUpgradeRequest);
      await this._fetchUserUpgradeRequests(userId, token);
      //setState(() {
      //  subHeading = "Consumer Profile";
      //});
    } else {
      //this.updateUpgradeRequestStatus(true, hasPendingUserUpgradeRequest);
      _isProducer = true;
      //setState(() {
      //  subHeading = "Producer Profile";
      //});
    }

    await _fetchPurchases(this.userId, this.token, this.isProducer ? 'producer' : 'customer');
    if(_isProducer) {
      await _fetchOrders(this.userId, this.token); // Fetch orders when the screen is initialized
      await _fetchProducts(this.userId, this.token); // Fetch orders when the screen is initialized
    }

    //updateIsLoadingStatus(false);
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
    //setState(() {
    //  currentPurchases = current;
    //  purchaseHistory = history;
    //  isLoading = false; // Stop loading when data is fetched
    //});
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

}
