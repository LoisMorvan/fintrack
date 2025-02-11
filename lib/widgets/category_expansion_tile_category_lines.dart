import 'package:fintrack/core/controllers/category_controller.dart';
import 'package:fintrack/core/controllers/category_line_controller.dart';
import 'package:fintrack/core/controllers/investment_line_controller.dart';
import 'package:fintrack/core/models/category_model.dart';
import 'package:fintrack/core/models/category_type.dart';
import 'package:fintrack/widgets/category_line_tile.dart';
import 'package:fintrack/widgets/investment_line_tile.dart';
import 'package:flutter/material.dart';

class CategoryExpansionTileCategoryLines extends StatelessWidget {
  final Category category;
  final CategoryController categoryController;
  final CategoryLineController? categoryLineController;
  final InvestmentLineController? investmentLineController;

  const CategoryExpansionTileCategoryLines({
    super.key,
    required this.category,
    required this.categoryController,
    this.categoryLineController,
    this.investmentLineController,
  });

  @override
  Widget build(BuildContext context) {
    if (category.type == CategoryType.investment &&
        investmentLineController != null) {
      return Column(
        children: category.investmentLines.map((line) {
          return InvestmentLineTile(
            line: line,
            investmentLineController: investmentLineController!,
          );
        }).toList(),
      );
    } else if (categoryLineController != null) {
      return Column(
        children: category.categoryLines.map((line) {
          return CategoryLineTile(
            line: line,
            categoryController: categoryController,
            categoryLineController: categoryLineController!,
            category: category,
          );
        }).toList(),
      );
    }
    return const SizedBox.shrink();
  }
}
