import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final Color textColor;
  final Color? buttonColor;
  final Color? borderColor;
  final VoidCallback? onPressed;
  final String fontFamily;
  final double fontSize;
  final double borderRadius;
  final double? width;
  final double? height;
  final FontWeight fontWeight;
  final IconData? suffixIcon; // Added suffixIcon property

  const CustomButton({
    required this.label,
    required this.textColor,
    this.buttonColor,
    this.borderColor,
    this.onPressed,
    required this.fontFamily,
    required this.fontSize,
    required this.borderRadius,
    this.width,
    this.height,
    this.fontWeight = FontWeight.normal,
    this.suffixIcon, // Updated constructor to accept suffixIcon
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor ?? Color.fromARGB(255, 248, 249, 250),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: borderColor != null ? BorderSide(color: borderColor!) : BorderSide.none,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: fontSize,
                color: textColor,
                fontWeight: fontWeight,
              ),
            ),
            if (suffixIcon != null) // Conditionally show suffixIcon if provided
              Icon(
                suffixIcon,
                size: fontSize * 1.2, // Adjust the size of the icon relative to text size
              ),
          ],
        ),
      ),
    );
  }
}
