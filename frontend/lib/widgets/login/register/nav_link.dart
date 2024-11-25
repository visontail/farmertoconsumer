import 'package:flutter/material.dart';

import '../../../styles/colors.dart';

class NavLink extends StatelessWidget {
  final String label;
  final String route;

  const NavLink({
    Key? key,
    required this.label,
    required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, route);
        },
        child: Text(
          label,
          style: const TextStyle(
            color: mainGreen,
            fontSize: 12,
            decoration: TextDecoration.underline,
            decorationColor: mainGreen
          ),
        ),
      ),
    );
  }
}
