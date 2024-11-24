import 'package:flutter/material.dart';

import '../widgets/nav_button_simple.dart';

import '../utils/routes.dart';

class ProductUploadScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product Upload')),
      body: Center(
        child:  NavigationButton(
          routeName: Routes.feed,
          buttonText: 'Go to Feed',
        ),
      ),
    );
  }
}