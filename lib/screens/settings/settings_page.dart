import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:fintrack/core/constants/app_colors.dart';
import 'package:fintrack/core/controllers/settings_controller.dart';
import 'package:fintrack/screens/main_navigation.dart';
import 'package:fintrack/widgets/custom_slider.dart';
import 'package:fintrack/core/controllers/auth_controller.dart';
import 'package:fintrack/widgets/custom_button.dart';

class SettingsPage extends GetView<SettingsController> {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    return Scaffold(
      body: MainNavigation(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(30),
                const Text(
                  'Settings',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Gap(16),
                _buildUserProfile(authController),
                const Gap(24),
                _buildSliders(),
                const Gap(32),
                Center(
                  child: CustomButton(
                    text: 'Disconnect',
                    onPressed: authController.logout,
                    color: AppColors.buttonPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget pour afficher le profil utilisateur
  Widget _buildUserProfile(AuthController authController) {
    return Obx(() {
      final user = authController.currentUser.value;
      final initials = user != null
          ? '${user.firstName?.isNotEmpty == true ? user.firstName![0] : 'J'}${user.lastName?.isNotEmpty == true ? user.lastName![0] : 'D'}'
          : 'JD';
      final fullName =
          user != null ? '${user.firstName} ${user.lastName}' : 'John Doe';

      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.primary,
        ),
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: AppColors.secondary,
              child: Text(
                initials,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            const Gap(16),
            Text(
              fullName,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    });
  }

  // Widget pour afficher les sliders
  Widget _buildSliders() {
    return Column(
      children: [
        Obx(() => CustomSlider(
              title: 'Investments',
              value: controller.investmentPercentage.value,
              onChanged: controller.updateInvestmentPercentage,
            )),
        const Gap(16),
        Obx(() => CustomSlider(
              title: 'Activities',
              value: controller.activityPercentage.value,
              onChanged: controller.updateActivityPercentage,
            )),
      ],
    );
  }
}
