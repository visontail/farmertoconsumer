import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../styles/colors.dart';
import '../utils/snack_bar.dart';

import '../widgets/login/register/reg_workflow_app_bar.dart';
import '../widgets/login/register/welcome_header_section.dart';
import '../widgets/login/register/email_field.dart';
import '../widgets/login/register/pass_field.dart';
import '../widgets/login/register/get_started_button.dart';
import '../widgets/login/register/nav_link.dart';

import '../models/user.dart';
import '../services/auth_service.dart';
import '../utils/routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  bool _obscurePassword = true; // To control password visibility

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: RegWfAppBar(
        onBackPressed: () {
          Navigator.of(context).pop();
        },
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                const WelcomeHeaderSection(
                  secondText: "Sign in to continue",
                ),
                const SizedBox(height: 50),
                _buildFormFields(),
                const SizedBox(height: 90),
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
          _buildEmailField(),
          const SizedBox(height: 40),
          _buildPasswordField(),
        ],
      ),
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
          color: Colors.green,
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
      onTap: () => _handleLogin(context),
    );
  }

  Widget _buildNavLink() {
    return NavLink(
      label: "Haven't got an account yet? Register.",
      route: Routes.registration,
    );
  }

  Future<void> _handleLogin(BuildContext context) async {
  String email = emailController.text.trim();
  String password = passwordController.text.trim();

  if (email.isEmpty || password.isEmpty) {
    showSnackBar(
      context: context,
      message: "Please fill in both fields",
      backgroundColor: red
    );
    return;
  }

  try {
    final authService = AuthService();
    User? user = await authService.login(email, password);

    passwordController.clear();

    if (user != null) {
      showSnackBar(
        context: context,
        message: "Welcome, ${user.name}!",
        backgroundColor: mainGreen
      );
      print("Navigate to ${Routes.feed}");
      Navigator.pushReplacementNamed(context, Routes.feed);
    } else {
      showSnackBar(
        context: context,
        message: "Login failed. Please try again.",
        backgroundColor: red
      );
    }
  } catch (e) {
    showSnackBar(
      context: context,
      message: "Login failed: ${e.toString()}",
      backgroundColor: red
    );
  }
}

}
