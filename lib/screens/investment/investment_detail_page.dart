import 'package:fintrack/core/constants/app_colors.dart';
import 'package:fintrack/core/controllers/category_controller.dart';
import 'package:fintrack/core/controllers/investment_line_detail_controller.dart';
import 'package:fintrack/core/models/investment_line.dart';
import 'package:fintrack/core/routers/app_routes.dart';
import 'package:fintrack/core/services/investment_line_service.dart';
import 'package:fintrack/widgets/investment_actions_buttons.dart';
import 'package:fintrack/widgets/investment_info_grid.dart';
import 'package:fintrack/widgets/investment_total_value.dart';
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
          appBar: AppBar(
            title: Text(
              investmentLine.asset.value?.name ?? 'Investment Details',
              style: const TextStyle(color: AppColors.textPrimary),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
              onPressed: () => Get.offNamed(AppRoutes.investments),
            ),
          ),
          resizeToAvoidBottomInset: true,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InvestmentTotalValue(controller: controller),
                  const Gap(16),
                  InvestmentInfoGrid(controller: controller),
                  const Gap(32),
                  InvestmentActionsButtons(controller: controller),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
