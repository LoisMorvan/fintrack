import 'package:flutter/material.dart';

class CustomSlider extends StatelessWidget {
  final String title;
  final double value;
  final Function(double) onChanged;

  const CustomSlider({
    required this.title,
    required this.value,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        Slider(
          value: value,
          min: 0,
          max: 100,
          divisions: 20,
          label: value.toStringAsFixed(0),
          onChanged: (newValue) {
            final roundedValue = double.parse(newValue.toStringAsFixed(0));
            onChanged(roundedValue);
          },
        ),
      ],
    );
  }
}
