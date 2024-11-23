import 'package:flutter/material.dart';

import '../widgets/nav_button_simple.dart';

class ConsumerProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Consumer Profile')),
      body: Center(
        child:  NavigationButton(
          routeName: '/feed',
          buttonText: 'Go to Feed',
        ),
      ),
    );
  }
}