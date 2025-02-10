import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarHelper {
  // Affiche un message d'erreur
  static void showError(String message) {
    _showSnackbar("Erreur", message, Colors.redAccent);
  }

  // Affiche un message de succès
  static void showSuccess(String message) {
    _showSnackbar("Succès", message, Colors.green);
  }

  // Affiche un message d'information neutre
  static void showInfo(String message) {
    _showSnackbar("Info", message, Colors.blue);
  }

  // Méthode privée pour centraliser l'affichage des snackbars
  static void _showSnackbar(
      String title, String message, Color backgroundColor) {
    if (Get.isSnackbarOpen) return;

    Get.snackbar(
      title,
      message,
      backgroundColor: backgroundColor,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(10),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
      isDismissible: true,
    );
  }
}
