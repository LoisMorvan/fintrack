  import 'package:fintrack/core/models/category_model.dart';
  import 'package:isar/isar.dart';
  import 'package:fintrack/core/models/asset_model.dart';

  part 'investment_line.g.dart';

  @collection
  class InvestmentLine {
    Id id = Isar.autoIncrement;

    double quantity;
    double monthlyAmount;

    final asset = IsarLink<Asset>();
    final category = IsarLink<Category>();

    InvestmentLine({
      required this.quantity,
      required this.monthlyAmount,
    });
  }
