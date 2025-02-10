import 'package:fintrack/core/bindings/generic_bindings.dart';
import 'package:fintrack/core/controllers/category_controller.dart';
import 'package:fintrack/core/controllers/investment_line_detail_controller.dart';
import 'package:fintrack/core/models/category_type.dart';
import 'package:fintrack/core/services/investment_line_service.dart';
import 'package:get/get.dart';

class InvestmentDetailBindings implements Bindings {
  @override
  void dependencies() {
    if (Get.arguments == null || Get.arguments['investmentLine'] == null) {
      throw Exception("InvestmentLine argument is required");
    }
    GenericBindings(CategoryType.investment).dependencies();
    Get.lazyPut(() => InvestmentLineDetailController(
        Get.find<CategoryController>(),
        Get.find<InvestmentLineService>(),
        Get.arguments['investmentLine']));
  }
}
