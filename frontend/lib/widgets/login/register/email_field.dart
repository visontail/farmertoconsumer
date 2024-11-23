import 'package:flutter/material.dart';

import '../../../styles/colors.dart';

class EmailField extends StatelessWidget {
  final TextEditingController emailController;
  final FocusNode node;
  final ValueChanged<String> onChanged;

  const EmailField({
    Key? key,
    required this.emailController,
    required this.node,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: emailController,
      focusNode: node,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: "Email",
        border: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: mainGreen,
            width: 2.0,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: mainGreen,
            width: 3.0,
          ),
        ),
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }

  // Optional: Validate email format
  static bool isValidEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }
}
