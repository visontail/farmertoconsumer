import 'package:flutter/material.dart';

import '../../../styles/colors.dart';

class PasswordField extends StatelessWidget {
  final String hintText;
  final bool obscure;
  final TextEditingController passwordController;
  final FocusNode node;
  final Function(String) onPasswordChanged;
  final Function() onToggleObscure;
  final InputBorder border;
  final InputBorder focusedBorder;

  const PasswordField({
    required this.hintText,
    required this.obscure,
    required this.passwordController,
    required this.node,
    required this.onPasswordChanged,
    required this.onToggleObscure,
    required this.border,
    required this.focusedBorder,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: passwordController,
      obscureText: obscure,
      focusNode: node,
      onChanged: onPasswordChanged,
      decoration: InputDecoration(
        hintText: "Password",
        suffixIcon: IconButton(
          icon: Icon(
            obscure ? Icons.visibility_off : Icons.visibility,
            color: mainGreen,
          ),
          onPressed: onToggleObscure,
        ),
        border: border,
        focusedBorder: focusedBorder,
      ),
    );
  }
}

