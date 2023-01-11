import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyleGenerator extends StatelessWidget {
  final String? text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final int? maxLine;
  final overflow;
  final TextAlign? alignment;
  final TextDecoration? decoration;
  const TextStyleGenerator({
    @required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.maxLine,
    this.overflow,
    this.alignment,
    this.decoration,
  });
  @override
  Widget build(BuildContext context) {
    return Text(
      text.toString(),
      maxLines: maxLine,
      overflow: overflow,
      textAlign: alignment,
      style: GoogleFonts.poppins(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        decoration: decoration,
      ),
    );
  }
}
