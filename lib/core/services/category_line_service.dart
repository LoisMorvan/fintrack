import 'package:fintrack/core/database/database.dart';
import 'package:fintrack/core/models/category_line.dart';

class CategoryLineService {
  final Database _database;

  CategoryLineService(this._database);

  // Ajouter une ligne de catégorie
  Future<void> addCategoryLine(CategoryLine categoryLine) async {
    try {
      await _database.isar.writeTxn(() async {
        await _database.isar.categoryLines.put(categoryLine);
        await categoryLine.category.save();
      });
    } catch (e) {
      throw Exception('Failed to add category line: $e');
    }
  }

  // Mettre à jour une ligne de catégorie
  Future<void> updateCategoryLine(CategoryLine categoryLine) async {
    try {
      await _database.isar.writeTxn(() async {
        await _database.isar.categoryLines.put(categoryLine);
      });
    } catch (e) {
      throw Exception('Failed to update category line: $e');
    }
  }

  // Supprimer une ligne de catégorie
  Future<void> deleteCategoryLine(CategoryLine categoryLine) async {
    try {
      await _database.isar.writeTxn(() async {
        await _database.isar.categoryLines.delete(categoryLine.id);
      });
    } catch (e) {
      throw Exception('Failed to delete category line: $e');
    }
  }
}
