import 'package:flutter/material.dart';

class ProductManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product Management')),
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