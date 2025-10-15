import 'package:flutter/material.dart';

import 'progress_indicator.dart';

class ButtonView extends StatelessWidget {
  final void Function() onPressed;
  final Widget? child;
  final double fontSize;
  final Gradient? gradient;
  final Color? color;
  final Color? borderColor;
  final double borderWidth;
  final double borderRadius;
  final bool disabled;
  final bool processing;
  final bool expanded;
  final EdgeInsets padding;

  const ButtonView({
    required this.onPressed,
    required this.child,
    this.fontSize = 16,
    this.gradient,
    this.color,
    this.borderColor,
    this.borderWidth = 0.0,
    this.disabled = false,
    this.processing = false,
    this.expanded = true,
    this.borderRadius = 16.0,
    this.padding = const EdgeInsets.symmetric(vertical: 14.0, horizontal: 8.0),
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveColor = disabled
        ? theme.colorScheme.surface
        : (color ?? theme.colorScheme.secondary);
    final effectiveBorderColor = disabled
        ? theme.textTheme.bodySmall?.color ?? Colors.grey
        : (borderColor ?? theme.colorScheme.secondary);
    final effectiveTextColor = theme.textTheme.bodyLarge?.color;

    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: effectiveColor,
      padding: padding,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        side: BorderSide(
          color: effectiveBorderColor,
          width: borderWidth,
        ),
      ),
      textStyle: TextStyle(
        fontSize: fontSize,
      ),
    );

    final buttonChild = processing
        ? Align(
            alignment: Alignment.bottomCenter,
            child: ProgressIndicators.circularProgressBar(
              context,
            ),
          )
        : child;

    final button = ElevatedButton(
      onPressed: disabled || processing ? null : onPressed,
      style: buttonStyle,
      child: buttonChild,
    );

    return expanded ? SizedBox(width: double.infinity, child: button) : button;
  }
}
