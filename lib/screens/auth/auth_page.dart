import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:fintrack/core/controllers/auth_controller.dart';
import 'package:fintrack/core/routers/app_routes.dart';
import 'package:fintrack/widgets/custom_button.dart';
import 'package:fintrack/widgets/custom_text_field.dart';

class AuthPage extends StatelessWidget {
  final bool isSignup;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  AuthPage({super.key, required this.isSignup});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/icons/logo.png', height: 80),
                  const Gap(16.0),
                  if (isSignup) ...[
                    CustomTextField(
                      controller: authController.firstNameController,
                      labelText: 'First Name',
                      validator: (value) =>
                          value!.isEmpty ? 'First Name is required' : null,
                    ),
                    const Gap(12.0),
                    CustomTextField(
                      controller: authController.lastNameController,
                      labelText: 'Last Name',
                      validator: (value) =>
                          value!.isEmpty ? 'Last Name is required' : null,
                    ),
                    const Gap(12.0),
                  ],
                  CustomTextField(
                    controller: authController.emailController,
                    labelText: 'Email',
                    validator: authController.validateEmail,
                  ),
                  const Gap(12.0),
                  CustomTextField(
                    controller: authController.passwordController,
                    labelText: 'Password',
                    obscureText: true,
                    validator: authController.validatePassword,
                  ),
                  if (isSignup) ...[
                    const Gap(12.0),
                    CustomTextField(
                      controller: authController.confirmPasswordController,
                      labelText: 'Confirm Password',
                      obscureText: true,
                      validator: authController.validateConfirmPassword,
                    ),
                  ],
                  const Gap(20.0),
                  CustomButton(
                    text: isSignup ? 'Sign Up' : 'Log In',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        isSignup
                            ? authController.signup()
                            : authController.login();
                      }
                    },
                  ),
                  const Gap(12.0),
                  GestureDetector(
                    onTap: () => Get.toNamed(
                        isSignup ? AppRoutes.login : AppRoutes.signup),
                    child: Text(
                      isSignup
                          ? "Already have an account? Sign In"
                          : "Don't have an account? Sign Up",
                      style: const TextStyle(
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
