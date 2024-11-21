import 'package:flutter/material.dart';

import '../styles/colors.dart';

class GetStartedButton extends StatelessWidget {
  final Function onTap;
  final Function onAnimationEnd;
  final double elementsOpacity;

  const GetStartedButton({
    super.key,
    required this.onTap,
    required this.onAnimationEnd,
    required this.elementsOpacity
    });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 300),
      tween: Tween(begin: 1, end: elementsOpacity),
      onEnd: () async {
        onAnimationEnd();
      },
      builder: (_, value, __) => GestureDetector(
        onTap: () {
          onTap();
        },
        child: Opacity(
          opacity: value,
          child: Container(
            width: 200,
            height: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: mainGreen,
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Get Started",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: white,
                      fontSize: 16),
                ),
                SizedBox(width: 15),
                Icon(
                  Icons.arrow_forward_rounded,
                  color: white,
                  size: 24,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
