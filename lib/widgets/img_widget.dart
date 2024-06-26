import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  final String imagePath;
  final double width;
  final double height;
  final BoxFit fit;

  const CustomImage({
    required this.imagePath,
    this.width = 100,
    this.height = 100,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      width: width,
      height: height,
      fit: fit,
    );
  }
}
