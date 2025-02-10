import 'package:fintrack/core/database/database.dart';
import 'package:fintrack/core/models/category_model.dart';
import 'package:fintrack/core/models/category_type.dart';
import 'package:isar/isar.dart';

class CategoryService {
  final Database _database;

  CategoryService(this._database);

  // Ajouter une catégorie
  Future<void> addCategory(Category category) async {
    try {
      await _database.isar.writeTxn(() async {
        await _database.isar.categorys.put(category);
      });
    } catch (e) {
      throw Exception('Failed to add category: $e');
    }
  }

  // Modifier une catégorie
  Future<void> updateCategory(Category category) async {
    try {
      await _database.isar.writeTxn(() async {
        await _database.isar.categorys.put(category);
      });
    } catch (e) {
      throw Exception('Failed to update category: $e');
    }
  }

  // Supprimer une catégorie
  Future<void> deleteCategory(Category category) async {
    try {
      await _database.isar.writeTxn(() async {
        await _database.isar.categorys.delete(category.id);
      });
    } catch (e) {
      throw Exception('Failed to delete category: $e');
    }
  }

  // Récupérer les catégories par type pour l'utilisateur actuel
  Future<List<Category>> getCategoriesByUserByType(
      String userUid, CategoryType type) async {
    try {
      return await _database.isar.categorys
          .filter()
          .uidEqualTo(userUid)
          .typeEqualTo(type)
          .findAll();
    } catch (e) {
      throw Exception('Failed to fetch categories by type: $e');
    }
  }

  // Récupérer toutes les catégories pour l'utilisateur actuel
  Future<List<Category>> getCategoriesByUser(String userUid) async {
    try {
      return await _database.isar.categorys
          .filter()
          .uidEqualTo(userUid)
          .findAll();
    } catch (e) {
      throw Exception('Failed to fetch categories: $e');
    }
  }
}
