import 'package:fintrack/widgets/custom_nav_item.dart';
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
    CustomNavItem(icon: Icons.home, label: 'Dashboard'),
    CustomNavItem(icon: Icons.attach_money, label: 'Income'),
    CustomNavItem(icon: Icons.insert_drive_file, label: 'Expense'),
    CustomNavItem(icon: Icons.trending_up, label: 'Investment'),
    CustomNavItem(icon: Icons.settings, label: 'Settings'),
  ];

  void changePage(int index) {
    if (index != currentIndex.value) {
      currentIndex.value = index;
      Get.offNamed(pages[index], preventDuplicates: true);
      update();
    }
  }

  String getPage() => pages[currentIndex.value];
}
