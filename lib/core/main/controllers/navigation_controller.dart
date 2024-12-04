import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fintrack/core/routers/app_pages.dart';

class NavigationController extends GetxController {
  var currentIndex = 0.obs;

  final List<String> pages = [
    AppRoutes.home,
    AppRoutes.incomes,
    AppRoutes.expenses,
    AppRoutes.investments,
    AppRoutes.settings,
  ];

  void changePage(int index) {
    currentIndex.value = index;
    Get.offNamed(pages[index]);
  }

  BottomNavigationBarItem buildNavItem(IconData icon, String label) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}
