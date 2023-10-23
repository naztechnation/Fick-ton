import 'package:flutter/material.dart';

import '../../res/app_colors.dart';

class ProgressIndicators{

  static Widget circularProgressBar(BuildContext context,
      {double? value, double strokeWidth=2.5}) {
    return CircularProgressIndicator(
        value: value,
        strokeWidth: strokeWidth,
        valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
        backgroundColor: (AppColors.lightSecondary));
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