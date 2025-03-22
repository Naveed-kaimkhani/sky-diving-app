
import 'package:flutter/material.dart';
import 'package:sky_diving/constants/app_colors.dart';
class LabelText extends StatelessWidget {
  final String text;
  final FontWeight weight;
  final Theme? theme;
  final double? fontSize;
  final double? height;
  final TextOverflow? overflow;
  final int? maxLine;
  final Color textColor;
  final TextAlign textAlign;
  final TextDecoration? decoration;
  final Color? decorationColor;

  const LabelText({
    super.key,
    required this.text,
    this.overflow,
    this.theme,
    this.weight = FontWeight.normal,
    this.maxLine,
    this.fontSize=16,
    this.textAlign = TextAlign.start,
    this.textColor = AppColors.black,
    this.decoration = TextDecoration.none,
    this.decorationColor,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        color: textColor,
        fontWeight: weight,
        fontSize: fontSize,
        fontFamily: 'SofiaPro',
        decoration: decoration,
        decorationColor: decorationColor,
        height: height,
      ),
      overflow: overflow,
      maxLines: maxLine,
    );
  }
}