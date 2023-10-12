import 'package:flutter/material.dart';

import '../../res/app_strings.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final double? size;
  final Color? color;
  final FontWeight? weight;
  final TextAlign? textAlign;
  final double? spacing;
  final int maxLines;
  final bool underline;
  final String fontFamily;

  const CustomText({
    Key? key,
    this.text,
    this.size,
    this.color,
    this.weight,
    this.spacing = 0,
    this.textAlign = TextAlign.start,
    this.maxLines = 1,
    this.underline = false,
    this.fontFamily = AppStrings.montserrat
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      textDirection: TextDirection.ltr,
      textAlign: textAlign,
      maxLines: maxLines,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: fontFamily,
        decoration:
            (underline) ? TextDecoration.underline : TextDecoration.none,
        letterSpacing: spacing!,
        fontSize: size ?? 16,
        color: color ?? Colors.black,
        fontWeight: weight ?? FontWeight.normal,
      ),
    );
  }
}
