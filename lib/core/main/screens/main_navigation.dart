import 'package:fintrack/core/main/screens/bottom_nav_bar.dart';
import 'package:fintrack/core/main/screens/floating_button.dart';
import 'package:flutter/material.dart';

class MainNavigation extends StatelessWidget {
  final Widget child;
  final bool showFloatingButton;

  const MainNavigation({
    super.key,
    required this.child,
    this.showFloatingButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: const BottomNavBar(),
      floatingActionButton: showFloatingButton ? const FloatingButton() : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}
