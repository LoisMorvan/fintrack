import 'package:fintrack/expense/controllers/expense_controller.dart';
import 'package:get/get.dart';

class ExpenseBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExpenseController());
  }
}
