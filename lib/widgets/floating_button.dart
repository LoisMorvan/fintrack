import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fintrack/core/routers/app_routes.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Get.toNamed(AppRoutes.addform, preventDuplicates: false),
      child: const Icon(Icons.add),
    );
  }
}
