import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // For loading SVG icons (if needed)
import '../../widgets/custom_app_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'profile.dart';
import '../../widgets/profile/animated_button.dart'; // Import the AnimatedButton widget
import '../../styles/colors.dart';

class UpgradeFormScreen extends StatefulWidget {
  @override
  _UpgradeFormScreenState createState() => _UpgradeFormScreenState();
}

class _UpgradeFormScreenState extends State<UpgradeFormScreen> {
  // Create a global key to identify the Form widget
  final _formKey = GlobalKey<FormState>();

  // Controllers for the form fields to access and validate their values
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // Variable to track loading state
  bool _isLoading = false;

  // Fetch orders from the API and store them in both lists
  Future<void> _submitUserUpgradeForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true; // Show loading indicator
      });

      // Gather the user input from the controllers
      String message = _messageController.text.trim();
      String contactInformation = _contactController.text.trim();
      String description = _descriptionController.text.trim();

      // Prepare the payload as a JSON object
      Map<String, dynamic> payload = {
        'description': message,
        'contact': contactInformation
      };

      // Specify the API endpoint
      String apiUrl = 'http://10.0.2.2:3000/user-upgrade-requests'; // Replace with the correct API URL
      String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NiwiaWF0IjoxNzMyMDQ4MTY5fQ.X7Zfqx6MbHyDAOucSGjJ9r5pDnot0D5f4-mAOJBmM5o';
      //String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzMzNDIwMTg0fQ._n1lBDUpNHjiDaHNN_T4LmoxWcq82EKMZ5w8e5owo2o';  
      //String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNzMzNDIxNjcxfQ.Jw8B7ABRfk0NyZGLOyPD7x9W9IZwHmgsWXzJfcDXLb0';  


      try {
        // Send the POST request with the JSON payload
        final response = await http.post(
          Uri.parse(apiUrl),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json', // Specify the content type as JSON
          },
          body: json.encode(payload), // Encode the payload to JSON
        );

        print('response.body');
        print(response.body);
        Map<String, dynamic> data = json.decode(response.body);

        // Check if the request was successful (status code 200)
        if (response.statusCode == 200) {
          // Handle the successful response
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text('Success'),
              content: Text('Your upgrade request was submitted successfully.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // Optionally, navigate to another screen
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          );
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfileScreen()),
          );
        } else {
          // Handle the error response
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text('Error'),
              content: Text('Failed to submit user upgrade: ${data['message']}'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          );
        }
      } catch (error) {
        // Handle any error during the request (e.g., no internet connection)
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Error'),
            content: Text('Error submitting upgrade form: $error'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      } finally {
        setState(() {
          _isLoading = false; // Hide loading indicator
        });
      }
    } else {
      // Form is not valid
      print('Please fill out all required fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Become a Producer', color: mainGreen),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 75),
        child: Form(
          key: _formKey, // Set the form key for validation
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo at the top
              SvgPicture.asset(
                'assets/icons/logo.svg', // Replace with the correct path to your logo
                width: 60.0,
                height: 60.0,
                color: mainGreen,
              ),
              SizedBox(height: 20), // Space after logo

              // Heading with RichText
              RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black),
                  children: [
                    TextSpan(
                      text: 'Fill out the form, ',
                    ),
                    TextSpan(
                      text: '\nto become a ',
                      style: TextStyle(color: mainGreen), // Make "producer" green
                    ),
                    TextSpan(
                      text: 'producer',
                      style: TextStyle(color: mainGreen), // Make "producer" green
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20), // Space before the form

              // Form
              Expanded(
                child: ListView(
                  children: [
                    // Message TextArea
                    TextFormField(
                      controller: _messageController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        labelText: 'Message*',
                        hintText: 'Message to our admins',
                        border: OutlineInputBorder(),
                      ),
                      // Validator to make this field required
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a message';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20), // Space between fields

                    // Contact Information TextField
                    TextFormField(
                      controller: _contactController,
                      decoration: InputDecoration(
                        labelText: 'Contact Information*',
                        hintText: 'Phone or business email',
                        border: OutlineInputBorder(),
                      ),
                      // Validator to make this field required
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your contact information';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20), // Space between fields

                    // Description TextArea
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        hintText: 'Detailed description about you as a producer and your products',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),

              // Replace the existing button with AnimatedButton
              AnimatedButton(
                text: 'Get Started',
                isLoading: _isLoading,
                onPressed: _submitUserUpgradeForm,
              ),
              SizedBox(height: 0), // Space after the button
            ],
          ),
        ),
      ),
    );
  }
}
