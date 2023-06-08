import 'package:flutter/material.dart';

class BBTextWidget extends StatelessWidget {
  const BBTextWidget(
      {super.key,
      required this.text,
      this.color,
      this.size,
      this.weight,
      this.align,
      this.decoration});

  final String text;
  final Color? color;
  final double? size;
  final FontWeight? weight;
  final TextAlign? align;
  final TextDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align ?? TextAlign.center,
      style: TextStyle(
        color: color ?? Colors.white,
        fontSize: size ?? 16,
        fontWeight: weight ?? FontWeight.w500,
        decoration: decoration ?? TextDecoration.none,
      ),
    );
  }
}
