import 'package:fintrack/core/bindings/addform_bindings.dart';
import 'package:fintrack/core/bindings/auth_bindings.dart';
import 'package:fintrack/core/bindings/generic_bindings.dart';
import 'package:fintrack/core/bindings/home_bindings.dart';
import 'package:fintrack/core/bindings/investment_detail_bindings.dart';
import 'package:fintrack/core/bindings/settings_bindings.dart';
import 'package:fintrack/core/models/category_type.dart';
import 'package:fintrack/core/routers/app_routes.dart';
import 'package:fintrack/screens/addform/addform_page.dart';
import 'package:fintrack/screens/expense/expense_page.dart';
import 'package:fintrack/screens/home/home_page.dart';
import 'package:fintrack/screens/income/income_page.dart';
import 'package:fintrack/screens/investment/investment_detail_page.dart';
import 'package:fintrack/screens/investment/investment_page.dart';
import 'package:fintrack/screens/onboarding/onboarding_page.dart';
import 'package:fintrack/screens/settings/settings_page.dart';
import 'package:get/get.dart';
import 'package:fintrack/screens/auth/auth_page.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingPage(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => AuthPage(isSignup: false),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.signup,
      page: () => AuthPage(isSignup: true),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.incomes,
      page: () => const IncomePage(),
      binding: GenericBindings(CategoryType.income),
    ),
    GetPage(
      name: AppRoutes.expenses,
      page: () => const ExpensePage(),
      binding: GenericBindings(CategoryType.expense),
    ),
    GetPage(
      name: AppRoutes.investments,
      page: () => const InvestmentPage(),
      binding: GenericBindings(CategoryType.investment),
    ),
    GetPage(
      name: AppRoutes.investmentDetail,
      page: () {
        final args = Get.arguments;
        if (args == null || args['investmentLine'] == null) {
          throw Exception("InvestmentLine argument is required");
        }
        return InvestmentDetailPage(investmentLine: args['investmentLine']);
      },
      binding: InvestmentDetailBindings(),
    ),
    GetPage(
      name: AppRoutes.settings,
      page: () => const SettingsPage(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: AppRoutes.addform,
      page: () => const AddFormPage(),
      binding: AddFormBindings(),
    ),
  ];
}
