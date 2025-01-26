import 'package:fintrack/core/constants/app_colors.dart';
import 'package:fintrack/core/utils/format_money.dart';
import 'package:flutter/material.dart';

class CustomCategoryLine extends StatelessWidget {
  final String companyName;
  final double amount;

  const CustomCategoryLine(
      {super.key, required this.companyName, required this.amount});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 16,
          ),
          companyName),
      trailing: Text(
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 16,
          ),
          '${formatMoney(amount)} €'),
    );
  }
}
