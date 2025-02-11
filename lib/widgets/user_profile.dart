import 'package:fintrack/core/constants/app_colors.dart';
import 'package:fintrack/core/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';

class UserProfile extends StatelessWidget {
  final AuthController authController;

  const UserProfile({
    super.key,
    required this.authController,
  });

  @override
  Widget build(BuildContext context) {
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
}
