import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({Key? key, required this.text, this.maxLines,  this.textColor,   this.fontSize,   this.fontWeight,   this.textOverflow}) : super(key: key);
  final String text;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final int? maxLines;
  final TextOverflow? textOverflow;
  @override
  Widget build(BuildContext context) {
    return  AutoSizeText(
      text,
      style: TextStyle(
        color: textColor,
        fontSize: fontSize,
        fontWeight:fontWeight,
      ),
    );
  }
}