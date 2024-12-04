import 'package:fintrack/core/widgets/pie_chart_description.dart';
import 'package:fintrack/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CustomPieChart extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> data;

  const CustomPieChart({
    super.key,
    required this.title,
    required this.data,
  });

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
        const Gap(16),
        SizedBox(
          height: 200,
          child: PieChart(
            PieChartData(
              sections: homeController.getPieChartDataFromList(data),
              centerSpaceRadius: 0,
              sectionsSpace: 0,
            ),
          ),
        ),
        const Gap(32),
        Wrap(
          spacing: 16,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: data.map((entry) {
            return PieChartDescription(
                color: entry['color'], title: entry['title']);
          }).toList(),
        ),
      ],
    );
  }
}
