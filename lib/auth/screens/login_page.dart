import 'package:fintrack/auth/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:fintrack/core/widgets/custom_button.dart';
import 'package:fintrack/core/widgets/custom_text_field.dart';
import 'package:fintrack/core/routers/app_pages.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                  const Gap(20.0),

                  // Bouton de connexion
                  CustomButton(
                    text: 'Log In',
                    onPressed: authController.login,
                  ),
                  const Gap(12.0),

                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.signup);
                    },
                    child: const Text(
                      "Don't have an account? Sign Up",
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
