import 'package:fintrack/core/models/category_line.dart';

class Category {
  final String title;
  final List<CategoryLine> lines;

  Category({required this.title, required this.lines});
}
