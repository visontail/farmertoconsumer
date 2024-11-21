import 'package:flutter/material.dart';

class UpgradeSection extends StatelessWidget {
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
            child: ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF48872B),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              icon: Icon(Icons.upload, color: Colors.white, size: 20.0),
              label: Text(
                'Upgrade',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
