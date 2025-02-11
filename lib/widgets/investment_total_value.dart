import 'package:fintrack/core/constants/app_colors.dart';
import 'package:fintrack/core/controllers/investment_line_detail_controller.dart';
import 'package:fintrack/core/utils/money_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InvestmentTotalValue extends StatelessWidget {
  final InvestmentLineDetailController controller;

  const InvestmentTotalValue({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final totalValue =
          controller.currentPrice.value * controller.quantity.value;
      return Text(
        MoneyFormatter.format(totalValue),
        style: const TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
      );
    });
  }
}
