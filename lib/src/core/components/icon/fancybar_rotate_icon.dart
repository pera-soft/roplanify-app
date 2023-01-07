import 'package:flutter/material.dart';

class FancyBarIcon extends StatelessWidget {
  final IconData icons;
  final Color color;
  final double size;

  const FancyBarIcon({
    Key? key,
    required this.icons,
    required this.color,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(icons, color: color, size: size);
  }
}
