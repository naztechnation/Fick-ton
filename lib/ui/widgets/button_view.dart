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

  const ButtonView(
      {required this.onPressed,
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
      this.padding =
          const EdgeInsets.symmetric(vertical: 14.0, horizontal: 8.0),
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (processing) {
      return SizedBox(
        width: double.maxFinite,
        child: ElevatedButton(
          onPressed: () {
             
          },
          style: ElevatedButton.styleFrom(
            primary: disabled
                ? Theme.of(context).backgroundColor
                : (color ?? Theme.of(context).colorScheme.secondary),
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                side: BorderSide(
                    color: disabled
                        ? Theme.of(context).textTheme.caption!.color!
                        : (borderColor ??
                            Theme.of(context).colorScheme.secondary),
                    width: borderWidth)),
            textStyle: TextStyle(
              color: Theme.of(context).textTheme.bodyText1!.color,
            ),
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ProgressIndicators.circularProgressBar(context),
          ),
        ),
      );
    } else {
      if (expanded) {
        return SizedBox(
          width: double.maxFinite,
          child: ElevatedButton(
            onPressed: disabled ? null : onPressed,
            style: ElevatedButton.styleFrom(
              primary: disabled
                  ? Theme.of(context).backgroundColor
                  : (color ?? Theme.of(context).colorScheme.secondary),
              padding: padding,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                  side: BorderSide(
                      color: disabled
                          ? Theme.of(context).textTheme.caption!.color!
                          : (borderColor ??
                              Theme.of(context).colorScheme.secondary),
                      width: borderWidth)),
              textStyle: TextStyle(
              fontSize: fontSize,
                
                color: Theme.of(context).textTheme.bodyText1!.color,
              ),
            ),
            child: child,
          ),
        );
      } else {
        return ElevatedButton(
          onPressed: disabled ? null : onPressed,
          style: ElevatedButton.styleFrom(
            elevation: 0,
            primary: disabled
                ? Theme.of(context).backgroundColor
                : (color ?? Theme.of(context).colorScheme.secondary),
            padding: padding,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                side: BorderSide(
                    color: disabled
                        ? Theme.of(context).textTheme.caption!.color!
                        : (borderColor ??
                            Theme.of(context).colorScheme.secondary),
                    width: borderWidth)),
            textStyle: TextStyle(
              fontSize: fontSize,
              color: Theme.of(context).textTheme.bodyText1!.color,
            ),
          ),
          child: child,
        );
      }
    }
  }
}
