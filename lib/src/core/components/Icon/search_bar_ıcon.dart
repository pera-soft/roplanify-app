import 'package:flutter/material.dart';

class CustomSearchBarIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double size;
  const CustomSearchBarIcon({
    Key? key,
    required this.icon,
    required this.size,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(icon, color: color, size: size);
  }
}
