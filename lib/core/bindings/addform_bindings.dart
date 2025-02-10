import 'package:fintrack/core/controllers/addform_controller.dart';
import 'package:fintrack/core/controllers/category_controller.dart';
import 'package:fintrack/core/controllers/category_line_controller.dart';
import 'package:fintrack/core/controllers/investment_line_controller.dart';
import 'package:fintrack/core/models/category_type.dart';
import 'package:fintrack/core/services/asset_service.dart';
import 'package:fintrack/core/services/category_line_service.dart';
import 'package:fintrack/core/services/category_service.dart';
import 'package:fintrack/core/services/investment_line_service.dart';
import 'package:get/get.dart';

class AddFormBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CategoryController(
        CategoryType.income,
        Get.find<CategoryService>(),
        Get.find<CategoryLineService>(),
        Get.find<InvestmentLineService>()));
    Get.lazyPut(() => CategoryLineController(
        Get.find<CategoryController>(), Get.find<CategoryLineService>()));
    Get.lazyPut(() => InvestmentLineController(
        Get.find<CategoryController>(), Get.find<InvestmentLineService>()));
    Get.lazyPut(() => AddFormController(
        categoryController: Get.find<CategoryController>(),
        categoryLineController: Get.find<CategoryLineController>(),
        investmentLineController: Get.find<InvestmentLineController>(),
        assetService: Get.find<AssetService>()));
  }
}
