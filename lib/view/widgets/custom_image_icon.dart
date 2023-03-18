import 'package:flutter/material.dart';

class CustomImageIcon extends StatelessWidget {
  final String? imagepath;
  final String? semanticLabel;
  final Color? color;
  final double? size;
  const CustomImageIcon({
    Key? key,
    this.imagepath,
    this.color,
    this.size = 32.0,
    this.semanticLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ImageIcon(
      semanticLabel: semanticLabel,
      AssetImage(
        "$imagepath",
      ),
      color: color,
      size: size,
    );
  }
}
