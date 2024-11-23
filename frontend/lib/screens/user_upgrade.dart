import 'package:flutter/material.dart';

class UserUpgradeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Upgrade')),
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