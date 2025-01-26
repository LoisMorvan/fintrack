import 'package:fintrack/core/models/category_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';

import 'package:fintrack/core/constants/app_colors.dart';
import 'package:fintrack/core/widgets/custom_button.dart';
import 'package:fintrack/core/widgets/edit_popup.dart';
import 'package:fintrack/core/widgets/page_title.dart';
import 'package:fintrack/core/widgets/shaking_text.dart';
import 'package:fintrack/core/main/screens/main_navigation.dart';

class CategoryPage extends StatelessWidget {
  final String title;
  final RxDouble total;
  final RxList categories;
  final VoidCallback toggleShaking;
  final bool Function() isEditing;
  final void Function(String newCategoryName, int categoryIndex)
      updateCategoryTitle;
  final void Function(int categoryIndex, int lineIndex, String newLineTitle,
      double newLineAmount) updateCategoryLine;

  const CategoryPage({
    super.key,
    required this.title,
    required this.total,
    required this.categories,
    required this.toggleShaking,
    required this.isEditing,
    required this.updateCategoryTitle,
    required this.updateCategoryLine,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainNavigation(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PageTitleWidget(
                  title: title,
                  value: total,
                ),
                const Gap(32),
                Obx(() {
                  return Column(
                    children: List.generate(categories.length, (categoryIndex) {
                      final category = categories[categoryIndex];
                      final categoryTotal = category.lines.fold<double>(
                        0.0,
                        (double sum, CategoryLine line) => sum + line.amount,
                      );

                      return ExpansionTile(
                        backgroundColor: AppColors.primary,
                        collapsedBackgroundColor: AppColors.primary,
                        collapsedShape: const ContinuousRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        shape: const ContinuousRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        title: GestureDetector(
                          onTap: () {
                            if (isEditing()) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return EditPopup(
                                    initialCategoryName: category.title,
                                    onSave: (
                                        {String? newCategoryName,
                                        String? newLineTitle,
                                        double? newLineAmount}) {
                                      if (newCategoryName != null) {
                                        updateCategoryTitle(
                                          newCategoryName,
                                          categoryIndex,
                                        );
                                      }
                                    },
                                  );
                                },
                              );
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              isEditing()
                                  ? ShakingText(
                                      text: category.title,
                                    )
                                  : Text(
                                      category.title,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                              Text(
                                '${categoryTotal.toStringAsFixed(2)} €',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        children:
                            List.generate(category.lines.length, (lineIndex) {
                          final line = category.lines[lineIndex];
                          return ListTile(
                            title: GestureDetector(
                              onTap: () {
                                if (isEditing()) {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return EditPopup(
                                        initialLineTitle: line.name,
                                        initialLineAmount: line.amount,
                                        onSave: (
                                            {String? newCategoryName,
                                            String? newLineTitle,
                                            double? newLineAmount}) {
                                          if (newLineTitle != null &&
                                              newLineAmount != null) {
                                            updateCategoryLine(
                                              categoryIndex,
                                              lineIndex,
                                              newLineTitle,
                                              newLineAmount,
                                            );
                                          }
                                        },
                                      );
                                    },
                                  );
                                }
                              },
                              child: isEditing()
                                  ? ShakingText(
                                      text: line.name,
                                      textStyle: const TextStyle(),
                                    )
                                  : Text(line.name),
                            ),
                            subtitle: isEditing()
                                ? ShakingText(
                                    text: '${line.amount.toStringAsFixed(2)} €',
                                    textStyle: const TextStyle(),
                                  )
                                : Text('${line.amount.toStringAsFixed(2)} €'),
                          );
                        }),
                      );
                    }),
                  );
                }),
                const Gap(32),
                Obx(() {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 122.0),
                    child: CustomButton(
                      text: isEditing() ? 'Save' : 'Edit',
                      onPressed: toggleShaking,
                      icon: isEditing() ? Icons.save : Icons.edit,
                      color: AppColors.buttonPrimary,
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
