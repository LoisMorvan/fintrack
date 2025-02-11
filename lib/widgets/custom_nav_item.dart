import 'package:flutter/material.dart';

class CustomNavItem extends BottomNavigationBarItem {
  CustomNavItem({
    required IconData icon,
    required String label,
  }) : super(
          icon: Icon(icon),
          activeIcon: Icon(icon),
          label: label,
        );
}
