import 'package:fintrack/core/controllers/category_controller.dart';
import 'package:fintrack/core/models/category_model.dart';
import 'package:fintrack/core/models/investment_line.dart';
import 'package:fintrack/core/services/investment_line_service.dart';
import 'package:fintrack/core/utils/snackbar_helper.dart';
import 'package:get/get.dart';

class InvestmentLineController extends GetxController {
  final InvestmentLineService investmentLineService;
  final CategoryController categoryController;

  InvestmentLineController(this.categoryController, this.investmentLineService);

  // Ajouter une ligne d'investissement à une catégorie
  Future<void> addInvestmentLine(Category category, InvestmentLine line) async {
    try {
      await investmentLineService.addInvestmentLine(line);
      category.investmentLines.add(line);
      categoryController.categories.refresh();
    } catch (e) {
      SnackbarHelper.showError(
          "Erreur lors de l'ajout de l'investissement : $e");
    }
  }

  // Charger les lignes d'investissement pour chaque catégorie
  Future<void> loadInvestmentLines() async {
    try {
      for (var category in categoryController.categories) {
        await investmentLineService.loadInvestmentLines(category);
      }
      categoryController.update();
    } catch (e) {
      SnackbarHelper.showError(
          "Erreur lors du chargement des investissements : $e");
    }
  }

  // Calculer la valeur totale des investissements
  double calculateTotal() {
    return categoryController.categories
        .expand((category) => category.investmentLines)
        .fold(0.0, (sum, line) => sum + calculateLineValue(line));
  }

  // Calculer la valeur d'une ligne d'investissement (quantity * currentPrice)
  double calculateLineValue(InvestmentLine line) {
    return (line.asset.value?.currentPrice ?? 0.0) * line.quantity;
  }
}
