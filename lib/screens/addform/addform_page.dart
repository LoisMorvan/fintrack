import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:fintrack/core/constants/app_colors.dart';
import 'package:fintrack/core/controllers/addform_controller.dart';
import 'package:fintrack/core/models/asset_model.dart';
import 'package:fintrack/core/models/category_model.dart';
import 'package:fintrack/core/models/category_type.dart';
import 'package:fintrack/widgets/custom_button.dart';

class AddFormPage extends StatelessWidget {
  const AddFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AddFormController controller = Get.find<AddFormController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add form'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTypeDropdown(controller),
                const Gap(16),
                _buildCategoryCheckbox(controller),
                const Gap(16),
                _buildCategorySection(controller),
                const Gap(16),
                _buildInvestmentOrExpenseFields(controller),
                const Gap(32),
                Center(
                  child: CustomButton(
                    text: 'Save',
                    onPressed: () => controller.saveForm(),
                    icon: Icons.save,
                    color: AppColors.buttonPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Sélection du type
  Widget _buildTypeDropdown(AddFormController controller) {
    return Obx(() {
      return DropdownButtonFormField<CategoryType>(
        value: controller.selectedType.value,
        onChanged: (value) {
          controller.changeCategoryType(value!);
        },
        decoration: const InputDecoration(labelText: 'Type'),
        items: CategoryType.values.map((type) {
          return DropdownMenuItem<CategoryType>(
            value: type,
            child: Text(type.toString().split('.').last),
          );
        }).toList(),
      );
    });
  }

  // Case à cocher pour créer une nouvelle catégorie
  Widget _buildCategoryCheckbox(AddFormController controller) {
    return Obx(() {
      return ListTile(
        contentPadding: EdgeInsets.zero,
        title: const Text('Create a new category'),
        trailing: Checkbox(
          value: controller.isCreatingCategory.value,
          onChanged: (value) {
            controller.toggleCreateCategory(value!);
          },
        ),
      );
    });
  }

  // Sélection ou création d'une catégorie
  Widget _buildCategorySection(AddFormController controller) {
    return Obx(() {
      return controller.isCreatingCategory.value
          ? TextFormField(
              controller: controller.newCategoryController,
              decoration:
                  const InputDecoration(labelText: 'New category label'),
              validator: (value) => value == null || value.isEmpty
                  ? 'Please enter a category label'
                  : null,
            )
          : DropdownButtonFormField<Category>(
              value: controller.selectedCategory.value,
              onChanged: (value) => controller.selectedCategory.value = value,
              decoration: const InputDecoration(labelText: 'Category'),
              items: controller.categoryController.categories
                  .where((category) =>
                      category.type == controller.selectedType.value)
                  .map((category) {
                return DropdownMenuItem<Category>(
                  value: category,
                  child: Text(category.title),
                );
              }).toList(),
            );
    });
  }

  // Champs spécifiques selon le type sélectionné
  Widget _buildInvestmentOrExpenseFields(AddFormController controller) {
    return Obx(() {
      return controller.selectedType.value == CategoryType.investment
          ? _buildInvestmentFields(controller)
          : _buildExpenseFields(controller);
    });
  }

  // Champs pour un investissement
  Widget _buildInvestmentFields(AddFormController controller) {
    return Column(
      children: [
        DropdownButtonFormField<Asset>(
          value: controller.selectedAsset.value,
          onChanged: (value) => controller.selectedAsset.value = value,
          decoration: const InputDecoration(labelText: 'Asset'),
          items: controller.assets.map((Asset asset) {
            return DropdownMenuItem<Asset>(
              value: asset,
              child: Text(asset.name),
            );
          }).toList(),
        ),
        const Gap(16),
        TextFormField(
          controller: controller.quantityController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Quantity'),
          validator: (value) =>
              value == null || value.isEmpty ? 'Please enter a quantity' : null,
        ),
        const Gap(16),
        TextFormField(
          controller: controller.monthlyAmountController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
              labelText: 'Monthly amount', suffixText: '€'),
          validator: (value) => value == null || value.isEmpty
              ? 'Please enter a monthly amount'
              : null,
        ),
      ],
    );
  }

  // Champs pour une dépense
  Widget _buildExpenseFields(AddFormController controller) {
    return Column(
      children: [
        TextFormField(
          controller: controller.labelController,
          decoration: const InputDecoration(labelText: 'Label'),
          validator: (value) =>
              value == null || value.isEmpty ? 'Please enter a label' : null,
        ),
        const Gap(16),
        TextFormField(
          controller: controller.amountController,
          keyboardType: TextInputType.number,
          decoration:
              const InputDecoration(labelText: 'Amount', suffixText: '€'),
          validator: (value) =>
              value == null || value.isEmpty ? 'Please enter an amount' : null,
        ),
      ],
    );
  }
}
