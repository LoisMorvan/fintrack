import 'package:fintrack/core/models/category_model.dart';
import 'package:fintrack/core/models/category_type.dart';
import 'package:fintrack/core/services/category_line_service.dart';
import 'package:fintrack/core/services/category_service.dart';
import 'package:fintrack/core/services/investment_line_service.dart';
import 'package:fintrack/core/utils/snackbar_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CategoryService categoryService;
  final CategoryLineService categoryLineService;
  final InvestmentLineService investmentLineService;
  final CategoryType categoryType;

  final RxList<Category> categories = <Category>[].obs;
  final RxBool isEditing = false.obs;

  CategoryController(
    this.categoryType,
    this.categoryService,
    this.categoryLineService,
    this.investmentLineService,
  );

  @override
  void onInit() {
    super.onInit();
    loadCategoriesByType(categoryType);
  }

  // Active ou désactive le mode édition
  void toggleEditing() {
    isEditing.toggle();
  }

  // Récupère l'UID de l'utilisateur connecté
  String? get userId => _auth.currentUser?.uid;

  // Charge toutes les catégories de l'utilisateur
  Future<void> loadCategories() async {
    final uid = userId;
    if (uid == null) {
      SnackbarHelper.showError("User not logged in");
      return;
    }

    try {
      categories.value = await categoryService.getCategoriesByUser(uid);
    } catch (e) {
      SnackbarHelper.showError("Error loading categories: $e");
    }
  }

  // Charge les catégories d'un type spécifique
  Future<void> loadCategoriesByType(CategoryType usedCategoryType) async {
    final uid = userId;
    if (uid == null) {
      SnackbarHelper.showError("User not logged in");
      return;
    }

    try {
      categories.value = await categoryService.getCategoriesByUserByType(
          uid, usedCategoryType);
    } catch (e) {
      SnackbarHelper.showError("Error loading categories: $e");
    }
  }

  // Ajoute une nouvelle catégorie
  Future<void> addCategory(Category category) async {
    try {
      await categoryService.addCategory(category);
      categories.add(category);
      categories.refresh();
    } catch (e) {
      SnackbarHelper.showError("Error adding category: $e");
    }
  }

  // Met à jour le titre d'une catégorie
  Future<void> updateCategoryTitle(Category category, String newTitle) async {
    try {
      category.title = newTitle;
      await categoryService.updateCategory(category);
      categories.refresh();
    } catch (e) {
      SnackbarHelper.showError("Error updating category title: $e");
    }
  }

  // Supprime une catégorie et ses dépendances
  Future<void> deleteCategory(Category category) async {
    try {
      await Future.wait([
        ...category.categoryLines.map(categoryLineService.deleteCategoryLine),
        ...category.investmentLines
            .map(investmentLineService.deleteInvestmentLine),
        categoryService.deleteCategory(category),
      ]);

      categories.remove(category);
      categories.refresh();
    } catch (e) {
      SnackbarHelper.showError("Error deleting category: $e");
    }
  }
}
