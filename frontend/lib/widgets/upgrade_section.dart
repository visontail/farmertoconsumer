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
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF48872B),
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
              style: TextStyle(fontSize: 16, color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: _isLoading
                  ? null // Disable the button while loading
                  : () {
                      // Simulate loading state
                      setState(() {
                        _isLoading = true;
                      });

                      // Simulate a network call or action
                      Future.delayed(Duration(seconds: 3), () {
                        setState(() {
                          _isLoading = false;
                        });
                      });
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF48872B),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6), // Set the border radius here
                ),
              ),
              child: _isLoading
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.upload, color: Colors.white, size: 20.0),
                        SizedBox(width: 10), // Space between the icon and the text
                        Text(
                          'Upgrade',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
