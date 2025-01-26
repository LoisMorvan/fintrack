import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fintrack/income/controllers/income_controller.dart';
import 'package:fintrack/core/widgets/category_page.dart';

class IncomePage extends StatelessWidget {
  const IncomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final IncomeController controller = Get.find<IncomeController>();

    return CategoryPage(
      title: 'Total income',
      total: controller.totalIncome,
      categories: controller.categories,
      toggleShaking: controller.toggleShaking,
      isEditing: () => controller.isEditing.value,
      updateCategoryTitle: controller.updateCategoryTitle,
      updateCategoryLine: controller.updateCategoryLine,
    );
  }
}
