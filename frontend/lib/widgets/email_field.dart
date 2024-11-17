import 'package:flutter/material.dart';

import '../styles/colors.dart';

class EmailField extends StatelessWidget {
  final bool fadeEmail;
  final TextEditingController emailController;
  final FocusNode node;
  final double bottomAnimationValue;
  final double opacityAnimationValue;
  final EdgeInsets paddingAnimationValue;
  final Color animationColor;

  final ValueChanged<String> onChanged;

  const EmailField({
    super.key,
    required this.emailController,
    required this.fadeEmail,
    required this.node,
    required this.bottomAnimationValue,
    required this.opacityAnimationValue,
    required this.paddingAnimationValue,
    required this.animationColor,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 300),
          tween: Tween(begin: 0, end: fadeEmail ? 0 : 1),
          builder: (_, value, __) => Opacity(
            opacity: value,
            child: TextFormField(
              controller: emailController,
              focusNode: node,
              decoration: const InputDecoration(hintText: "Email"),
              keyboardType: TextInputType.emailAddress,
              onChanged: onChanged,
            ),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: fadeEmail ? 0 : 300,
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: bottomAnimationValue),
                curve: Curves.easeIn,
                duration: const Duration(milliseconds: 500),
                builder: (context, value, child) => LinearProgressIndicator(
                  value: value,
                  backgroundColor: paleGreen,
                  color: mainGreen,
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: AnimatedPadding(
            curve: Curves.easeIn,
            duration: const Duration(milliseconds: 500),
            padding: paddingAnimationValue,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: fadeEmail ? 0 : 1),
              duration: const Duration(milliseconds: 700),
              builder: (context, value, child) => Opacity(
                opacity: value,
                child: Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0)
                        .copyWith(bottom: 0),
                    child: Icon(
                      Icons.check_rounded,
                      size: 27,
                      color: animationColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  static bool isValidEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }
}
