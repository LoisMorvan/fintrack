import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fintrack/core/controllers/navigation_controller.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final navController = Get.find<NavigationController>();

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
        child: Obx(
          () => BottomNavigationBar(
            currentIndex: navController.currentIndex.value,
            onTap: (index) {
              navController.changePage(index);
            },
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black54,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            items: navController.navItems,
          ),
        ));
  }
}
