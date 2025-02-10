import 'package:fintrack/core/database/database.dart';
import 'package:fintrack/core/models/user_model.dart';
import 'package:isar/isar.dart';

class UserService {
  final Database _database;

  UserService(this._database);

  // Ajouter un user
  Future<void> createUser(UserModel user) async {
    try {
      await _database.isar.writeTxn(() async {
        await _database.isar.userModels.put(user);
      });
    } catch (e) {
      throw Exception('Failed to add user: $e');
    }
  }

  // Modifier un user
  Future<void> updateUser(UserModel user) async {
    try {
      await _database.isar.writeTxn(() async {
        await _database.isar.userModels.put(user);
      });
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }

  // Supprimer un user
  Future<void> deleteUser(UserModel user) async {
    try {
      await _database.isar.writeTxn(() async {
        await _database.isar.userModels.delete(user.id);
      });
    } catch (e) {
      throw Exception('Failed to delete user: $e');
    }
  }

  // Récupérer un user par son uid
  Future<UserModel?> getUsersByUid(uid) async {
    return await _database.isar.userModels.filter().uidEqualTo(uid).findFirst();
  }
}
