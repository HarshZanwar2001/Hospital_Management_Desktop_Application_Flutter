import 'package:flutter/material.dart';

class Textfieldready extends StatelessWidget {
  final String? hint;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final IconData? icon;
  final double? width;
  final double? height;
  final IconData? suffixIcon;
  final Color? suffixIconColor;
  final String? labelText;
  final bool isMultiline;
  final int? maxLines;
  final double? hintfontsize;
  final Color? backgroundColor;
  final Color? hintTextColor;
  final FontWeight? hintFontWeight;
  final BoxBorder? border; // New parameter for border
  final double? borderWidth; // New parameter for border width
  final Color? borderColor; // New parameter for border color

  const Textfieldready({
    Key? key,
    this.hint,
    required this.obscureText,
    this.controller,
    required this.keyboardType,
    this.icon,
    this.width,
    this.height,
    this.suffixIcon,
    this.suffixIconColor,
    this.labelText,
    this.isMultiline = false,
    this.maxLines,
    this.hintfontsize,
    this.backgroundColor,
    this.hintTextColor,
    this.hintFontWeight,
    this.border, // Include border parameter in the constructor
    this.borderWidth, // Include borderWidth parameter in the constructor
    this.borderColor, // Include borderColor parameter in the constructor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: border ?? Border.all(color: borderColor ?? Colors.transparent, width: borderWidth ?? 0), // Apply custom border properties
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        maxLines: maxLines ?? (isMultiline ? null : 1),
        maxLength: null,
        decoration: InputDecoration(
          hintText: hint ?? '',
          labelText: labelText,
          hintStyle: TextStyle(
            fontSize: hintfontsize ?? 14,
            color: hintTextColor ?? Colors.grey,
            fontWeight: hintFontWeight ?? FontWeight.normal,
          ),
          prefixIcon: icon != null ? Icon(icon) : null,
          suffixIcon: suffixIcon != null
              ? Container(
                  decoration: BoxDecoration(
                    color: suffixIconColor ?? Colors.transparent,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Icon(suffixIcon, color: Colors.white),
                )
              : null,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
