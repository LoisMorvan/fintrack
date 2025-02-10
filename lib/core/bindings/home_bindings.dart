import 'package:fintrack/core/controllers/auth_controller.dart';
import 'package:fintrack/core/controllers/category_controller.dart';
import 'package:fintrack/core/controllers/home_controller.dart';
import 'package:fintrack/core/controllers/investment_line_controller.dart';
import 'package:fintrack/core/controllers/settings_controller.dart';
import 'package:fintrack/core/models/category_type.dart';
import 'package:fintrack/core/services/category_line_service.dart';
import 'package:fintrack/core/services/category_service.dart';
import 'package:fintrack/core/services/investment_line_service.dart';
import 'package:fintrack/core/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() =>
        AuthController(Get.find<UserService>(), Get.find<FirebaseAuth>()));
    Get.lazyPut(() => SettingsController(
        Get.find<UserService>(), Get.find<AuthController>()));
    Get.lazyPut(() => CategoryController(
        CategoryType.investment,
        Get.find<CategoryService>(),
        Get.find<CategoryLineService>(),
        Get.find<InvestmentLineService>()));
    Get.lazyPut(() => InvestmentLineController(
        Get.find<CategoryController>(), Get.find<InvestmentLineService>()));
    Get.lazyPut(() => HomeController(Get.find<SettingsController>(),
        Get.find<CategoryController>(), Get.find<InvestmentLineController>()));
  }
}
