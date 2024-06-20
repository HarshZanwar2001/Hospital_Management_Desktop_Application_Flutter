import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final int? fontSize;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final String? fontFamily;
  final Color? textColor;
  final Color? color;
  final FontWeight? fontWeight;

  const CustomText(
    this.text, {
    Key? key,
    this.style,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.fontFamily,
    this.fontSize, 
    this.textColor, 
    this. color,  
    this. fontWeight
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
       style: TextStyle(
           color: textColor ?? Colors.black,
            fontFamily: fontFamily,
            fontSize: fontSize?.toDouble(),
            fontWeight: fontWeight?? FontWeight.normal,
            ),
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}
