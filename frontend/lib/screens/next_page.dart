import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/custom_app_bar.dart';

class NextPage extends StatelessWidget {
  final Color customGreen = Color(0xFF48872B);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Next Page', color: customGreen),
      body: Center(
        child: Text("Welcome to the next page!"),
      ),
    );
  }
}
