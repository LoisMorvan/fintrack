import 'package:fintrack/core/controllers/category_controller.dart';
import 'package:fintrack/core/models/category_model.dart';
import 'package:fintrack/core/models/category_type.dart';
import 'package:fintrack/core/models/investment_line.dart';
import 'package:fintrack/core/routers/app_routes.dart';
import 'package:fintrack/core/services/investment_line_service.dart';
import 'package:fintrack/core/utils/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InvestmentLineDetailController extends GetxController {
  final InvestmentLineService investmentLineService;
  final CategoryController categoryController;
  final InvestmentLine investmentLine;

  InvestmentLineDetailController(
      this.categoryController, this.investmentLineService, this.investmentLine);

  // État d'édition
  var isEditing = false.obs;

  // Champs observables pour l'édition
  var currentPrice = 0.0.obs;
  var quantity = 0.0.obs;
  var monthlyAmount = 0.0.obs;

  // Déclare les contrôleurs pour la quantité et le montant mensuel
  late TextEditingController quantityController;
  late TextEditingController monthlyAmountController;

  @override
  void onInit() {
    super.onInit();
    _initializeFields();
    quantityController = TextEditingController(text: quantity.value.toString());
    monthlyAmountController =
        TextEditingController(text: monthlyAmount.value.toString());
  }

  // Initialise les valeurs des champs
  void _initializeFields() {
    currentPrice.value = investmentLine.asset.value?.currentPrice ?? 0.0;
    quantity.value = investmentLine.quantity;
    monthlyAmount.value = investmentLine.monthlyAmount;
  }

  // Active ou désactive le mode édition
  void toggleEditing() {
    isEditing.toggle();
  }

  // Sauvegarde les modifications apportées à l'investissement
  Future<void> saveChanges() async {
    try {
      _updateInvestmentLine();
      await investmentLineService.updateInvestmentLine(investmentLine);
      isEditing.value = false;
      SnackbarHelper.showSuccess("Investissement mis à jour avec succès");
    } catch (e) {
      SnackbarHelper.showError("Erreur lors de la mise à jour : $e");
    }
  }

  // Supprime l'investissement
  Future<void> deleteInvestment() async {
    try {
      final Category? category = investmentLine.category.value;
      if (category == null) throw "Catégorie introuvable";

      await investmentLineService.deleteInvestmentLine(investmentLine);
      category.investmentLines.remove(investmentLine);
      categoryController.categories.refresh();

      SnackbarHelper.showSuccess("Investissement supprimé avec succès");
      Get.offNamed(AppRoutes.investments);
    } catch (e) {
      SnackbarHelper.showError("Erreur lors de la suppression : $e");
    }
  }

  double getTotalMonthlyInvestment() {
    return categoryController.categories
        .where((category) => category.type == CategoryType.investment)
        .expand((category) => category.investmentLines)
        .fold(0.0, (sum, line) => sum + line.monthlyAmount);
  }

  double getMonthlyAmountPercentage() {
    double totalMonthly = getTotalMonthlyInvestment();
    if (totalMonthly == 0) return 0.0;
    return (monthlyAmount.value / totalMonthly) * 100;
  }

  // Met à jour l'investissement avec les nouvelles valeurs
  void _updateInvestmentLine() {
    investmentLine.quantity = quantity.value;
    investmentLine.monthlyAmount = monthlyAmount.value;
  }

  @override
  void onClose() {
    // N'oublie pas de libérer les contrôleurs lorsque la page est fermée
    quantityController.dispose();
    monthlyAmountController.dispose();
    super.onClose();
  }
}
