import 'package:flutter/material.dart';

import '../widgets/nav_button_simple.dart';

class ProducerProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Producer Profile')),
      body: Center(
        child:  NavigationButton(
          routeName: '/feed',
          buttonText: 'Go to Feed',
        ),
      ),
    );
  }
}