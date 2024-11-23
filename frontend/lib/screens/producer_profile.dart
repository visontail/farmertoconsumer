import 'package:flutter/material.dart';

class ProducerProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Producer Profile')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/feed');
          },
          child: Text('Go to Feed'),
        ),
      ),
    );
  }
}