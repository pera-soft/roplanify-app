import 'package:flutter/material.dart';

class CustomSizedBox extends StatelessWidget {
  double? height;
  double? width;
  Widget? child;

  CustomSizedBox({super.key, this.height, this.width, this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: child,
    );
  }
}
