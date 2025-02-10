import 'package:fintrack/core/controllers/category_controller.dart';
import 'package:fintrack/core/controllers/category_line_controller.dart';
import 'package:fintrack/core/controllers/investment_line_controller.dart';
import 'package:fintrack/core/models/category_model.dart';
import 'package:fintrack/core/models/category_type.dart';
import 'package:fintrack/core/utils/money_formatter.dart';
import 'package:fintrack/widgets/category_line_tile.dart';
import 'package:fintrack/widgets/edit_popup.dart';
import 'package:fintrack/widgets/investment_line_tile.dart';
import 'package:fintrack/widgets/shaking_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fintrack/core/constants/app_colors.dart';
import 'package:gap/gap.dart';

class CategoryExpansionTile extends StatelessWidget {
  final Category category;
  final CategoryController categoryController;
  final CategoryLineController? categoryLineController;
  final InvestmentLineController? investmentLineController;

  const CategoryExpansionTile({
    super.key,
    required this.category,
    required this.categoryController,
    this.categoryLineController,
    this.investmentLineController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() {
          final categoryTotal = category.type == CategoryType.investment
              ? category.investmentLines.fold<double>(
                  0.0,
                  (sum, line) =>
                      sum +
                      (investmentLineController?.calculateLineValue(line) ?? 0),
                )
              : category.categoryLines.fold<double>(
                  0.0,
                  (sum, line) => sum + line.amount,
                );

          return ExpansionTile(
            backgroundColor: AppColors.primary,
            collapsedBackgroundColor: AppColors.primary,
            collapsedShape: const ContinuousRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            shape: const ContinuousRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            title: _buildTitle(context, categoryTotal),
            children: _buildCategoryLines(context),
          );
        }),
        const Gap(16),
      ],
    );
  }

  Widget _buildTitle(BuildContext context, double categoryTotal) {
    return GestureDetector(
      onTap: () => _editCategory(context),
      child: Row(
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
    );
  }

  List<Widget> _buildCategoryLines(BuildContext context) {
    if (category.type == CategoryType.investment &&
        investmentLineController != null) {
      return category.investmentLines.map((line) {
        return InvestmentLineTile(
          line: line,
          investmentLineController: investmentLineController!,
        );
      }).toList();
    } else if (categoryLineController != null) {
      return category.categoryLines.map((line) {
        return CategoryLineTile(
          line: line,
          categoryController: categoryController,
          categoryLineController: categoryLineController!,
          category: category,
        );
      }).toList();
    }
    return [];
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
