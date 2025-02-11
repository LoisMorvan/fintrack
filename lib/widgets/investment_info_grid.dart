import 'package:fintrack/core/controllers/investment_line_detail_controller.dart';
import 'package:fintrack/core/utils/money_formatter.dart';
import 'package:fintrack/widgets/custom_editable_tile.dart';
import 'package:fintrack/widgets/custom_info_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InvestmentInfoGrid extends StatelessWidget {
  final InvestmentLineDetailController controller;

  const InvestmentInfoGrid({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = controller.getMonthlyAmountPercentage();

    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.5,
      ),
      children: [
        CustomInfoTile(
            label: 'Current Price',
            value: MoneyFormatter.format(controller.currentPrice.value)),
        CustomInfoTile(
            label: 'Percentage', value: '${percentage.toStringAsFixed(2)} %'),
        Obx(() => CustomEditableTile(
              controller: controller,
              label: 'Quantity',
              value: controller.quantity.value.toString(),
              isEditing: controller.isEditing.value,
              onChanged: (value) {
                controller.quantity.value = double.tryParse(value) ?? 0.0;
              },
            )),
        Obx(() => CustomEditableTile(
              controller: controller,
              label: 'Monthly Amount',
              value: MoneyFormatter.format(controller.monthlyAmount.value),
              isEditing: controller.isEditing.value,
              onChanged: (value) {
                controller.monthlyAmount.value =
                    double.tryParse(value.replaceAll(',', '.')) ?? 0.0;
              },
            )),
      ],
    );
  }
}
