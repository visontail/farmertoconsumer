import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import flutter_svg package

class ConsumerProfileScreen extends StatelessWidget {
  final String userName = "John Doe"; // Example user name
  final List<String> currentOrders = ["Order 1", "Order 2", "Order 3"];
  final List<String> orderHistory = ["Order A", "Order B", "Order C"];

  // Define the custom green color
  final Color customGreen = Color(0xFF48872B); // Hexadecimal color #48872B

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // AppBar customizations
        backgroundColor: customGreen, // Use the custom green color
        toolbarHeight: 40.0, // Height of the AppBar
        title: const Text(
          'Profile Page',
          style: TextStyle(
            fontSize: 16.0, // You can adjust the title font size if necessary
            fontWeight: FontWeight.bold,
            color: Colors.white, // White text color for the title
          ),
        ),
        centerTitle: true, // Center the title
        actions: [
          // Logo on the right side (SVG logo)
          Padding(
            padding: const EdgeInsets.all(8.0), // Padding around the logo
            child: SvgPicture.asset(
              'assets/icons/logo.svg', // Path to your SVG logo file
              width: 20.0,
              height: 20.0,
              color: Colors.white, // Ensure the logo color is white
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(
          top: 40.0,   // 40px padding on top
          left: 6.0,   // 6px padding on the left side
          right: 6.0,  // 6px padding on the right side
          bottom: 6.0, // 6px padding on the bottom
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: customGreen, // Use the custom green color for the border
            width: 5.0, // Thickness of the border
          ),
          borderRadius: BorderRadius.circular(12), // Optional: rounded corners
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Center align the content
          children: [
            // User's name at the top
            Text(
              userName,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: customGreen, // Apply custom green to the user's name
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
            color: customGreen, // Apply custom green to the section title
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
                  title: Text(
                    orders[index],
                    style: TextStyle(color: customGreen), // Apply custom green to the text
                  ),
                  leading: Icon(Icons.shopping_cart, color: customGreen), // Use green icon
                  trailing: Icon(Icons.arrow_forward_ios, color: customGreen), // Use green icon
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
