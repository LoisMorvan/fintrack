import 'package:fintrack/core/controllers/investment_line_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:fintrack/core/constants/app_colors.dart';
import 'package:fintrack/core/controllers/category_controller.dart';
import 'package:fintrack/core/controllers/category_line_controller.dart';
import 'package:fintrack/core/models/category_type.dart';
import 'package:fintrack/widgets/category_expansion_tile.dart';
import 'package:fintrack/widgets/custom_button.dart';
import 'package:fintrack/widgets/page_title.dart';
import 'package:fintrack/screens/main_navigation.dart';

class CategoryPage extends StatelessWidget {
  final String title;
  final CategoryType categoryType;

  const CategoryPage({
    super.key,
    required this.title,
    required this.categoryType,
  });

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.find<CategoryController>();
    final categoryLineController = Get.find<CategoryLineController>();
    final investmentLineController = Get.find<InvestmentLineController>();

    return Scaffold(
      body: MainNavigation(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => PageTitleWidget(
                    title: title,
                    value: categoryType == CategoryType.investment
                        ? investmentLineController.calculateTotal().obs
                        : categoryLineController
                            .calculateTotal(categoryType)
                            .obs,
                  )),
              const Gap(32),
              Expanded(
                child: Obx(() {
                  final categories = categoryController.categories
                      .where((c) => c.type == categoryType)
                      .toList();

                  if (categories.isEmpty) {
                    return const Center(
                      child: Text(
                        'No categories found.',
                        style: TextStyle(color: AppColors.textPrimary),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (context, index) => CategoryExpansionTile(
                      category: categories[index],
                      categoryController: categoryController,
                      categoryLineController: categoryLineController,
                      investmentLineController: investmentLineController,
                    ),
                  );
                }),
              ),
              const Gap(16),
              Obx(() => Center(
                    child: CustomButton(
                      text:
                          categoryController.isEditing.value ? 'Save' : 'Edit',
                      onPressed: categoryController.toggleEditing,
                      icon: categoryController.isEditing.value
                          ? Icons.save
                          : Icons.edit,
                      color: AppColors.buttonPrimary,
                    ),
                  )),
              const Gap(16),
            ],
          ),
        ),
      ),
    );
  }
}
