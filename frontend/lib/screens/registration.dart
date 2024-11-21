import 'package:farmertoconsumer/widgets/name_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';

import '../styles/colors.dart';
import '../widgets/email_field.dart';
import '../widgets/get_started_button.dart';
import '../widgets/pass_field.dart';

class RegistrationScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPasswordNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                        height: 60), // To make sure every content is centered
                    SvgPicture.asset(
                      'assets/icons/icon.svg', // Make sure the path matches exactly
                      width: 48,
                      height: 48,
                      color: mainGreen,
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "Welcome,",
                      style: TextStyle(color: darkGreen, fontSize: 35),
                    ),
                    const Text(
                      "Register in to continue",
                      style: TextStyle(
                        color: paleGreen,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      NameField(
                        fadeName: false, 
                        nameController: nameController,
                        node: nameFocusNode,
                        bottomAnimationValue: 0.8,
                        opacityAnimationValue: 1.0,
                        paddingAnimationValue: const EdgeInsets.all(8.0),
                        animationColor: mainGreen,
                        onChanged: (value) {
                          print("Name changed: $value");
                        },
                      ),
                      const SizedBox(height: 40),
                      EmailField(
                        fadeEmail: false,
                        emailController: emailController,
                        node: emailFocusNode,
                        bottomAnimationValue: 0.8, // Example value
                        opacityAnimationValue: 1.0,
                        paddingAnimationValue: const EdgeInsets.all(0),
                        animationColor: Colors.green, // Example color
                        onChanged: (value) {
                          print("Email changed: $value");
                        },
                      ),
                      const SizedBox(height: 40),
                      PasswordField(
                        hintText: "Password",
                        fadePassword: false,
                        passwordController: passwordController,
                        obscure: true,
                        node: passwordFocusNode,
                        bottomAnimationValue: 0.8, // Example value
                        opacityAnimationValue: 1.0,
                        onToggleObscure: (isObscure) {
                          print("Obscure toggled: $isObscure");
                        },
                        onPasswordChanged: (value) {
                          print("Password changed: $value");
                        },
                      ),
                      const SizedBox(height: 40),
                      PasswordField(
                        hintText: "Confirm Password",
                        fadePassword: false,
                        passwordController: confirmPasswordController,
                        obscure: true,
                        node: confirmPasswordNode,
                        bottomAnimationValue: 0.8, // Example value
                        opacityAnimationValue: 1.0,
                        onToggleObscure: (isObscure) {
                          print("Obscure toggled: $isObscure");
                        },
                        onPasswordChanged: (value) {
                          print("Confirm password changed: $value");
                        },
                      ),
                      const SizedBox(height: 90),
                      GetStartedButton(
                        elementsOpacity: 1.0,
                        onTap: () {
                          print("Get Started tapped!");
                          print('Register: ${emailController.text} ${nameController.text} ${passwordController.text} ${confirmPasswordController.text}'); // debug log, remove in prod
                          Provider.of<AuthService>(context, listen: false).register(
                            emailController.text,
                            nameController.text,
                            passwordController.text,
                            confirmPasswordController.text,
                            );
/*
                            .then((value) {
                            if (value == 'success') {
                              Navigator.pushNamed(context, '/home');
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar( // TODO: Create a custom snackbar widget
                                  content: Text(value as String),
                                  backgroundColor: Colors.red,
                                  duration: const Duration(seconds: 3),
                                  behavior: SnackBarBehavior.floating,
                                  margin: const EdgeInsets.all(20),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)
                                ),
                              );
                            }
                          });
*/
                        },
                        onAnimationEnd: () {
                          print("Animation ended");
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
