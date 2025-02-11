import 'package:fintrack/core/constants/app_colors.dart';
import 'package:fintrack/core/controllers/investment_line_detail_controller.dart';
import 'package:fintrack/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';

class InvestmentActionsButtons extends StatelessWidget {
  final InvestmentLineDetailController controller;

  const InvestmentActionsButtons({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: CustomButton(
              onPressed: controller.isEditing.value
                  ? controller.saveChanges
                  : controller.toggleEditing,
              color: AppColors.buttonPrimary,
              icon: controller.isEditing.value ? Icons.save : Icons.edit,
              text: controller.isEditing.value ? 'Save' : 'Edit',
            ),
          ),
          if (controller.isEditing.value) ...[
            const Gap(16),
            Expanded(
              child: CustomButton(
                onPressed: controller.deleteInvestment,
                color: AppColors.error,
                icon: Icons.delete,
                text: 'Delete',
              ),
            ),
          ]
        ],
      );
    });
  }
}
