import 'package:flutter/material.dart';
import 'package:fintrack/widgets/bottom_nav_bar.dart';
import 'package:fintrack/widgets/floating_button.dart';

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
      resizeToAvoidBottomInset: false,
      body: SafeArea(child: child),
      bottomNavigationBar: const BottomNavBar(),
      floatingActionButton: showFloatingButton ? const FloatingButton() : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
