import 'package:flutter/material.dart';
import 'package:fintrack/core/models/category_type.dart';
import 'package:fintrack/screens/category_page.dart';

class ExpensePage extends StatelessWidget {
  const ExpensePage({super.key});

  @override
  Widget build(BuildContext context) {
    final CategoryType categoryType = CategoryType.expense;

    return CategoryPage(
      title: 'Total expenses',
      categoryType: categoryType,
    );
  }
}
