import 'package:fintrack/core/models/investment_line.dart';
import 'package:isar/isar.dart';

part 'asset_model.g.dart';

@collection
class Asset {
  Id id = Isar.autoIncrement;

  String name;
  double currentPrice;

  @Backlink(to: 'asset')
  final investmentLines = IsarLinks<InvestmentLine>();

  Asset({
    required this.name,
    required this.currentPrice,
  });
}
