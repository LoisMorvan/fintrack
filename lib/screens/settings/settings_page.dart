import 'package:fintrack/widgets/user_profile.dart';
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
                UserProfile(authController: authController),
                const Gap(24),
                Column(
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
                ),
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
}
