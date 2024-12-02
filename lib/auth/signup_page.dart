import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:fintrack/core/widgets/custom_button.dart';
import 'package:fintrack/core/routers/app_pages.dart';
import 'package:fintrack/core/widgets/custom_text_field.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  SignupPageState createState() => SignupPageState();
}

class SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Get.toNamed(AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/icons/logo.png', height: 80),
                  const Gap(16.0),

                  // Champ Prénom
                  CustomTextField(
                    controller: _firstNameController,
                    labelText: 'First Name',
                    validator: (value) =>
                        value!.isEmpty ? 'First Name is required' : null,
                  ),
                  const Gap(12.0),

                  // Champ Nom
                  CustomTextField(
                    controller: _lastNameController,
                    labelText: 'Last Name',
                    validator: (value) =>
                        value!.isEmpty ? 'Last Name is required' : null,
                  ),
                  const Gap(12.0),

                  // Champ Email
                  CustomTextField(
                    controller: _emailController,
                    labelText: 'Email',
                    validator: _validateEmail,
                  ),
                  const Gap(12.0),

                  // Champ Mot de passe
                  CustomTextField(
                    controller: _passwordController,
                    labelText: 'Password',
                    obscureText: true,
                    validator: _validatePassword,
                  ),
                  const Gap(12.0),

                  // Champ Confirmer le mot de passe
                  CustomTextField(
                    controller: _confirmPasswordController,
                    labelText: 'Confirm Password',
                    obscureText: true,
                    validator: _validateConfirmPassword,
                  ),
                  const Gap(20.0),

                  // Bouton de connexion
                  CustomButton(
                    text: 'Sign Up',
                    onPressed: _submitForm,
                  ),
                  const Gap(12.0),

                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.login);
                    },
                    child: const Text(
                      "Already have an account? Sign In",
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
