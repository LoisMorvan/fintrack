import 'package:fintrack/core/bindings/global_bindings.dart';
import 'package:fintrack/core/constants/app_theme.dart';
import 'package:fintrack/core/controllers/navigation_controller.dart';
import 'package:fintrack/core/database/database.dart';
import 'package:fintrack/core/routers/app_pages.dart';
import 'package:fintrack/core/routers/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final database = Database();
  await database.init();

  Get.put(database);
  Get.put(NavigationController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final String initialRoute =
        auth.currentUser != null ? AppRoutes.home : AppRoutes.onboarding;
    return GetMaterialApp(
      title: 'FinTrack',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      getPages: AppPages.pages,
      initialBinding: GlobalBindings(),
    );
  }
}
