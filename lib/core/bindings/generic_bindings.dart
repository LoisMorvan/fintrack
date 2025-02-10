import 'package:fintrack/core/controllers/category_controller.dart';
import 'package:fintrack/core/controllers/category_line_controller.dart';
import 'package:fintrack/core/controllers/investment_line_controller.dart';
import 'package:fintrack/core/models/category_type.dart';
import 'package:fintrack/core/services/category_line_service.dart';
import 'package:fintrack/core/services/category_service.dart';
import 'package:fintrack/core/services/investment_line_service.dart';
import 'package:get/get.dart';

class GenericBindings implements Bindings {
  final CategoryType type;

  GenericBindings(this.type);

  @override
  void dependencies() {
    Get.lazyPut(() => CategoryController(type, Get.find<CategoryService>(),
        Get.find<CategoryLineService>(), Get.find<InvestmentLineService>()));
    Get.lazyPut(() => CategoryLineController(
        Get.find<CategoryController>(), Get.find<CategoryLineService>()));
    Get.lazyPut(() => InvestmentLineController(
        Get.find<CategoryController>(), Get.find<InvestmentLineService>()));
  }
}
