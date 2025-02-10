import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:fintrack/core/utils/money_formatter.dart';

class PageTitleWidget extends StatelessWidget {
  final String title;
  final Rx<double> value;

  const PageTitleWidget({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(30),
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(8),
        Obx(() => Text(
              MoneyFormatter.format(value.value),
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            )),
      ],
    );
  }
}
