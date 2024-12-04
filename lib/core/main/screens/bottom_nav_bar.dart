import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fintrack/core/main/controllers/navigation_controller.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final navController = Get.find<NavigationController>();

    return Obx(() {
      final currentIndex = navController.currentIndex.value;
      return Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              spreadRadius: 5,
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            navController.changePage(index);
          },
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black54,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          items: [
            navController.buildNavItem(Icons.home, 'Dashboard'),
            navController.buildNavItem(Icons.attach_money, 'Income'),
            navController.buildNavItem(Icons.insert_drive_file, 'Expense'),
            navController.buildNavItem(Icons.trending_up, 'Investment'),
            navController.buildNavItem(Icons.settings, 'Settings'),
          ],
        ),
      );
    });
  }
}
