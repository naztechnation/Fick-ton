import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../res/app_colors.dart';
import '../../res/enum.dart';
import 'progress_indicator.dart';

class Modals {
  static void showSnackBar(String message,
      {required BuildContext context, MessageType? messageType}) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
            duration: messageType == MessageType.progress
                ? const Duration(seconds: 30)
                : const Duration(seconds: 2),
            content: messageType == MessageType.progress
                ? ProgressIndicators.circularProgressBar(context)
                : Text(message, textAlign: TextAlign.center),
            backgroundColor: messageType == MessageType.success
                ? Colors.green
                : messageType == MessageType.error
                    ? Colors.red
                    : null),
      );
  }

  static void showToast(String message, {MessageType? messageType}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: messageType == MessageType.success
            ? Colors.green
            : messageType == MessageType.error
                ? Colors.red
                : null,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static Future<bool?> showAlertOptionDialog(context,
      {required String title,
      required String message,
      String buttonYesText = 'Yes',
      String buttonNoText = 'No'}) async {
    final data = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                child: Text(buttonNoText),
                onPressed: () => Navigator.pop(context, false),
              ),
              TextButton(
                child: Text(buttonYesText),
                onPressed: () => Navigator.pop(context, true),
              )
            ],
          );
        });
    return data;
  }

  static Future<dynamic> showBottomSheetModal(BuildContext context,
      {required Widget page,
      double? heightFactor = 0.5,
      bool isDissmissible = false,
      bool isScrollControlled = false,
      double borderRadius = 20.0}) async {
    final data = await showModalBottomSheet<dynamic>(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(borderRadius))),
        backgroundColor: AppColors.cardColor,
        isDismissible: isDissmissible,
        useSafeArea: true,
        isScrollControlled: isScrollControlled,
        builder: (BuildContext bc) {
          return FractionallySizedBox(heightFactor: heightFactor, child: page);
        });
    return data;
  }

  static Future<dynamic> showDialogModal(BuildContext context,
      {required Widget page, double borderRadius = 20.0}) async {
    final data = await showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(borderRadius)), //this right here
              child: page);
        });
    return data;
  }
}
