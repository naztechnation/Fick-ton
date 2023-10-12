import 'package:flutter/material.dart';

class ProgressIndicators{

  static Widget circularProgressBar(BuildContext context,
      {double? value, double strokeWidth=2.5}) {
    return CircularProgressIndicator(
        value: value,
        strokeWidth: strokeWidth,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        backgroundColor: (Colors.blue));
  }

  static Widget linearProgressBar(BuildContext context,
      {double? value, double? minHeight}) {
    return LinearProgressIndicator(
      value: value,
      minHeight: minHeight,
      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.secondary),
      backgroundColor: Theme.of(context).colorScheme.primary
    );
  }

}