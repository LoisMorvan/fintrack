import 'package:fintrack/core/controllers/category_controller.dart';
import 'package:fintrack/core/controllers/category_line_controller.dart';
import 'package:fintrack/core/models/category_line.dart';
import 'package:fintrack/core/models/category_model.dart';
import 'package:fintrack/core/utils/money_formatter.dart';
import 'package:flutter/material.dart';
import 'package:fintrack/widgets/edit_popup.dart';
import 'package:fintrack/widgets/shaking_text.dart';
import 'package:get/get.dart';

class CategoryLineTile extends StatelessWidget {
  final CategoryLine line;
  final CategoryController categoryController;
  final CategoryLineController categoryLineController;
  final Category category;

  const CategoryLineTile({
    super.key,
    required this.line,
    required this.categoryController,
    required this.categoryLineController,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListTile(
        title: GestureDetector(
          onTap: () {
            if (categoryController.isEditing.value) {
              showDialog(
                context: context,
                builder: (context) => EditPopup(
                  initialLineTitle: line.name,
                  initialLineAmount: line.amount,
                  onSave: (
                      {String? newCategoryName,
                      String? newLineTitle,
                      double? newLineAmount}) {
                    if (newLineTitle != null && newLineAmount != null) {
                      categoryLineController.updateCategoryLine(
                          category, line, newLineTitle, newLineAmount);
                    }
                  },
                  onDelete: () => categoryLineController.removeLineFromCategory(
                      category, line),
                ),
              );
            }
          },
          child: categoryController.isEditing.value
              ? ShakingText(text: line.name, textStyle: const TextStyle())
              : Text(line.name),
        ),
        subtitle: categoryController.isEditing.value
            ? ShakingText(
                text: MoneyFormatter.format(line.amount),
                textStyle: const TextStyle(),
              )
            : Text(
                MoneyFormatter.format(line.amount),
              ),
      ),
    );
  }
}
