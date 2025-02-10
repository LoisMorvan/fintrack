import 'package:fintrack/core/database/database.dart';
import 'package:fintrack/core/models/investment_line.dart';
import 'package:fintrack/core/models/category_model.dart';

class InvestmentLineService {
  final Database _database;

  InvestmentLineService(this._database);

  // Ajouter une ligne d'investissement
  Future<void> addInvestmentLine(InvestmentLine investmentLine) async {
    try {
      await _database.isar.writeTxn(() async {
        await _database.isar.investmentLines.put(investmentLine);
        await investmentLine.category.save();
        await investmentLine.asset.save();
      });
    } catch (e) {
      throw Exception('Failed to add investment line: $e');
    }
  }

  // Mettre à jour une ligne d'investissement
  Future<void> updateInvestmentLine(InvestmentLine investmentLine) async {
    try {
      await _database.isar.writeTxn(() async {
        await _database.isar.investmentLines.put(investmentLine);
      });
    } catch (e) {
      throw Exception('Failed to update investment line: $e');
    }
  }

  // Supprimer une ligne d'investissement
  Future<void> deleteInvestmentLine(InvestmentLine investmentLine) async {
    try {
      await _database.isar.writeTxn(() async {
        await _database.isar.investmentLines.delete(investmentLine.id);
      });
    } catch (e) {
      throw Exception('Failed to delete investment line: $e');
    }
  }

  // Charger les lignes d'investissement pour une catégorie donnée
  Future<void> loadInvestmentLines(Category category) async {
    try {
      await category.investmentLines.load();
    } catch (e) {
      throw Exception('Failed to load investment lines: $e');
    }
  }
}
