import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PieChartOptions {
  static Widget buildPercentageOption({
    required double percentage,
    required Color color,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: Text('$percentage%'),
          ),
          const Gap(10),
          Text(
            label,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
