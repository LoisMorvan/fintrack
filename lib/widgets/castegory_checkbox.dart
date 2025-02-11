import 'package:fintrack/core/controllers/addform_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryCheckbox extends StatelessWidget {
  final AddFormController controller;

  const CategoryCheckbox({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListTile(
        contentPadding: EdgeInsets.zero,
        title: const Text('Create a new category'),
        trailing: Checkbox(
          value: controller.isCreatingCategory.value,
          onChanged: (value) {
            controller.toggleCreateCategory(value!);
          },
        ),
      );
    });
  }
}
