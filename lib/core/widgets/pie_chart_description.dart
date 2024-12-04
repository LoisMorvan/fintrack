import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PieChartDescription extends StatelessWidget {
  final Color color;
  final String title;

  const PieChartDescription({
    super.key,
    required this.color,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          backgroundColor: color,
          radius: 8,
        ),
        const Gap(5),
        Flexible(
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
