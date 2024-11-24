import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import '../../../styles/colors.dart';

class WelcomeHeaderSection extends StatelessWidget {
  final String secondText;

  const WelcomeHeaderSection({
    Key? key,
    this.secondText = "Sign in to continue", // Default text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 60),
        SvgPicture.asset(
          'assets/icons/icon.svg',
          width: 48,
          height: 48,
          color: mainGreen,
        ),
        const SizedBox(height: 5),
        const Text(
          "Welcome,",
          style: TextStyle(color: darkGreen, fontSize: 35),
        ),
        Text(
          secondText, // Using the dynamic secondText value
          style: const TextStyle(
            color: paleGreen,
            fontSize: 25,
          ),
        ),
      ],
    );
  }
}
