import 'package:flutter/material.dart';

import '../../res/app_colors.dart';

class ProgressIndicators {
  static Widget circularProgressBar(BuildContext context,
      {double? value, double strokeWidth = 2.5}) {
    return SizedBox(
      height: 20,
      width: 20,
      child: CircularProgressIndicator.adaptive(
          value: value,
          strokeWidth: strokeWidth,
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
          backgroundColor: (Colors.white)),
    );
  }

  static Widget linearProgressBar(BuildContext context,
      {double? value, double? minHeight}) {
    return LinearProgressIndicator(
        value: value,
        minHeight: minHeight,
        valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
        backgroundColor: AppColors.lightSecondary);
  }
}
