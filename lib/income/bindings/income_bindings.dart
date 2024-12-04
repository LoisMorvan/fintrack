import 'package:fintrack/income/controllers/income_controller.dart';
import 'package:get/get.dart';

class IncomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => IncomeController());
  }
}
