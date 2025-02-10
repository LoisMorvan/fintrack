import 'package:fintrack/core/constants/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EditPopup extends StatefulWidget {
  final String? initialCategoryName;
  final String? initialLineTitle;
  final double? initialLineAmount;
  final void Function({
    String? newCategoryName,
    String? newLineTitle,
    double? newLineAmount,
  }) onSave;
  final VoidCallback? onDelete;

  const EditPopup({
    super.key,
    this.initialCategoryName,
    this.initialLineTitle,
    this.initialLineAmount,
    required this.onSave,
    required this.onDelete,
  });

  @override
  EditPopupState createState() => EditPopupState();
}

class EditPopupState extends State<EditPopup> {
  late TextEditingController categoryController;
  late TextEditingController lineTitleController;
  late TextEditingController lineAmountController;

  @override
  void initState() {
    super.initState();
    categoryController =
        TextEditingController(text: widget.initialCategoryName ?? '');
    lineTitleController =
        TextEditingController(text: widget.initialLineTitle ?? '');
    lineAmountController =
        TextEditingController(text: widget.initialLineAmount?.toString() ?? '');
  }

  @override
  void dispose() {
    categoryController.dispose();
    lineTitleController.dispose();
    lineAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Text(
              widget.initialCategoryName != null
                  ? 'Edit Category'
                  : 'Edit Line Details',
              style: AppFonts.h2,
            ),
            const Gap(16),
            if (widget.initialCategoryName != null)
              TextField(
                  controller: categoryController,
                  decoration:
                      const InputDecoration(labelText: 'Category Title')),
            if (widget.initialLineTitle != null)
              TextField(
                  controller: lineTitleController,
                  decoration: const InputDecoration(labelText: 'Line Title')),
            if (widget.initialLineAmount != null)
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
                    widget.onSave(
                      newCategoryName: categoryController.text.isNotEmpty
                          ? categoryController.text
                          : null,
                      newLineTitle: lineTitleController.text.isNotEmpty
                          ? lineTitleController.text
                          : null,
                      newLineAmount: double.tryParse(lineAmountController.text),
                    );
                    Navigator.pop(context);
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: const Text('Save'),
                ),
                if (widget.onDelete != null)
                  ElevatedButton(
                    onPressed: () {
                      widget.onDelete!();
                      Navigator.pop(context);
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text('Delete'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
