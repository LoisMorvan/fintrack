import 'package:fintrack/home/controllers/home_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fintrack/core/widgets/pie_chart_options.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class InteractivePieChart extends StatelessWidget {
  final String title;

  const InteractivePieChart({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());

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
              child: Stack(
                alignment: Alignment.center,
                children: [
                  PieChart(
                    PieChartData(
                      sections: homeController
                          .getPieChartData(homeController.totalPercentage.value),
                      centerSpaceRadius: 0,
                      sectionsSpace: 0,
                    ),
                  ),
                  Text(
                    '${(homeController.totalAmount * (homeController.totalPercentage / 100)).toStringAsFixed(2)} €',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )),
        const Gap(16),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PieChartOptions.buildPercentageOption(
              percentage: 100,
              color: Colors.green,
              label: '100% - Total',
              onTap: () => homeController.updateChart(100, Colors.green),
            ),
            PieChartOptions.buildPercentageOption(
              percentage: 75,
              color: Colors.blue,
              label: '75% - Élevé',
              onTap: () => homeController.updateChart(75, Colors.blue),
            ),
            PieChartOptions.buildPercentageOption(
              percentage: 25,
              color: Colors.orange,
              label: '25% - Faible',
              onTap: () => homeController.updateChart(25, Colors.orange),
            ),
          ],
        ),
      ],
    );
  }
}
