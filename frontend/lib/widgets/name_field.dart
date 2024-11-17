import 'package:flutter/material.dart';
import '../styles/colors.dart';

class NameField extends StatelessWidget {
  final bool fadeName;
  final TextEditingController nameController;
  final FocusNode node;
  final double bottomAnimationValue;
  final double opacityAnimationValue;
  final EdgeInsets paddingAnimationValue;
  final Color animationColor;

  final ValueChanged<String> onChanged;

  const NameField({
    super.key,
    required this.nameController,
    required this.fadeName,
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
        // Animation for the name field's opacity
        TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 300),
          tween: Tween(begin: 0, end: fadeName ? 0 : 1),
          builder: (_, value, __) => Opacity(
            opacity: value,
            child: TextFormField(
              controller: nameController,
              focusNode: node,
              decoration: const InputDecoration(hintText: "Name"),
              onChanged: onChanged,
            ),
          ),
        ),
        // Bottom progress indicator animation
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: fadeName ? 0 : 300,
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
        // Animated padding with check icon on the right
        Positioned.fill(
          child: AnimatedPadding(
            curve: Curves.easeIn,
            duration: const Duration(milliseconds: 500),
            padding: paddingAnimationValue,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: fadeName ? 0 : 1),
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
}
