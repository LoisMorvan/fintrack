import 'package:fintrack/core/constants/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class CustomOnboardingPage extends PageViewModel {
  CustomOnboardingPage({
    required String title,
    String? body,
    Widget? bodyWidget,
    required String imagePath,
  }) : super(
          title: title,
          bodyWidget: bodyWidget ?? Text(body ?? "", style: AppFonts.body),
          image: Center(child: Image.asset(imagePath, height: 175.0)),
          decoration: const PageDecoration(
            titleTextStyle: AppFonts.h1,
            bodyTextStyle: AppFonts.body,
          ),
        );
}
