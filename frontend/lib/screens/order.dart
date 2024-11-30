import 'package:flutter/material.dart';

import '../utils/routes.dart';

import '../widgets/nav_button_simple.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Order')),
      body: Center(
        child: NavigationButton(
          routeName: Routes.feed,
          buttonText: 'Go to Feed',
        ),
      ),
    );
  }
}