import 'package:fintrack/core/controllers/addform_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CategoryLineFields extends StatelessWidget {
  final AddFormController controller;

  const CategoryLineFields({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
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
