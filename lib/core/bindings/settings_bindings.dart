import 'package:fintrack/core/controllers/auth_controller.dart';
import 'package:fintrack/core/controllers/settings_controller.dart';
import 'package:fintrack/core/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() =>
        AuthController(Get.find<UserService>(), Get.find<FirebaseAuth>()));
    Get.lazyPut(() => SettingsController(
        Get.find<UserService>(), Get.find<AuthController>()));
  }
}
