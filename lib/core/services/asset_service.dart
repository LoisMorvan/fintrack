import 'package:fintrack/core/database/database.dart';
import 'package:fintrack/core/models/asset_model.dart';
import 'package:isar/isar.dart';

class AssetService {
  final Database _database;

  AssetService(this._database);

  // Ajouter un asset
  Future<void> addAsset(Asset asset) async {
    try {
      await _database.isar.writeTxn(() async {
        await _database.isar.assets.put(asset);
      });
    } catch (e) {
      throw Exception('Failed to add asset: $e');
    }
  }

  // Modifier un asset
  Future<void> updateAsset(Asset asset) async {
    try {
      await _database.isar.writeTxn(() async {
        await _database.isar.assets.put(asset);
      });
    } catch (e) {
      throw Exception('Failed to update asset: $e');
    }
  }

  // Supprimer un asset
  Future<void> deleteAsset(Asset asset) async {
    try {
      await _database.isar.writeTxn(() async {
        await _database.isar.assets.delete(asset.id);
      });
    } catch (e) {
      throw Exception('Failed to delete asset: $e');
    }
  }

  // Récupérer tous les assets
  Future<List<Asset>> getAssets() async {
    try {
      return await _database.isar.assets.where().findAll();
    } catch (e) {
      throw Exception('Failed to fetch assets: $e');
    }
  }
}
