import 'package:fintrack/core/constants/app_colors.dart';
import 'package:fintrack/core/controllers/category_controller.dart';
import 'package:fintrack/core/controllers/investment_line_detail_controller.dart';
import 'package:fintrack/core/models/investment_line.dart';
import 'package:fintrack/core/routers/app_routes.dart';
import 'package:fintrack/core/services/investment_line_service.dart';
import 'package:fintrack/core/utils/money_formatter.dart';
import 'package:fintrack/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';

class InvestmentDetailPage extends StatelessWidget {
  final InvestmentLine investmentLine;

  const InvestmentDetailPage({super.key, required this.investmentLine});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InvestmentLineDetailController>(
      init: InvestmentLineDetailController(
        Get.find<CategoryController>(),
        Get.find<InvestmentLineService>(),
        investmentLine,
      ),
      id: investmentLine.id,
      builder: (controller) {
        return Scaffold(
          appBar: _buildAppBar(),
          resizeToAvoidBottomInset: true,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(() => _buildTotalValue(controller)),
                  const Gap(16),
                  _buildInvestmentInfoGrid(controller),
                  const Gap(32),
                  _buildActionButtons(controller),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        investmentLine.asset.value?.name ?? 'Investment Details',
        style: const TextStyle(color: AppColors.textPrimary),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
        onPressed: () => Get.offNamed(AppRoutes.investments),
      ),
    );
  }

  Widget _buildTotalValue(InvestmentLineDetailController controller) {
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
  }

  Widget _buildInvestmentInfoGrid(InvestmentLineDetailController controller) {
    final percentage = controller.getMonthlyAmountPercentage();

    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 2,
      ),
      children: [
        _buildInfoTile('Current Price',
            MoneyFormatter.format(controller.currentPrice.value)),
        _buildInfoTile('Percentage', '${percentage.toStringAsFixed(2)} %'),
        Obx(() => _buildEditableTile(
              label: 'Quantity',
              value: controller.quantity.value.toString(),
              isEditing: controller.isEditing.value,
              onChanged: (value) {
                controller.quantity.value = double.tryParse(value) ?? 0.0;
              },
            )),
        Obx(() => _buildEditableTile(
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

  Widget _buildInfoTile(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: _labelTextStyle()),
          const Gap(8),
          Text(value, style: _valueTextStyle()),
        ],
      ),
    );
  }

  Widget _buildEditableTile({
    required String label,
    required String value,
    required bool isEditing,
    Function(String)? onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: _labelTextStyle()),
          const Gap(8),
          isEditing
              ? TextField(
                  controller: TextEditingController(
                      text: value.replaceAll('€', '').trim()),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: onChanged,
                )
              : Text(value, style: _valueTextStyle()),
        ],
      ),
    );
  }

  Widget _buildActionButtons(InvestmentLineDetailController controller) {
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

  TextStyle _labelTextStyle() {
    return const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: AppColors.textPrimary,
    );
  }

  TextStyle _valueTextStyle() {
    return const TextStyle(
      fontSize: 16,
      color: AppColors.textPrimary,
    );
  }
}
