import 'package:flutter/material.dart';

import '../../../styles/colors.dart';

class ConfirmPassField extends StatelessWidget {
  final TextEditingController confirmPasswordController;
  final FocusNode node;
  final bool obscure;
  final Function() onToggleObscure;
  final Function(String) onPasswordChanged;
  final InputBorder border;
  final InputBorder focusedBorder;

  const ConfirmPassField({
    required this.confirmPasswordController,
    required this.node,
    required this.obscure,
    required this.onToggleObscure,
    required this.onPasswordChanged,
    required this.border,
    required this.focusedBorder,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: confirmPasswordController,
      obscureText: obscure,
      focusNode: node,
      onChanged: onPasswordChanged,
      decoration: InputDecoration(
        hintText: "Confirm Password",
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
