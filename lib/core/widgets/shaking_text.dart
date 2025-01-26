import 'package:fintrack/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ShakingText extends StatefulWidget {
  final String text;
  final TextStyle? textStyle; // Ajout du paramètre textStyle

  const ShakingText({
    super.key,
    required this.text,
    this.textStyle, // Paramètre optionnel pour le style
  });

  @override
  ShakingTextState createState() => ShakingTextState();
}

class ShakingTextState extends State<ShakingText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true);
    _shakeAnimation =
        Tween<Offset>(begin: Offset.zero, end: const Offset(0, 0.1)).animate(
            CurvedAnimation(parent: _controller, curve: Curves.elasticInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _shakeAnimation,
      child: Text(
        widget.text,
        style: widget.textStyle ??
            const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
      ),
    );
  }
}
