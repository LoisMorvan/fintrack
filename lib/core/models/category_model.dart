import 'package:fintrack/core/models/investment_line.dart';
import 'package:isar/isar.dart';
import 'package:fintrack/core/models/category_line.dart';
import 'package:fintrack/core/models/category_type.dart';

part 'category_model.g.dart';

@collection
class Category {
  Id id = Isar.autoIncrement;

  String uid;
  String title;

  @enumerated
  CategoryType type;

  @Backlink(to: 'category')
  final categoryLines = IsarLinks<CategoryLine>();

  @Backlink(to: 'category')
  final investmentLines = IsarLinks<InvestmentLine>();

  Category({
    required this.uid,
    required this.title,
    required this.type,
  });
}
