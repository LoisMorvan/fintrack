import 'package:fintrack/core/constants/app_colors.dart';
import 'package:fintrack/core/controllers/category_controller.dart';
import 'package:fintrack/core/models/category_model.dart';
import 'package:fintrack/core/utils/money_formatter.dart';
import 'package:fintrack/widgets/edit_popup.dart';
import 'package:fintrack/widgets/shaking_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryExpansionTileTitle extends StatelessWidget {
  final Category category;
  final CategoryController categoryController;
  final double categoryTotal;

  const CategoryExpansionTileTitle({
    super.key,
    required this.category,
    required this.categoryController,
    required this.categoryTotal,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _editCategory(context),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            categoryController.isEditing.value
                ? ShakingText(text: category.title)
                : Text(
                    category.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
            Text(
              MoneyFormatter.format(categoryTotal),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _editCategory(BuildContext context) {
    if (categoryController.isEditing.value) {
      showDialog(
        context: context,
        builder: (context) => EditPopup(
          initialCategoryName: category.title,
          onSave: (
              {String? newCategoryName,
              String? newLineTitle,
              double? newLineAmount}) {
            if (newCategoryName != null) {
              categoryController.updateCategoryTitle(category, newCategoryName);
            }
          },
          onDelete: () => categoryController.deleteCategory(category),
        ),
      );
    }
  }
}
