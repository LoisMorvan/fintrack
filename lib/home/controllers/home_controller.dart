import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

class HomeController extends ChangeNotifier {
  var totalPercentage = 100.0.obs;
  final double totalAmount = 10000;
  var selectedColor = Colors.green.shade500.obs;

  List<Map<String, dynamic>> investmentsData = [
    {'title': 'Investments', 'value': 30, 'color': Colors.green},
    {'title': 'Savings', 'value': 40, 'color': Colors.blue},
    {'title': 'Debt', 'value': 20, 'color': Colors.red},
    {'title': 'Real Estate', 'value': 10, 'color': Colors.orange},
  ];

  List<Map<String, dynamic>> expensesData = [
    {'title': 'Groceries', 'value': 35, 'color': Colors.purple},
    {'title': 'Bills', 'value': 40, 'color': Colors.amber},
    {'title': 'Entertainment', 'value': 25, 'color': Colors.cyan},
  ];

  List<Map<String, dynamic>> pieData = [
    {'title': 'Total', 'value': 100, 'color': Colors.green, 'amount': 10000},
  ];

  List<PieChartSectionData> getPieChartData(double percentage) {
    return [
      PieChartSectionData(
        color: selectedColor.value,
        value: percentage,
        title: '',
        radius: 100,
      ),
      PieChartSectionData(
        color: Colors.grey.shade300.withOpacity(0.4),
        value: 100 - percentage,
        title: '',
        radius: 100,
      ),
    ];
  }

  List<PieChartSectionData> getPieChartDataFromList(
      List<Map<String, dynamic>> data) {
    return data.map((entry) {
      return PieChartSectionData(
        color: entry['color'],
        value: entry['value'].toDouble(),
        title: '${entry['value']}%',
        radius: 100,
      );
    }).toList();
  }

  void updateChart(double percentage, Color color) {
    totalPercentage.value = percentage;
    selectedColor.value = color;
  }
}
