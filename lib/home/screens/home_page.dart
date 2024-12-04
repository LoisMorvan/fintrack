import 'package:fintrack/core/main/screens/main_navigation.dart';
import 'package:fintrack/core/widgets/custom_pie_chart.dart';
import 'package:fintrack/core/widgets/interactive_pie_chart.dart';
import 'package:fintrack/core/widgets/page_title.dart';
import 'package:fintrack/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: MainNavigation(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PageTitleWidget(title: 'Total Assets', value: 10000.0.obs),
              Gap(24),
              CustomPieChart(
                  title: 'Distribution of assets',
                  data: homeController.investmentsData),
              const Gap(24),
              CustomPieChart(
                  title: 'Distribution of monthly savings',
                  data: homeController.expensesData),
              const Gap(24),
              InteractivePieChart(title: 'Distribution of savings'),
            ],
          ),
        ),
      ),
    );
  }
}
