import 'package:fintrack/onboarding/onboarding_page.dart';
import 'package:get/get.dart';
import 'package:fintrack/auth/screens/login_page.dart';
import 'package:fintrack/auth/screens/signup_page.dart';

class AppRoutes {
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
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
    ),
    GetPage(
      name: AppRoutes.signup,
      page: () => const SignupPage(),
    ),
  ];
}
