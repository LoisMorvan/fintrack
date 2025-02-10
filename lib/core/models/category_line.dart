import 'package:isar/isar.dart';
import 'package:fintrack/core/models/category_model.dart';

part 'category_line.g.dart';

@collection
class CategoryLine {
  Id id = Isar.autoIncrement;

  String name;
  double amount;

  final category = IsarLink<Category>();

  CategoryLine({
    required this.name,
    required this.amount,
  });
}
