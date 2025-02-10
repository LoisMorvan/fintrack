import 'package:isar/isar.dart';

part 'user_model.g.dart';

@collection
class UserModel {
  Id id = Isar.autoIncrement;

  late String uid;
  late String email;
  String? firstName;
  String? lastName;
  DateTime? createdAt;
  double investmentPercentage = 75.0;
  double activityPercentage = 25.0;

  UserModel({
    required this.uid,
    required this.email,
    this.firstName,
    this.lastName,
    this.createdAt,
    this.investmentPercentage = 75.0,
    this.activityPercentage = 25.0,
  });
}
