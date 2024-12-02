import 'package:fintrack/core/constants/app_fonts.dart';
import 'package:fintrack/core/constants/app_colors.dart';
import 'package:fintrack/core/routers/app_pages.dart';
import 'package:fintrack/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Welcome to Fintrack",
          body: "Discover how to manage your assets efficiently.",
          image: Center(
              child:
                  Image.asset("assets/images/onboarding1.png", height: 175.0)),
          decoration: const PageDecoration(
            titleTextStyle: AppFonts.h1,
            bodyTextStyle: AppFonts.body,
          ),
        ),
        PageViewModel(
          title: "Track your expenses",
          body: "Keep an eye on your expenses to better control your finances.",
          image: Center(
              child:
                  Image.asset("assets/images/onboarding2.png", height: 175.0)),
          decoration: const PageDecoration(
            titleTextStyle: AppFonts.h1,
            bodyTextStyle: AppFonts.body,
          ),
        ),
        PageViewModel(
          title: "Invest wisely",
          bodyWidget: Column(
            children: [
              const Text(
                "Optimize your investments with our advice.",
                style: AppFonts.body,
                textAlign: TextAlign.center,
              ),
              const Gap(16.0),
              CustomButton(
                text: "Login",
                onPressed: () {
                  Get.toNamed(AppRoutes.login);
                },
              ),
            ],
          ),
          image: Center(
              child:
                  Image.asset("assets/images/onboarding3.png", height: 175.0)),
          decoration: const PageDecoration(
            titleTextStyle: AppFonts.h1,
          ),
        ),
      ],
      onDone: () {
        Get.toNamed(AppRoutes.signup);
      },
      showSkipButton: true,
      skip: const Text("Skip"),
      next: const Icon(Icons.arrow_forward),
      done: const Text("Sign up", style: AppFonts.body),
      dotsDecorator: DotsDecorator(
        size: const Size(10.0, 10.0),
        color: AppColors.primary,
        activeSize: const Size(22.0, 10.0),
        activeColor: AppColors.secondary,
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
      ),
    );
  }
}
