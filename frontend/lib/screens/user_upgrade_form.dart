import 'package:flutter/material.dart';

import '../widgets/nav_button_simple.dart';

class UserUpgradeFormScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Upgrade Form')),
      body: Center(
        child:  NavigationButton(
          routeName: '/feed',
          buttonText: 'Go to Feed',
        ),
      ),
    );
  }
}

