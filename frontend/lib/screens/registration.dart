import 'package:farmertoconsumer/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../styles/colors.dart';
import '../utils/snack_bar.dart';

import '../widgets/login/register/reg_workflow_app_bar.dart';
import '../widgets/login/register/welcome_header_section.dart';
import '../widgets/login/register/name_field.dart';
import '../widgets/login/register/email_field.dart';
import '../widgets/login/register/get_started_button.dart';
import '../widgets/login/register/pass_field.dart';
import '../widgets/login/register/confirm_pass_field.dart';
import '../widgets/login/register/nav_link.dart';

import '../utils/routes.dart';

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
      label: "Already have an account? Login.",
      route: Routes.login,
    );
  }

  Future<void> _handleRegister(BuildContext context) async {
    final validationError = _validateRegistrationFields();

    if (validationError != null) {
      showSnackBar(
          context: context, message: validationError, backgroundColor: red);
      return;
    }

    try {
      final authProvider = Provider.of<AuthProvider>(context);
      await authProvider.register(
        emailController.text.trim(),
        nameController.text.trim(),
        passwordController.text.trim(),
        confirmPasswordController.text.trim(),
      );

      passwordController.clear();
      confirmPasswordController.clear();

      Navigator.pushNamed(context, Routes.userUpgrade);
    } catch (e) {
      showSnackBar(
        context: context,
        message: 'An error occurred during registration: $e',
        backgroundColor: red,
      );
    }
  }

  /// Validates registration form fields.
  String? _validateRegistrationFields() {
    if (nameController.text.trim().isEmpty) {
      return "Name field cannot be empty.";
    }
    if (emailController.text.trim().isEmpty) {
      return "Email field cannot be empty.";
    }
    if (passwordController.text.trim().isEmpty) {
      return "Password field cannot be empty.";
    }
    if (confirmPasswordController.text.trim().isEmpty) {
      return "Confirm Password field cannot be empty.";
    }
    if (passwordController.text != confirmPasswordController.text) {
      return "Passwords do not match.";
    }
    return null; // No errors
  }
}
