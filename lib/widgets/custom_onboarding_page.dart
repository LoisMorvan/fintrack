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
          image: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Align(
              alignment: Alignment.center,
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
              ),
            ),
          ),
          decoration: const PageDecoration(
            titleTextStyle: AppFonts.h1,
            bodyTextStyle: AppFonts.body,
            imagePadding: EdgeInsets.zero,
          ),
        );
}
