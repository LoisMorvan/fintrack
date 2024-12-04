import 'package:fintrack/auth/controllers/auth_controller.dart';
import 'package:fintrack/home/controllers/home_controller.dart';
import 'package:fintrack/home/screens/home_page.dart';
import 'package:fintrack/onboarding/onboarding_page.dart';
import 'package:get/get.dart';
import 'package:fintrack/auth/screens/login_page.dart';
import 'package:fintrack/auth/screens/signup_page.dart';

class AppRoutes {
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String incomes = '/incomes';
  static const String expenses = '/expenses';
  static const String investments = '/investments';
  static const String settings = '/settings';
  static const String addform = '/addform';
}

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingPage(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
      binding: BindingsBuilder(() {
        Get.put(AuthController());
      }),
    ),
    GetPage(
      name: AppRoutes.signup,
      page: () => const SignupPage(),
      binding: BindingsBuilder(() {
        Get.put(AuthController());
      }),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      binding: BindingsBuilder(() {
        Get.put(HomeController());
      }),
    ),
    GetPage(
      name: AppRoutes.incomes,
      page: () => const HomePage(),
    ),
    GetPage(
      name: AppRoutes.expenses,
      page: () => const HomePage(),
    ),
    GetPage(
      name: AppRoutes.investments,
      page: () => const HomePage(),
    ),
    GetPage(
      name: AppRoutes.settings,
      page: () => const HomePage(),
    ),
    GetPage(
      name: AppRoutes.addform,
      page: () => const HomePage(),
    ),
  ];
}
