import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../styles/colors.dart';

import '../widgets/login/register/welcome_header_section.dart';
import '../widgets/login/register/name_field.dart';
import '../widgets/login/register/email_field.dart';
import '../widgets/login/register/get_started_button.dart';
import '../widgets/login/register/pass_field.dart';
import '../widgets/login/register/confirm_pass_field.dart';
import '../widgets/login/register/nav_link.dart';

import '../services/auth_service.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final FocusNode nameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPasswordNode = FocusNode();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

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
                const SizedBox(height: 10),
                const WelcomeHeaderSection(
                  secondText: "Register to continue",
                ),
                const SizedBox(height: 50),
                _buildFormFields(),
                const SizedBox(height: 60),
                _buildFooter(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormFields() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          _buildNameField(),
          const SizedBox(height: 30),
          _buildEmailField(),
          const SizedBox(height: 30),
          _buildPasswordField(),
          const SizedBox(height: 30),
          _buildConfirmPasswordField(),
        ],
      ),
    );
  }

  Widget _buildNameField() {
    return NameField(
      nameController: nameController,
      node: nameFocusNode,
      onChanged: (value) {
        print("Name changed: $value");
      },
    );
  }

  Widget _buildEmailField() {
    return EmailField(
      emailController: emailController,
      node: emailFocusNode,
      onChanged: (value) {
        print("Email changed: $value");
      },
    );
  }

  Widget _buildPasswordField() {
    return PasswordField(
      hintText: "Password",
      passwordController: passwordController,
      obscure: _obscurePassword,
      node: passwordFocusNode,
      onToggleObscure: _togglePasswordVisibility,
      onPasswordChanged: (value) {
        print("Password changed: $value");
      },
      border: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: mainGreen,
          width: 2.0,
        ),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: mainGreen,
          width: 3.0,
        ),
      ),
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  Widget _buildConfirmPasswordField() {
    return ConfirmPassField(
      confirmPasswordController: confirmPasswordController,
      node: confirmPasswordNode,
      obscure: _obscureConfirmPassword,
      onToggleObscure: () {
        setState(() {
          _obscureConfirmPassword = !_obscureConfirmPassword;
        });
      },
      onPasswordChanged: (value) {
        print("Confirm password changed: $value");
      },
      border: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: mainGreen,
          width: 2.0,
        ),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: mainGreen,
          width: 3.0,
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildGetStartedButton(context),
        const SizedBox(height: 10),
        _buildNavLink(),
      ],
    );
  }

  Widget _buildGetStartedButton(BuildContext context) {
    return GetStartedButton(
      elementsOpacity: 1.0,
      onTap: () => _handleRegister(context),
    );
  }

  Widget _buildNavLink() {
    return NavLink(
      label: "Haven't got an account yet? Register.",
      route: '/register',
    );
  }

  Future<void> _handleRegister(BuildContext context) async {
    print("Get Started tapped!");
    print('Register: ${emailController.text} ${nameController.text} ${passwordController.text} ${confirmPasswordController.text}');

    if (passwordController.text != confirmPasswordController.text) {
      // Passwords do not match
      _showSnackBar(context, "Passwords do not match!", Colors.red);
      return;
    }

    try {
      final authService = Provider.of<AuthService>(context, listen: false);
      final result = await authService.register(
        emailController.text,
        nameController.text,
        passwordController.text,
        confirmPasswordController.text,
      );

      if (result == 'success') {
        Navigator.pushNamed(context, '/home');
      } else {
        _showSnackBar(context, result as String, Colors.red);
      }
    } catch (e) {
      _showSnackBar(context, "Error during registration: $e", Colors.red);
    }
  }

  void _showSnackBar(
      BuildContext context, String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
