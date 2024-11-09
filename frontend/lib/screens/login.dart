import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';


class LoginScreen extends StatelessWidget {
  
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Column(
        children: [
          CustomTextField(
            label: 'Email',
            controller: emailController,
          ),
          CustomTextField(
            label: 'Password',
            controller: passwordController,
          ),
          CustomButton(
            text: 'Login',
            onPressed: () {
              print('Login: ${emailController.text} ${passwordController.text}'); // debug log, remove in prod
              Provider.of<AuthService>(context, listen: false).login(
                emailController.text,
                passwordController.text,
              );
              
            })
        ],
      )
    );
  }
}