import 'package:flutter/material.dart';
import 'package:fintrack/widgets/pie_chart_description.dart';
import 'package:fintrack/core/controllers/home_controller.dart';
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
    final HomeController homeController = Get.find<HomeController>();

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
              sections: data.isNotEmpty
                  ? homeController.getPieChartDataFromList(data)
                  : [
                      PieChartSectionData(
                        color: Colors.grey.shade300.withOpacity(0.4),
                        value: 100,
                        title: 'No data',
                        radius: 100,
                      ),
                    ],
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
