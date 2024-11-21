import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/upgrade_section.dart';
import '../widgets/order_section.dart';
import 'next_page.dart';

class ConsumerProfileScreen extends StatelessWidget {
  final String userName = "John Doe";
  final List<String> currentOrders = ["Order 1", "Order 2", "Order 3"];
  final List<String> orderHistory = ["Order A", "Order B", "Order C"];
  final Color customGreen = Color(0xFF48872B);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Profile Page', customGreen: customGreen),
      body: Container(
        padding: const EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          border: Border.all(color: customGreen, width: 5.0),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              userName,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: customGreen,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12),
            UpgradeSection(),
            SizedBox(height: 12),
            _buildTabSection(currentOrders, orderHistory),
            SizedBox(height: 12),
            _buildNavigateButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTabSection(List<String> currentOrders, List<String> orderHistory) {
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
            child: TabBarView(
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

  Widget _buildNavigateButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: customGreen, // Set the background color
        borderRadius: BorderRadius.circular(6), // Set the border radius
        boxShadow: [
          BoxShadow(
            color: Color(0x55000000), // Shadow color with some opacity
            offset: Offset(0, 4), // Shadow position (X, Y)
            blurRadius: 4, // Shadow blur radius
            spreadRadius: 0, // Shadow spread
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NextPage()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent, // Make background transparent to show shadow
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6), // Set the border radius here
          ),
          elevation: 0, // Remove the default shadow to avoid double shadow
        ),
        child: Text(
          'Navigate to another page',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
