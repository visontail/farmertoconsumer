import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  final String routeName; // The route to navigate to
  final String buttonText; // The text to display on the button

  const NavigationButton({
    super.key,
    required this.routeName,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, routeName);
      },
      child: Text(buttonText),
    );
  }
}
