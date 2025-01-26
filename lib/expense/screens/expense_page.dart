import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fintrack/expense/controllers/expense_controller.dart';
import 'package:fintrack/core/widgets/category_page.dart';

class ExpensePage extends StatelessWidget {
  const ExpensePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ExpenseController controller = Get.find<ExpenseController>();

    return CategoryPage(
      title: 'Total expenses',
      total: controller.totalExpense,
      categories: controller.categories,
      toggleShaking: controller.toggleShaking,
      isEditing: () => controller.isEditing.value,
      updateCategoryTitle: controller.updateCategoryTitle,
      updateCategoryLine: controller.updateCategoryLine,
    );
  }
}
