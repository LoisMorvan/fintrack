import 'package:fintrack/core/models/user_model.dart';
import 'package:fintrack/core/routers/app_routes.dart';
import 'package:fintrack/core/services/user_service.dart';
import 'package:fintrack/core/utils/snackbar_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AuthController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  final Rxn<UserModel> currentUser = Rxn<UserModel>();
  final RxBool isLoading = false.obs;

  final FirebaseAuth auth;
  final UserService userService;

  AuthController(
    this.userService,
    this.auth,
  );

  @override
  Future<void> onInit() async {
    super.onInit();
    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    final uid = auth.currentUser?.uid;
    if (uid != null) {
      try {
        isLoading.value = true;
        currentUser.value = await userService.getUsersByUid(uid);
      } catch (e) {
        SnackbarHelper.showError("Failed to load user data: ${e.toString()}");
      } finally {
        isLoading.value = false;
      }
    }
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 characters long';
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) return 'Please confirm your password';
    if (value != passwordController.text) return 'Passwords do not match';
    return null;
  }

  Future<void> login() async {
    try {
      isLoading.value = true;

      final userCredential = await auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final uid = userCredential.user!.uid;
      final email = userCredential.user!.email ?? '';

      final userInIsar = await userService.getUsersByUid(uid);

      if (userInIsar == null) {
        final newUser = UserModel(
          uid: uid,
          email: email,
          firstName: '',
          lastName: '',
          createdAt: DateTime.now(),
        );

        await userService.createUser(newUser);
        currentUser.value = newUser;
      } else {
        currentUser.value = userInIsar;
      }

      _resetFields();

      SnackbarHelper.showSuccess("Login successful");
      Get.offNamed(AppRoutes.home);
    } on FirebaseAuthException catch (e) {
      SnackbarHelper.showError(e.message ?? 'An error occurred');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signup() async {
    try {
      isLoading.value = true;

      final userCredential = await auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final newUser = UserModel(
        uid: userCredential.user!.uid,
        email: emailController.text.trim(),
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        createdAt: DateTime.now(),
      );

      await userService.createUser(newUser);
      currentUser.value = newUser;
      _resetFields();

      SnackbarHelper.showSuccess("Account created successfully");
      Get.offNamed(AppRoutes.home);
    } on FirebaseAuthException catch (e) {
      SnackbarHelper.showError(e.message ?? 'An error occurred');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      await auth.signOut();
      currentUser.value = null;
      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      SnackbarHelper.showError("Logout failed: ${e.toString()}");
    }
  }

  void _resetFields() {
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    firstNameController.clear();
    lastNameController.clear();
  }
}
