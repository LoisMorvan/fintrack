import 'package:fintrack/core/main/screens/main_navigation.dart';
import 'package:fintrack/core/widgets/custom_pie_chart.dart';
import 'package:fintrack/core/widgets/interactive_pie_chart.dart';
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
  final HomeController homeController = Get.put(HomeController());

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
              const Gap(30),
              const Text(
                'Total Assets',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const Gap(8),
              const Text(
                '10,000 €',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
              const Gap(16),
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
