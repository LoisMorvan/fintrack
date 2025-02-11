import 'package:fintrack/core/constants/app_colors.dart';
import 'package:fintrack/core/controllers/investment_line_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CustomEditableTile extends StatelessWidget {
  final InvestmentLineDetailController controller;
  final String label;
  final String value;
  final bool isEditing;
  final Function(String)? onChanged;

  const CustomEditableTile({
    super.key,
    required this.controller,
    required this.label,
    required this.value,
    required this.isEditing,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const Gap(8),
          isEditing
              ? TextField(
                  controller: label == 'Quantity'
                      ? controller.quantityController
                      : controller.monthlyAmountController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: onChanged,
                )
              : Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.textPrimary,
                  ),
                ),
        ],
      ),
    );
  }
}
