import 'package:farmertoconsumer/screens/upgrade_form.dart';
import 'package:flutter/material.dart';
import '../styles/colors.dart';

class UpgradeSection extends StatefulWidget {
  final bool isProducer; // Accepting isProducer as a parameter
  final bool hasPendingUserUpgradeRequest;
  final Function(bool, bool) onUpgradeRequestChanged; // Callback to notify parent about the upgrade request

  // Constructor to accept the isProducer and onUpgradeRequestChanged
  UpgradeSection({
    required this.isProducer,
    required this.hasPendingUserUpgradeRequest,
    required this.onUpgradeRequestChanged,
  });

  @override
  _UpgradeSectionState createState() => _UpgradeSectionState();
}

class _UpgradeSectionState extends State<UpgradeSection> {
  bool _isLoading = false; // Tracks the loading state
  
  String contact_information = 'Some Contact Information';

  String description = 'My Description';
  TextEditingController _descriptionController = TextEditingController();

  String userEmail = 'valami@email.com';
  TextEditingController _userEmailtextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Set the initial value
    _userEmailtextController.text = this.userEmail;  // Initial value for TextField
    _userEmailtextController.addListener(() {
      print("Email value: ${_userEmailtextController.text}");
    });

    _descriptionController.text = this.description;
    _descriptionController.addListener(() {
      print("Description value: ${_descriptionController.text}");
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
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: EdgeInsets.all(16),
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
                // Contact Information Text Field
                TextField(
                  controller: _userEmailtextController,  
                  style: TextStyle(color: mainGreen),  // Set text (value) color to green
                  decoration: InputDecoration(
                    labelText: 'Contact Information',
                    labelStyle: TextStyle(color: mainGreen),  // Set label text color to green
                    hintText: 'big.business.mari@gmail.com',  // Placeholder for the input field
                    hintStyle: TextStyle(color: lightGreen),   // Set hint text (placeholder) color to green
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: mainGreen),  // Set outline color when focused
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  ),
                ),
                SizedBox(height: 16), // Space between the text fields

                // Description Text Area (multi-line input field)
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 3,  // Makes this a multi-line field (textarea)
                  decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: TextStyle(color: mainGreen),  // Set label text color to green
                    hintText: 'Describe your products and business here',
                    hintStyle: TextStyle(color: lightGreen),   // Set hint text (placeholder) color to green
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: mainGreen),  // Set outline color when focused
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  ),
                  style: TextStyle(color: mainGreen),  // Set the text color to green
                ),
              ],
            ),
          ),
        );
 // Return an empty widget if the condition is false
  }
}
