import 'package:fintrack/core/constants/app_colors.dart';
import 'package:fintrack/core/models/category.dart';
import 'package:fintrack/core/utils/format_money.dart';
import 'package:fintrack/core/widgets/custom_category_line.dart';
import 'package:flutter/material.dart';

class CustomCategory extends StatelessWidget {
  final Category category;

  const CustomCategory({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    double totalAmount =
        category.lines.fold(0.0, (sum, line) => sum + line.amount);

    return ExpansionTile(
      backgroundColor: AppColors.primary,
      collapsedBackgroundColor: AppColors.primary,
      collapsedShape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            category.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          Text(
            '${formatMoney(totalAmount)} €',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
      children: category.lines
          .map(
            (line) => CustomCategoryLine(
              companyName: line.name,
              amount: line.amount,
            ),
          )
          .toList(),
    );
  }
}
