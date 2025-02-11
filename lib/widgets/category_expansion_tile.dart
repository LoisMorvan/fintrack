import 'package:fintrack/core/controllers/category_controller.dart';
import 'package:fintrack/core/controllers/category_line_controller.dart';
import 'package:fintrack/core/controllers/investment_line_controller.dart';
import 'package:fintrack/core/models/category_model.dart';
import 'package:fintrack/core/models/category_type.dart';
import 'package:fintrack/widgets/category_expansion_tile_category_lines.dart';
import 'package:fintrack/widgets/category_expansion_tile_title.dart';
import 'package:flutter/material.dart';
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
    final categoryTotal = category.type == CategoryType.investment
        ? category.investmentLines.fold<double>(
            0.0,
            (sum, line) =>
                sum + (investmentLineController?.calculateLineValue(line) ?? 0),
          )
        : category.categoryLines.fold<double>(
            0.0,
            (sum, line) => sum + line.amount,
          );

    return Column(
      children: [
        ExpansionTile(
          backgroundColor: AppColors.primary,
          collapsedBackgroundColor: AppColors.primary,
          collapsedShape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          title: CategoryExpansionTileTitle(
            category: category,
            categoryController: categoryController,
            categoryTotal: categoryTotal,
          ),
          children: [
            CategoryExpansionTileCategoryLines(
              category: category,
              categoryController: categoryController,
              categoryLineController: categoryLineController,
              investmentLineController: investmentLineController,
            ),
          ],
        ),
        const Gap(16),
      ],
    );
  }
}
