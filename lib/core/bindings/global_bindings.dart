import 'package:fintrack/core/database/database.dart';
import 'package:fintrack/core/services/asset_service.dart';
import 'package:fintrack/core/services/category_line_service.dart';
import 'package:fintrack/core/services/category_service.dart';
import 'package:fintrack/core/services/investment_line_service.dart';
import 'package:fintrack/core/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class GlobalBindings implements Bindings {
  @override
  void dependencies() {
    final database = Get.find<Database>();
    Get.put(FirebaseAuth.instance, permanent: true);
    Get.put(CategoryService(database), permanent: true);
    Get.put(CategoryLineService(database), permanent: true);
    Get.put(InvestmentLineService(database), permanent: true);
    Get.put(AssetService(database), permanent: true);
    Get.put(UserService(database), permanent: true);
  }
}
