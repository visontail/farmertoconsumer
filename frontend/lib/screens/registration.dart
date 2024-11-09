import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';


class RegistrationScreen extends StatelessWidget {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration Page'),
      ),
      body: Column(
        children: [
          CustomTextField(
            label: 'Email',
            controller: emailController,
          ),
          CustomTextField(
            label: 'Name',
            controller: nameController,
          ),
          CustomTextField(
            label: 'Password',
            controller: passwordController,
          ),
          CustomTextField(
            label: 'Confirm Password',
            controller: confirmPasswordController,
          ),
          CustomButton(
            text: 'Register',
            onPressed: () {
              print('Register: ${emailController.text} ${nameController.text} ${passwordController.text} ${confirmPasswordController.text}'); // debug log, remove in prod
              Provider.of<AuthService>(context, listen: false).register(
                emailController.text,
                nameController.text,
                passwordController.text,
                confirmPasswordController.text,
              );
              
            })
        ],
      )
    );
  }
}