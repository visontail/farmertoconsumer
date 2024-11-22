import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // For loading SVG icons (if needed)
import '../widgets/custom_app_bar.dart';

class UpgradeFormScreen extends StatelessWidget {
  final Color customGreen = Color(0xFF48872B);  // Custom green color for button

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Become a Producer', customGreen: customGreen),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo at the top
            Center(
              child: SvgPicture.asset(
                'assets/icons/logo.svg', // Replace with the correct path to your logo
                width: 60.0,
                height: 60.0,
                color: customGreen,
              ),
            ),
            SizedBox(height: 20), // Space after logo

            // Heading with RichText
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black),
                  children: [
                    TextSpan(
                      text: 'Fill out the form, ',
                    ),
                    TextSpan(
                      text: '\nto become a ',
                      style: TextStyle(color: customGreen), // Make "producer" green
                    ),
                    TextSpan(
                      text: 'producer',
                      style: TextStyle(color: customGreen), // Make "producer" green
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30), // Space before the form

            // Form
            Expanded(
              child: ListView(
                children: [
                  // Message TextArea
                  TextFormField(
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: 'Message',
                      hintText: 'Message to our admins',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20), // Space between fields

                  // Contact Information TextField
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Contact Information',
                      hintText: 'Phone or business email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20), // Space between fields

                  // Description TextArea
                  TextFormField(
                    maxLines: 6,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      hintText: 'Detailed description about you as a producer and your products',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),

            // Get Started Button
            Align(
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF48872B), // Set the background color
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
                child: SizedBox(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle button click, e.g., form submission
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: customGreen, // Green background color
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6), // Rounded corners
                      ),
                      elevation: 4, // Adding box shadow
                    ),
                    child: Text(
                      'Get Started',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20), // Space after the button
          ],
        ),
      ),
    );
  }
}
