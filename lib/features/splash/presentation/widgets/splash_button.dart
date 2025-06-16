import 'package:flutter/material.dart';

class SplashButton extends StatelessWidget {
  
  final Color backgroundColor;
  final String label;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final TextStyle? textStyle;
  final Color? foregroundColor;

  const SplashButton({
    super.key,
    required this.backgroundColor,
    required this.label,
    required this.onPressed,
    this.width = 187,
    this.height = 50,
    this.textStyle,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor ?? Colors.white,
        ),
        child: Text(
          label,
          style: textStyle ?? const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}