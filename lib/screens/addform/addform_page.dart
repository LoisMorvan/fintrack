import 'package:fintrack/widgets/castegory_checkbox.dart';
import 'package:fintrack/widgets/castegory_section.dart';
import 'package:fintrack/widgets/category_line_fields.dart';
import 'package:fintrack/widgets/custom_dropdown.dart';
import 'package:fintrack/widgets/investment_fields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:fintrack/core/constants/app_colors.dart';
import 'package:fintrack/core/controllers/addform_controller.dart';
import 'package:fintrack/core/models/category_type.dart';
import 'package:fintrack/widgets/custom_button.dart';

class AddFormPage extends StatelessWidget {
  const AddFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AddFormController controller = Get.find<AddFormController>();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomDropdown(controller: controller),
                const Gap(16),
                CategoryCheckbox(controller: controller),
                const Gap(16),
                CategorySection(controller: controller),
                const Gap(16),
                Obx(() {
                  return controller.selectedType.value ==
                          CategoryType.investment
                      ? InvestmentFields(controller: controller)
                      : CategoryLineFields(controller: controller);
                }),
                const Gap(32),
                Center(
                  child: CustomButton(
                    text: 'Save',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        controller.saveForm();
                      }
                    },
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
}
