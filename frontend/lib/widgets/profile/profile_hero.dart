import 'package:farmertoconsumer/screens/profile/profile_user_upgrade.dart';
import 'package:flutter/material.dart';
import '../../styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Make sure you import flutter_svg
import 'package:http/http.dart' as http;
import 'dart:convert';

class UpgradeSection extends StatefulWidget {
  final dynamic user; // Accepting isProducer as a parameter
  final String token; // Accepting isProducer as a parameter
  final bool isProducer; // Accepting isProducer as a parameter
  final bool hasPendingUserUpgradeRequest;
  final Function(bool, bool) onUpgradeRequestChanged; // Callback to notify parent about the upgrade request

  // Constructor to accept the isProducer and onUpgradeRequestChanged
  UpgradeSection({
    required this.user,
    required this.token,
    required this.isProducer,
    required this.hasPendingUserUpgradeRequest,
    required this.onUpgradeRequestChanged,
  });

  @override
  _UpgradeSectionState createState() => _UpgradeSectionState();
}

class _UpgradeSectionState extends State<UpgradeSection> {
  bool _isLoading = false; // Tracks the loading state
  
  String initialDescription = 'My Description'; // TODO
  TextEditingController _descriptionController = TextEditingController();

  String initialUserEmail = 'valami@email.com'; // TODO
  TextEditingController _userEmailtextController = TextEditingController();

  bool contactInformationChanged = false;
  bool descriptionChanged = false;


  Future<void> saveDetails() async {
    var newContact = _userEmailtextController.text;
    var newDescription = _descriptionController.text;

    //String userId = '6';
    //String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NiwiaWF0IjoxNzMyMDQ4MTY5fQ.X7Zfqx6MbHyDAOucSGjJ9r5pDnot0D5f4-mAOJBmM5o';
    String userId = '1';
    String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzMzNDIwMTg0fQ._n1lBDUpNHjiDaHNN_T4LmoxWcq82EKMZ5w8e5owo2o';  
    //final String userId = '2';
    //final String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNzMzNDIxNjcxfQ.Jw8B7ABRfk0NyZGLOyPD7x9W9IZwHmgsWXzJfcDXLb0';  
    String apiUrl = 'http://10.0.2.2:3000/users/$userId/producerData'; // Replace with the correct API URL
     
    Map<String, dynamic> payload = {
      'contact': newContact,
      'description': newDescription,
    };

    try {
      // Send the POST request with the JSON payload
      final response = await http.patch(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json', // Specify the content type as JSON
        },
        body: json.encode(payload), // Encode the payload to JSON
      );

      Map<String, dynamic> data = json.decode(response.body);

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        // Handle the successful response
        setState(() {
          initialDescription = newDescription;
          initialUserEmail = newContact;
        });
        this._descriptionController.text = newDescription;
        this._userEmailtextController.text = newContact;
      } else {
        // Handle the error response
        this._descriptionController.text = this.initialDescription;
        this._userEmailtextController.text = this.initialUserEmail;
      }
    } catch (error) {
      print('Error updating Producer Data: $error');

    } finally {

    }
  }


  @override
  void initState() {
    super.initState();
    if(widget.user != null && widget.user['producerData'] != null) {
      if(widget.user['producerData']['contact'] != null) {
        this.initialUserEmail = widget.user['producerData']['contact'];
      }
      if(widget.user['producerData']['description'] != null) {
       this.initialDescription = widget.user['producerData']['description'];
      }
    }

    // Set the initial value
    _userEmailtextController.text = this.initialUserEmail;  // Initial value for TextField
    _userEmailtextController.addListener(() {
      var status = this.initialUserEmail != _userEmailtextController.text;
      setState(() {
        contactInformationChanged = status;
      });
    });

    _descriptionController.text = this.initialDescription;
    _descriptionController.addListener(() {
      var status = this.initialDescription != _descriptionController.text;
      setState(() {
        descriptionChanged = status;
      });
    });
  }

  @override
  void dispose() {
    // Dispose the controller when done to avoid memory leaks
    _userEmailtextController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return !widget.isProducer // Corrected this line to use widget.isProducer
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  !widget.isProducer ? "Upgrade to Producer" : "",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF48872B),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 0.0),
                  child: Text(
                    // Change the text based on the upgrade request status
                    widget.isProducer
                        ? ""
                        : (widget.hasPendingUserUpgradeRequest
                            ? "Your upgrade request has already been submitted and is waiting for approval."
                            : "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor."),
                    style: TextStyle(fontSize: 13, color: Colors.black),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: 0),
                // Show button only if upgrade request has not been made yet
                if (!widget.isProducer && !widget.hasPendingUserUpgradeRequest)
                  Align(
                    alignment: Alignment.centerRight,
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
                          onPressed: _isLoading
                              ? null // Disable the button while loading
                              : () {
                                  // Simulate loading state
                                  setState(() {
                                    _isLoading = true;
                                  });

                                  // Simulate a network call or action
                                  Future.delayed(Duration(seconds: 1), () {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                    //widget.onUpgradeRequestChanged(false, false); // Notify parent about the request
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              UpgradeFormScreen()),
                                    );
                                  });
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.transparent, // Make background transparent to show shadow
                            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6), // Set the border radius here
                            ),
                            elevation: 0, // Remove the default shadow to avoid double shadow
                          ),
                          child: _isLoading
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      width: 20, // Set the width of the spinner to make it smaller
                                      height: 20, // Set the height of the spinner to make it smaller
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(Colors.white),
                                        strokeWidth: 2, // You can adjust this as needed
                                      ),
                                    ),
                                    SizedBox(width: 10), // Space between the spinner and the text
                                    Text(
                                      'Upgrading...',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(width: 10), // Space between the icon and the text
                                    Text(
                                      'Upgrade',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(width: 16), // Space between the spinner and the text
                                    Icon(Icons.upload, color: Colors.white, size: 20.0),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          )
        : Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
  child: Container(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          blurRadius: 8,
          spreadRadius: 2,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label with SVG Icon and Save Button next to the label for Contact Information
        Container(
          height: 50.0,  // Set your desired height here
          child: Row(
            children: [
              Text(
                'Contact Information',
                style: TextStyle(color: mainGreen, fontSize: 12, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 8), // Space between the label and the icon
              contactInformationChanged ? SizedBox(height: 0) : 
              SvgPicture.asset(
                'assets/icons/edit.svg', // Replace with the actual icon path
                width: 16, // Set the width of the icon
                height: 16, // Set the height of the icon
                color: mainGreen, // Set the color of the icon to match the theme
              ),
              SizedBox(width: 8), // Space between the icon and the button
              !contactInformationChanged ? SizedBox(height: 0) : 
              TextButton(
                onPressed: saveDetails,
                style: TextButton.styleFrom(
                  backgroundColor: mainGreen, // Set the button's background color to green
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8), // Adjust padding for the button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Optional: Round the button corners
                  ),
                ),
                child: Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white, // Set the text color to white
                    fontSize: 12, // Font size of the text
                    fontWeight: FontWeight.bold, // Font weight of the text
                  ),
                ),
              ),
              SizedBox(width: 8), // Space between the icon and the button
              !contactInformationChanged ? SizedBox(height: 0) : 
              TextButton(
                onPressed: () {
                  // Save button logic here (e.g., save the contact information)
                  this._userEmailtextController.text = this.initialUserEmail;  // Initial value for TextField
                },
                style: TextButton.styleFrom(
                  backgroundColor: white, // Set the button's background color to green
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8), // Adjust padding for the button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Optional: Round the button corners
                  ),
                ),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: mainGreen, // Set the text color to white
                    fontSize: 12, // Font size of the text
                    fontWeight: FontWeight.bold, // Font weight of the text
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 0), // Space between label and input field
        TextField(
          controller: _userEmailtextController,
          style: TextStyle(color: mainGreen, fontSize: 14), // Smaller font size for input text
          decoration: InputDecoration(
            hintText: 'big.business.mari@gmail.com', // Placeholder for the input field
            hintStyle: TextStyle(color: lightGreen, fontSize: 12), // Smaller hint text
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: mainGreen),
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          ),
        ),
        SizedBox(height: 0), // Space between the text fields

        // Label with SVG Icon and Save Button next to the label for Description
        Container(
          height: 50.0,  // Set your desired height here
          child: Row(
            children: [
              Text(
                'Description',
                style: TextStyle(color: mainGreen, fontSize: 12, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 8), // Space between the label and the icon
              descriptionChanged ? SizedBox(height: 0) : 
              SvgPicture.asset(
                'assets/icons/edit.svg', // Replace with the actual icon path
                width: 16, // Set the width of the icon
                height: 16, // Set the height of the icon
                color: mainGreen, // Set the color of the icon to match the theme
              ),
              SizedBox(width: 8), // Space between the icon and the button
              !descriptionChanged ? SizedBox(height: 0) : 
              TextButton(
                onPressed: saveDetails,
                style: TextButton.styleFrom(
                  backgroundColor: mainGreen, // Set the button's background color to green
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8), // Adjust padding for the button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Optional: Round the button corners
                  ),
                ),
                child: Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white, // Set the text color to white
                    fontSize: 12, // Font size of the text
                    fontWeight: FontWeight.bold, // Font weight of the text
                  ),
                ),
              ),
              SizedBox(width: 8), // Space between the icon and the button
              !descriptionChanged ? SizedBox(height: 0) : 
              TextButton(
                onPressed: () {
                  // Save button logic here (e.g., save the contact information)
                  this._descriptionController.text = this.initialDescription;  // Initial value for TextField
                },
                style: TextButton.styleFrom(
                  backgroundColor: white, // Set the button's background color to green
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8), // Adjust padding for the button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Optional: Round the button corners
                  ),
                ),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: mainGreen, // Set the text color to white
                    fontSize: 12, // Font size of the text
                    fontWeight: FontWeight.bold, // Font weight of the text
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 0), // Space between label and input field
        TextFormField(
          controller: _descriptionController,
          maxLines: 3, // Makes this a multi-line field (textarea)
          style: TextStyle(color: mainGreen, fontSize: 14), // Smaller font size for input text
          decoration: InputDecoration(
            hintText: 'Describe your products and business here',
            hintStyle: TextStyle(color: lightGreen, fontSize: 12), // Smaller hint text
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: mainGreen),
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          ),
        ),
      ],
    ),
  ),
);


 // Return an empty widget if the condition is false
  }
}
