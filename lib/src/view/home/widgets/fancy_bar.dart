import 'package:flutter/material.dart';
import 'package:pera/src/core/base/base_singleton.dart';

class FancyBar extends StatelessWidget with BaseSingleton {
  const FancyBar(
      {super.key,
      required this.height,
      required this.child,
      required this.margin});

  final double height;
  final Widget child;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: 46,
      margin: margin,
      decoration: _boxDecoration(),
      child: child,
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: _boxShadow,
    );
  }

  List<BoxShadow> get _boxShadow {
    return <BoxShadow>[
      BoxShadow(
        blurRadius: 30,
        color: colors.grey3,
      )
    ];
  }
}
