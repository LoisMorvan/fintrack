import 'package:fintrack/core/controllers/settings_controller.dart';
import 'package:fintrack/core/models/investment_line.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:fintrack/core/controllers/category_controller.dart';
import 'package:fintrack/core/controllers/investment_line_controller.dart';
import 'package:fintrack/core/models/category_type.dart';

class HomeController extends GetxController {
  final SettingsController settingsController;
  final CategoryController categoryController;
  final InvestmentLineController investmentLineController;

  // Données pour les graphiques
  var investmentsData = <Map<String, dynamic>>[].obs;
  var monthlyData = <Map<String, dynamic>>[].obs;
  var totalAssets = 0.0.obs;
  var interactivePercentage = 100.0.obs;
  var interactiveColor = Colors.green.shade500.obs;

  // Couleurs disponibles pour les graphiques
  final List<Color> availableColors = [
    Colors.green,
    Colors.blue,
    Colors.red,
    Colors.orange,
    Colors.purple,
    Colors.amber,
    Colors.cyan,
    Colors.teal,
    Colors.pink,
    Colors.indigo,
  ];

  HomeController(this.settingsController, this.categoryController,
      this.investmentLineController);

  @override
  void onInit() {
    super.onInit();
    categoryController.loadCategories();
    ever(categoryController.categories, (_) => loadData());
  }

  // Charger les données utilisateur
  void loadData() {
    calculateTotalAssets();
    calculateGraphData();
  }

  // Calculer le total des actifs (investissements)
  void calculateTotalAssets() {
    totalAssets.value = categoryController.categories
        .where((category) => category.type == CategoryType.investment)
        .expand((category) => category.investmentLines.toList())
        .fold(
            0.0,
            (sum, line) =>
                sum + investmentLineController.calculateLineValue(line));
  }

  // Calculer les données des graphiques (Investissements & Économies)
  void calculateGraphData() {
    final investmentLines = <InvestmentLine>[];
    final usedColors = <Color>[];

    for (var category in categoryController.categories) {
      if (category.type == CategoryType.investment) {
        investmentLines.addAll(category.investmentLines);
      }
    }

    final totalInvestment = investmentLines.fold(0.0,
        (sum, line) => sum + investmentLineController.calculateLineValue(line));
    final totalMonthly =
        investmentLines.fold(0.0, (sum, line) => sum + line.monthlyAmount);

    investmentsData.value = _generateChartData(
        investmentLines,
        totalInvestment,
        usedColors,
        (line) => investmentLineController.calculateLineValue(line));
    monthlyData.value = _generateChartData(investmentLines, totalMonthly,
        usedColors, (line) => line.monthlyAmount);
  }

  // Générer les données pour un graphique
  List<Map<String, dynamic>> _generateChartData(
      List<InvestmentLine> lines,
      double total,
      List<Color> usedColors,
      double Function(InvestmentLine) valueExtractor) {
    if (total == 0) return [];

    return lines.where((line) => valueExtractor(line) > 0).map((line) {
      final value = valueExtractor(line);
      return {
        'title': line.asset.value?.name ?? 'No asset',
        'value': (value / total) * 100,
        'color': getUniqueColor(usedColors),
        'amount': value,
      };
    }).toList();
  }

  // Générer une couleur unique pour un graphique
  Color getUniqueColor(List<Color> usedColors) {
    final available =
        availableColors.where((color) => !usedColors.contains(color)).toList();
    final color = available.isNotEmpty
        ? available.first
        : Colors.primaries[usedColors.length % Colors.primaries.length];
    usedColors.add(color);
    return color;
  }

  // Obtenir les économies mensuelles (revenus - dépenses)
  double getSavings() {
    final totalIncome = _calculateCategoryTotal(CategoryType.income);
    final totalExpense = _calculateCategoryTotal(CategoryType.expense);
    return totalIncome == 0
        ? 0.0
        : (totalIncome - totalExpense) * (interactivePercentage.value / 100);
  }

  // Calculer le total d'un type de catégorie
  double _calculateCategoryTotal(CategoryType type) {
    return categoryController.categories
        .where((category) => category.type == type)
        .expand((category) => category.categoryLines.toList())
        .fold(0.0, (sum, line) => sum + line.amount);
  }

  // Convertir les données en sections pour le graphique
  List<PieChartSectionData> getPieChartDataFromList(
      List<Map<String, dynamic>> data) {
    return data.map((entry) {
      return PieChartSectionData(
        color: entry['color'],
        value: entry['value'],
        title: '${entry['value'].toStringAsFixed(2)}%',
        radius: 100,
      );
    }).toList();
  }

  // Mettre à jour le graphique interactif
  void updateChart(double percentage, Color color) {
    interactivePercentage.value = percentage;
    interactiveColor.value = color;
  }
}
