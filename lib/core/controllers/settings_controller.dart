import 'package:fintrack/core/controllers/auth_controller.dart';
import 'package:fintrack/core/models/user_model.dart';
import 'package:fintrack/core/services/user_service.dart';
import 'package:fintrack/core/utils/snackbar_helper.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  final UserService userService;
  final AuthController authController;

  // Pourcentages observables
  var investmentPercentage = 0.0.obs;
  var activityPercentage = 0.0.obs;

  SettingsController(this.userService, this.authController);

  @override
  void onInit() {
    super.onInit();
    _initializeUserListener();
  }

  // Initialise l'écouteur de l'utilisateur connecté
  void _initializeUserListener() {
    authController.currentUser.listen((user) {
      if (user != null) _loadUserPercentages(user);
    });
  }

  // Charge les pourcentages de l'utilisateur
  void _loadUserPercentages(UserModel user) {
    investmentPercentage.value = user.investmentPercentage;
    activityPercentage.value = user.activityPercentage;
  }

  // Met à jour le pourcentage d'investissement avec un debounce pour éviter les requêtes excessives
  void updateInvestmentPercentage(double newPercentage) {
    investmentPercentage.value = newPercentage;
    debounce(investmentPercentage, (_) => _savePercentagesToDatabase(),
        time: const Duration(milliseconds: 100));
  }

  // Met à jour le pourcentage d'activité avec un debounce
  void updateActivityPercentage(double newPercentage) {
    activityPercentage.value = newPercentage;
    debounce(activityPercentage, (_) => _savePercentagesToDatabase(),
        time: const Duration(milliseconds: 100));
  }

  // Sauvegarde les pourcentages dans la base de données
  Future<void> _savePercentagesToDatabase() async {
    try {
      final user = authController.currentUser.value;
      if (user == null) throw "Utilisateur non connecté";

      user.investmentPercentage = investmentPercentage.value;
      user.activityPercentage = activityPercentage.value;

      await userService.updateUser(user);
      authController.currentUser.refresh();
    } catch (e) {
      SnackbarHelper.showError("Erreur de mise à jour : $e");
    }
  }
}
