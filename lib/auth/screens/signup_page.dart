import 'package:fintrack/auth/controllers/auth_controller.dart';
import 'package:fintrack/core/routers/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:fintrack/core/widgets/custom_button.dart';
import 'package:fintrack/core/widgets/custom_text_field.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: authController.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/icons/logo.png', height: 80),
                  const Gap(16.0),

                  // Champ Prénom
                  CustomTextField(
                    controller: authController.firstNameController,
                    labelText: 'First Name',
                    validator: (value) =>
                        value!.isEmpty ? 'First Name is required' : null,
                  ),
                  const Gap(12.0),

                  // Champ Nom
                  CustomTextField(
                    controller: authController.lastNameController,
                    labelText: 'Last Name',
                    validator: (value) =>
                        value!.isEmpty ? 'Last Name is required' : null,
                  ),
                  const Gap(12.0),

                  // Champ Email
                  CustomTextField(
                    controller: authController.emailController,
                    labelText: 'Email',
                    validator: authController.validateEmail,
                  ),
                  const Gap(12.0),

                  // Champ Mot de passe
                  CustomTextField(
                    controller: authController.passwordController,
                    labelText: 'Password',
                    obscureText: true,
                    validator: authController.validatePassword,
                  ),
                  const Gap(12.0),

                  // Champ Confirmer le mot de passe
                  CustomTextField(
                    controller: authController.confirmPasswordController,
                    labelText: 'Confirm Password',
                    obscureText: true,
                    validator: authController.validateConfirmPassword,
                  ),
                  const Gap(20.0),

                  // Bouton d'inscription
                  CustomButton(
                    text: 'Sign Up',
                    onPressed: authController.signup,
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
