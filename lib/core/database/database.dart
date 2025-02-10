import 'package:fintrack/core/models/asset_model.dart';
import 'package:fintrack/core/models/investment_line.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fintrack/core/models/user_model.dart';
import 'package:fintrack/core/models/category_line.dart';
import 'package:fintrack/core/models/category_model.dart';

class Database {
  late final Isar _isar;

  Isar get isar => _isar;

  Future<void> init() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      _isar = await Isar.open(
        [
          UserModelSchema,
          CategorySchema,
          CategoryLineSchema,
          InvestmentLineSchema,
          AssetSchema
        ],
        directory: dir.path,
      );

      await _insertFakeAssetsIfNeeded();
    } else {
      _isar = Isar.getInstance()!;
    }
  }

  Future<void> _insertFakeAssetsIfNeeded() async {
    final assetCount = await _isar.assets.count();
    if (assetCount == 0) {
      final fakeAssets = [
        Asset(name: 'BTC', currentPrice: 100000),
        Asset(name: 'SP500', currentPrice: 50),
        Asset(name: 'MSCI World', currentPrice: 600),
        Asset(name: 'ETH', currentPrice: 3000),
        Asset(name: 'NASDAQ', currentPrice: 15000),
      ];

      await _isar.writeTxn(() async {
        await _isar.assets.putAll(fakeAssets);
      });
    }
  }
}
