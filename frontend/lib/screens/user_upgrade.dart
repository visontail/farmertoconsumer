import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/login/register/user_upgrade_header.dart';
import '../widgets/login/register/user_upgrade_role_button.dart';

import '../utils/routes.dart';
import '../styles/colors.dart';

class UserUpgradeScreen extends StatelessWidget {
  const UserUpgradeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: _buildAppBar(context),
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                  height: 70),
              const UserUpgradeHeader(),
              const SizedBox(height: 50),
              _buildRoleButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: white,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/back-arrow.svg',
          width: 24,
          height: 24,
          color: mainGreen,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  Widget _buildRoleButtons(BuildContext context) {
    return Row(
      children: [
        UserRoleButton(
          assetPath: 'assets/icons/profile.svg',
          title: "I'm a Foodie.",
          subtitle: "For those who savor the goodness.",
          onPressed: () {
            Navigator.of(context).pushNamed(Routes.feed);
          },
        ),
        UserRoleButton(
          assetPath: 'assets/icons/producer.svg',
          title: "I'm a Producer.",
          subtitle: "For those who grow/make the goodness.",
          onPressed: () {
            Navigator.of(context).pushNamed(Routes.userUpgradeForm);
          },
        ),
      ],
    );
  }
}
