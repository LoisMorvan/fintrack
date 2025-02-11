import 'package:fintrack/core/controllers/addform_controller.dart';
import 'package:fintrack/core/models/asset_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class InvestmentFields extends StatelessWidget {
  final AddFormController controller;

  const InvestmentFields({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
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
}
