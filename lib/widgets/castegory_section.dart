import 'package:fintrack/core/controllers/addform_controller.dart';
import 'package:fintrack/core/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategorySection extends StatelessWidget {
  final AddFormController controller;

  const CategorySection({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.isCreatingCategory.value
          ? TextFormField(
              controller: controller.newCategoryController,
              decoration:
                  const InputDecoration(labelText: 'New category label'),
              validator: (value) => value == null || value.isEmpty
                  ? 'Please enter a category label'
                  : null,
            )
          : DropdownButtonFormField<Category>(
              value: controller.selectedCategory.value,
              onChanged: (value) => controller.selectedCategory.value = value,
              decoration: const InputDecoration(labelText: 'Category'),
              items: controller.categoryController.categories
                  .where((category) =>
                      category.type == controller.selectedType.value)
                  .map((category) {
                return DropdownMenuItem<Category>(
                  value: category,
                  child: Text(category.title),
                );
              }).toList(),
            );
    });
  }
}
