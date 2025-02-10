import 'package:fintrack/core/controllers/home_controller.dart';
import 'package:fintrack/core/controllers/settings_controller.dart';
import 'package:fintrack/core/utils/money_formatter.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fintrack/widgets/pie_chart_options.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class InteractivePieChart extends StatelessWidget {
  final String title;
  final Rx<double> percentage;

  const InteractivePieChart({
    super.key,
    required this.title,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();
    final SettingsController settingsController =
        Get.find<SettingsController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const Gap(8),
        Obx(() => SizedBox(
              height: 200,
              child: percentage.value > 0
                  ? Stack(
                      alignment: Alignment.center,
                      children: [
                        PieChart(
                          PieChartData(
                            sections: [
                              PieChartSectionData(
                                color: homeController.interactiveColor.value,
                                value: percentage.value,
                                title: '',
                                radius: 100,
                              ),
                              PieChartSectionData(
                                color: Colors.grey.shade300.withOpacity(0.4),
                                value: 100 - percentage.value,
                                title: '',
                                radius: 100,
                              ),
                            ],
                            centerSpaceRadius: 0,
                            sectionsSpace: 0,
                          ),
                        ),
                        Text(
                          MoneyFormatter.format(homeController.getSavings()),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
            )),
        const Gap(16),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PieChartOptions.buildPercentageOption(
              percentage: 100,
              color: Colors.green,
              label: 'Remaining',
              onTap: () => homeController.updateChart(100, Colors.green),
            ),
            Obx(() => PieChartOptions.buildPercentageOption(
                  percentage: settingsController.investmentPercentage.value,
                  color: Colors.blue,
                  label: 'Investments',
                  onTap: () => homeController.updateChart(
                      settingsController.investmentPercentage.value,
                      Colors.blue),
                )),
            Obx(() => PieChartOptions.buildPercentageOption(
                  percentage: settingsController.activityPercentage.value,
                  color: Colors.orange,
                  label: 'Activities',
                  onTap: () => homeController.updateChart(
                      settingsController.activityPercentage.value,
                      Colors.orange),
                )),
          ],
        ),
      ],
    );
  }
}
