import 'package:fintrack/core/controllers/category_line_controller.dart';
import 'package:fintrack/core/controllers/investment_line_controller.dart';
import 'package:fintrack/core/models/category_line.dart';
import 'package:fintrack/core/models/category_model.dart';
import 'package:fintrack/core/models/investment_line.dart';
import 'package:fintrack/core/models/asset_model.dart';
import 'package:fintrack/core/services/asset_service.dart';
import 'package:fintrack/core/utils/snackbar_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fintrack/core/controllers/category_controller.dart';
import 'package:fintrack/core/models/category_type.dart';

class AddFormController extends GetxController {
  final TextEditingController newCategoryController = TextEditingController();
  final TextEditingController labelController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController monthlyAmountController = TextEditingController();

  final Rx<CategoryType> selectedType = CategoryType.income.obs;
  final RxBool isCreatingCategory = false.obs;
  final Rxn<Category> selectedCategory = Rxn<Category>();
  final Rxn<Asset> selectedAsset = Rxn<Asset>();
  final RxList<Asset> assets = <Asset>[].obs;

  final CategoryController categoryController;
  final CategoryLineController categoryLineController;
  final InvestmentLineController investmentLineController;
  final AssetService assetService;

  late final String uid;

  AddFormController({
    required this.categoryController,
    required this.categoryLineController,
    required this.investmentLineController,
    required this.assetService,
  });

  @override
  void onInit() {
    super.onInit();
    _initializeUser();
    categoryController.loadCategoriesByType(selectedType.value);
    loadAssets();
  }

  void _initializeUser() {
    final user = FirebaseAuth.instance.currentUser;
    uid = user?.uid ?? '';
  }

  Future<void> loadAssets() async {
    try {
      assets.value = await assetService.getAssets();
    } catch (e) {
      SnackbarHelper.showError("Failed to load assets: $e");
    }
  }

  void changeCategoryType(CategoryType value) {
    selectedType.value = value;
    selectedCategory.value = null;
    categoryController.loadCategoriesByType(value);
  }

  void toggleCreateCategory(bool value) => isCreatingCategory.value = value;

  Future<void> saveForm() async {
    if (!_validateForm()) {
      SnackbarHelper.showError("Please fill in all fields.");
      return;
    }

    try {
      if (isCreatingCategory.value) {
        await _createNewCategory();
      }

      if (selectedCategory.value == null) {
        throw Exception("No category selected");
      }

      await _addLineToSelectedCategory();
      resetForm();
      SnackbarHelper.showSuccess("Form saved successfully!");
    } catch (e) {
      SnackbarHelper.showError("Failed to save form: $e");
    }
  }

  bool _validateForm() {
    if (isCreatingCategory.value && newCategoryController.text.isEmpty) {
      return false;
    }

    if (!isCreatingCategory.value && selectedCategory.value == null) {
      return false;
    }

    if (selectedType.value == CategoryType.investment) {
      return selectedAsset.value != null &&
          quantityController.text.isNotEmpty &&
          monthlyAmountController.text.isNotEmpty;
    } else {
      return labelController.text.isNotEmpty &&
          amountController.text.isNotEmpty;
    }
  }

  Future<void> _createNewCategory() async {
    final category = Category(
      uid: uid,
      title: newCategoryController.text.trim(),
      type: selectedType.value,
    );

    await categoryController.addCategory(category);
    final categories = await categoryController.categoryService
        .getCategoriesByUserByType(uid, selectedType.value);

    selectedCategory.value =
        categories.firstWhereOrNull((c) => c.title == category.title);

    await categoryController.loadCategoriesByType(selectedType.value);
  }

  Future<void> _addLineToSelectedCategory() async {
    if (selectedType.value == CategoryType.investment) {
      await _addInvestmentLine();
    } else {
      await _addCategoryLine();
    }
    await categoryController.loadCategoriesByType(selectedType.value);
  }

  Future<void> _addCategoryLine() async {
    final amount = double.tryParse(amountController.text);
    if (amount == null) {
      SnackbarHelper.showError("Invalid amount");
      return;
    }

    final line = CategoryLine(
      name: labelController.text.trim(),
      amount: amount,
    );

    line.category.value = selectedCategory.value;
    await categoryLineController.addLineToCategory(
        selectedCategory.value!, line);
  }

  Future<void> _addInvestmentLine() async {
    final quantity = double.tryParse(quantityController.text);
    final monthlyAmount = double.tryParse(monthlyAmountController.text);

    if (quantity == null || monthlyAmount == null) {
      SnackbarHelper.showError("Invalid quantity or amount");
      return;
    }

    if (selectedAsset.value == null) {
      throw Exception("No asset selected");
    }

    final line = InvestmentLine(
      quantity: quantity,
      monthlyAmount: monthlyAmount,
    );

    line.category.value = selectedCategory.value;
    line.asset.value = selectedAsset.value;

    await investmentLineController.addInvestmentLine(
      selectedCategory.value!,
      line,
    );
  }

  void resetForm() {
    newCategoryController.clear();
    labelController.clear();
    amountController.clear();
    quantityController.clear();
    monthlyAmountController.clear();
    isCreatingCategory.value = false;
    selectedAsset.value = null;
    selectedCategory.value = null;
  }
}
