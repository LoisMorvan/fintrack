import 'package:fintrack/core/constants/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EditPopup extends StatelessWidget {
  final String? initialCategoryName;
  final String? initialLineTitle;
  final double? initialLineAmount;
  final void Function(
      {String? newCategoryName,
      String? newLineTitle,
      double? newLineAmount}) onSave;

  const EditPopup({
    super.key,
    this.initialCategoryName,
    this.initialLineTitle,
    this.initialLineAmount,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController categoryController =
        TextEditingController(text: initialCategoryName ?? '');
    final TextEditingController lineTitleController =
        TextEditingController(text: initialLineTitle ?? '');
    final TextEditingController lineAmountController = TextEditingController(
        text: initialLineAmount != null ? initialLineAmount.toString() : '');

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Text(
              initialCategoryName != null
                  ? 'Edit Category'
                  : 'Edit Line Details',
              style: AppFonts.h2,
            ),
            const Gap(16),
            if (initialCategoryName != null)
              TextField(
                controller: categoryController,
                decoration: const InputDecoration(labelText: 'Category Title'),
              ),
            if (initialLineTitle != null)
              TextField(
                controller: lineTitleController,
                decoration: const InputDecoration(labelText: 'Line Title'),
              ),
            if (initialLineAmount != null)
              TextField(
                controller: lineAmountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Line Amount'),
              ),
            const Gap(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    final String? newCategoryName = initialCategoryName != null
                        ? categoryController.text
                        : null;
                    final String? newLineTitle = initialLineTitle != null
                        ? lineTitleController.text
                        : null;
                    final double? newLineAmount = initialLineAmount != null
                        ? double.tryParse(lineAmountController.text)
                        : null;

                    onSave(
                      newCategoryName: newCategoryName,
                      newLineTitle: newLineTitle,
                      newLineAmount: newLineAmount,
                    );

                    Navigator.pop(context);
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: const Text('Save'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
