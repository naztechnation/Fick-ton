import 'package:flutter/material.dart';

import '../../res/app_colors.dart';

class DotIndicator extends StatelessWidget {
  final int itemCount;
  final int currentIndex;

  const DotIndicator({
    Key? key,
    required this.itemCount,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        final isCurrentIndex = index == currentIndex;
        final indicatorWidth = isCurrentIndex ? 20.0 : 8.0;

        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            width: indicatorWidth,
            height: 6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              shape: BoxShape.rectangle,
              color: isCurrentIndex
                  ? AppColors.lightPrimary
                  : Colors.green.shade200,
            ),
          ),
        );
      }),
    );
  }
}
