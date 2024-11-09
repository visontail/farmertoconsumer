import 'package:farmertoconsumer/services/auth_service.dart';
import 'package:farmertoconsumer/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import 'package:provider/provider.dart';


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
              print('Login: ${emailController.text} ${passwordController.text}');
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