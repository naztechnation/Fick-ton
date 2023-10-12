import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow overflow;
  BigText({
    super.key,
    this.color = const Color(0xFF332d2d),
    required this.text,
    this.overflow = TextOverflow.ellipsis,
    this.size = 22,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      style:
          TextStyle(color: color, fontWeight: FontWeight.w500, fontSize: size),
    );
  }
}
