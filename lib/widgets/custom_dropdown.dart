import 'package:fintrack/core/controllers/addform_controller.dart';
import 'package:fintrack/core/models/category_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDropdown extends StatelessWidget {
  final AddFormController controller;

  const CustomDropdown({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return DropdownButtonFormField<CategoryType>(
        value: controller.selectedType.value,
        onChanged: (value) {
          controller.changeCategoryType(value!);
        },
        decoration: const InputDecoration(labelText: 'Type'),
        items: CategoryType.values.map((type) {
          return DropdownMenuItem<CategoryType>(
            value: type,
            child: Text(type.toString().split('.').last),
          );
        }).toList(),
      );
    });
  }
}
