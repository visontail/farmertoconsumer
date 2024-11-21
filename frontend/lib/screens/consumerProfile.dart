import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/custom_button.dart';

class ConsumerProfileScreen extends StatelessWidget {


  final String userName = "John Doe"; // Example user name
  final List<String> currentOrders = ["Order 1", "Order 2", "Order 3"];
  final List<String> orderHistory = ["Order A", "Order B", "Order C"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0), // Add padding around the content
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Center align the content
          children: [
            // User's name at the top
            Text(
              userName,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30), // Space between the name and the lists

            // Current Orders Section
            _buildOrderSection("Current Orders", currentOrders),

            SizedBox(height: 20), // Space between the sections

            // Order History Section
            _buildOrderSection("Order History", orderHistory),
          ],
        ),
      ),
    );
  }

  // Method to build each order section
  Widget _buildOrderSection(String title, List<String> orders) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Align the title to the left
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10), // Space between the title and the list
        Container(
          height: 150, // Limit the height of the list
          child: ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8),
                elevation: 4,
                child: ListTile(
                  title: Text(orders[index]),
                  leading: Icon(Icons.shopping_cart),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Handle item tap, e.g., navigate to order details
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

}

