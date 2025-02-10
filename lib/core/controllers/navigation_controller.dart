import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fintrack/core/routers/app_routes.dart';

class NavigationController extends GetxController {
  final RxInt currentIndex = 0.obs;

  final List<String> pages = [
    AppRoutes.home,
    AppRoutes.incomes,
    AppRoutes.expenses,
    AppRoutes.investments,
    AppRoutes.settings,
  ];

  final List<BottomNavigationBarItem> navItems = [
    _buildNavItem(Icons.home, 'Dashboard'),
    _buildNavItem(Icons.attach_money, 'Income'),
    _buildNavItem(Icons.insert_drive_file, 'Expense'),
    _buildNavItem(Icons.trending_up, 'Investment'),
    _buildNavItem(Icons.settings, 'Settings'),
  ];

  void changePage(int index) {
    if (index != currentIndex.value) {
      currentIndex.value = index;
      Get.offNamed(pages[index], preventDuplicates: true);
      update();
    }
  }

  String getPage() => pages[currentIndex.value];

  static BottomNavigationBarItem _buildNavItem(IconData icon, String label) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}
