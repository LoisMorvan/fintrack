import 'package:flutter/material.dart';
import 'package:fintrack/screens/category_page.dart';
import 'package:fintrack/core/models/category_type.dart';

class IncomePage extends StatelessWidget {
  const IncomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final CategoryType categoryType = CategoryType.income;

    return CategoryPage(
      title: 'Total income',
      categoryType: categoryType,
    );
  }
}
