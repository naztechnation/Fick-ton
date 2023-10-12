import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SmallText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  FontWeight? fontWeight;
  TextAlign? align;
  TextDecoration? decoration;
  SmallText({
    super.key,
    this.align,
    this.color = const Color(0xFF332d2d),
    required this.text,
    decoration = TextDecoration.none,
    this.size = 15,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      
      textAlign: align,
      style: TextStyle(
        decoration: decoration,
        color: color,
        fontSize: size,
        fontWeight: fontWeight,
      ),
    );
  }
}
