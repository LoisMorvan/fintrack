import 'package:fintrack/core/controllers/investment_line_controller.dart';
import 'package:fintrack/core/models/investment_line.dart';
import 'package:fintrack/core/routers/app_routes.dart';
import 'package:fintrack/core/utils/money_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InvestmentLineTile extends StatelessWidget {
  final InvestmentLine line;
  final InvestmentLineController investmentLineController;

  const InvestmentLineTile({
    super.key,
    required this.line,
    required this.investmentLineController,
  });

  @override
  Widget build(BuildContext context) {
    final lineValue = investmentLineController.calculateLineValue(line);

    return ListTile(
      title: Text(line.asset.value?.name ?? 'No asset'),
      subtitle: Text(MoneyFormatter.format(lineValue)),
      onTap: () async {
        await Get.toNamed(
          AppRoutes.investmentDetail,
          arguments: {
            'investmentLine': line,
          },
        );
        investmentLineController.loadInvestmentLines();
      },
    );
  }
}
