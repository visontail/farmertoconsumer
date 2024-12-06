import 'package:farmertoconsumer/providers/auth_provider.dart';
import 'package:farmertoconsumer/styles/colors.dart';
import 'package:farmertoconsumer/utils/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/routes.dart';

import '../widgets/nav_button_simple.dart';

class ProducerProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Producer Profile')),
      body: Center(
          child: ElevatedButton(
              onPressed: () {
                // TEMP
                // will be removed when merging producer profile
                // and resolving conflicts
                Navigator.pop(context);
                authProvider.logout();
                showSnackBar(
                    context: context,
                    message: "Logged out. See you soon!",
                    backgroundColor: mainGreen);
              },
              child: const Text("Log out"))),
    );
  }
}
