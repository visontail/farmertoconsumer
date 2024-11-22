import 'package:farmertoconsumer/screens/upgrade_form.dart';
import 'package:flutter/material.dart';

class UpgradeSection extends StatefulWidget {
  @override
  _UpgradeSectionState createState() => _UpgradeSectionState();
}

class _UpgradeSectionState extends State<UpgradeSection> {
  bool _isLoading = false; // Tracks the loading state

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Upgrade to Producer",
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
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.",
              style: TextStyle(fontSize: 13, color: Colors.black),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(height: 20),
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => UpgradeFormScreen()),
                            );                        
                          });
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent, // Make background transparent to show shadow
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
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
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
    );
  }
}
