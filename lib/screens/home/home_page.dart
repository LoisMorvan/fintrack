import 'package:fintrack/screens/main_navigation.dart';
import 'package:fintrack/widgets/custom_pie_chart.dart';
import 'package:fintrack/widgets/interactive_pie_chart.dart';
import 'package:fintrack/widgets/page_title.dart';
import 'package:fintrack/core/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();

    return Scaffold(
      body: MainNavigation(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PageTitleWidget(
                title: 'Total Assets',
                value: homeController.totalAssets,
              ),
              const Gap(24),
              Obx(() => CustomPieChart(
                    title: 'Distribution of assets',
                    data: homeController.investmentsData.toList(),
                  )),
              const Gap(24),
              Obx(() => CustomPieChart(
                    title: 'Distribution of monthly savings',
                    data: homeController.monthlyData.toList(),
                  )),
              const Gap(24),
              InteractivePieChart(
                title: 'Distribution of savings',
                percentage: homeController.interactivePercentage,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
