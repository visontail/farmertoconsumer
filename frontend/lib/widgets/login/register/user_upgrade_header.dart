import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../styles/colors.dart';


class UserUpgradeHeader extends StatelessWidget {
  const UserUpgradeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 10),
        SvgPicture.asset(
          'assets/icons/icon.svg',
          width: 48,
          height: 48,
          color: mainGreen,
        ),
        const SizedBox(height: 5),
        Text(
          "Tell us who you are,",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: darkGreen,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          "so we can tailor your experience",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: paleGreen,
              ),
        ),
      ],
    );
  }
}
