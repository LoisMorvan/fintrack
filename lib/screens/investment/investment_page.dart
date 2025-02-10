import 'package:flutter/material.dart';
import 'package:fintrack/screens/category_page.dart';
import 'package:fintrack/core/models/category_type.dart';

class InvestmentPage extends StatelessWidget {
  const InvestmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CategoryType categoryType = CategoryType.investment;

    return CategoryPage(
      title: 'Total investments',
      categoryType: categoryType,
    );
  }
}
