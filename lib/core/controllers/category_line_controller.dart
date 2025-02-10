import 'package:fintrack/core/controllers/category_controller.dart';
import 'package:fintrack/core/models/category_model.dart';
import 'package:fintrack/core/models/category_line.dart';
import 'package:fintrack/core/models/category_type.dart';
import 'package:fintrack/core/services/category_line_service.dart';
import 'package:fintrack/core/utils/snackbar_helper.dart';
import 'package:get/get.dart';

class CategoryLineController extends GetxController {
  final CategoryController categoryController;
  final CategoryLineService categoryLineService;

  final RxList<CategoryLine> categoryLines = <CategoryLine>[].obs;

  CategoryLineController(this.categoryController, this.categoryLineService);

  // Ajouter une ligne dans une catégorie
  Future<void> addLineToCategory(Category category, CategoryLine line) async {
    try {
      await categoryLineService.addCategoryLine(line);
      category.categoryLines.add(line);
      categoryController.categories.refresh();
      SnackbarHelper.showSuccess("Line added successfully!");
    } catch (e) {
      SnackbarHelper.showError("Error adding line to category: $e");
    }
  }

  // Supprimer une ligne d'une catégorie
  Future<void> removeLineFromCategory(
      Category category, CategoryLine line) async {
    try {
      await categoryLineService.deleteCategoryLine(line);
      category.categoryLines.remove(line);
      categoryController.categories.refresh();
      SnackbarHelper.showSuccess("Line removed successfully!");
    } catch (e) {
      SnackbarHelper.showError("Error removing line from category: $e");
    }
  }

  // Mettre à jour une ligne de catégorie
  Future<void> updateCategoryLine(Category category, CategoryLine line,
      String newName, double newAmount) async {
    try {
      line.name = newName;
      line.amount = newAmount;
      await categoryLineService.updateCategoryLine(line);
      categoryController.categories.refresh();
      SnackbarHelper.showSuccess("Line updated successfully!");
    } catch (e) {
      SnackbarHelper.showError("Error updating category line: $e");
    }
  }

  // Calculer le total des catégories en fonction du type
  double calculateTotal(CategoryType categoryType) {
    return categoryController.categories
        .where((category) => category.type == categoryType)
        .expand((category) => category.categoryLines.toList())
        .fold(0.0, (sum, line) => sum + line.amount);
  }
}
