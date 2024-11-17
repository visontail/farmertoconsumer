import 'package:flutter/material.dart';
import '../styles/colors.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController passwordController;
  final bool fadePassword;
  final bool obscure;
  final FocusNode node;
  final double bottomAnimationValue;
  final double opacityAnimationValue;
  final ValueChanged<bool> onToggleObscure;
  final ValueChanged<String> onPasswordChanged;
  final String hintText; // Add hintText parameter

  const PasswordField({
    super.key,
    required this.passwordController,
    required this.fadePassword,
    required this.obscure,
    required this.node,
    required this.bottomAnimationValue,
    required this.opacityAnimationValue,
    required this.onToggleObscure,
    required this.onPasswordChanged,
    required this.hintText, // Initialize hintText
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 300),
          tween: Tween(begin: 0, end: fadePassword ? 0 : 1),
          builder: ((_, value, __) => Opacity(
                opacity: value,
                child: TextFormField(
                  controller: passwordController,
                  focusNode: node,
                  decoration: InputDecoration(hintText: hintText), // Use hintText here
                  obscureText: obscure,
                  onChanged: onPasswordChanged,
                ),
              )),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: fadePassword ? 0 : 300,
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: bottomAnimationValue),
                curve: Curves.easeIn,
                duration: const Duration(milliseconds: 500),
                builder: ((context, value, child) => LinearProgressIndicator(
                      value: value,
                      backgroundColor: paleGreen,
                      color: mainGreen,
                    )),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: TweenAnimationBuilder<double>(
            tween: Tween(
                begin: 0,
                end: opacityAnimationValue == 0
                    ? 0
                    : fadePassword
                        ? 0
                        : 1),
            duration: const Duration(milliseconds: 700),
            builder: ((context, value, child) => Opacity(
                  opacity: value,
                  child: Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0)
                          .copyWith(bottom: 0),
                      child: GestureDetector(
                        onTap: () => onToggleObscure(!obscure),
                        child: Icon(
                          obscure ? Icons.visibility : Icons.visibility_off,
                          size: 27,
                          color: paleGreen,
                        ),
                      ),
                    ),
                  ),
                )),
          ),
        )
      ],
    );
  }
}
