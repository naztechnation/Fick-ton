import 'dart:io';

import 'package:fikkton/res/app_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../res/app_colors.dart';
import 'image_view.dart';

class LoadingPage extends StatelessWidget {
  final int length;
  const LoadingPage({this.length = 5, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Platform.isIOS
              ? const CupertinoActivityIndicator()
              : CircularProgressIndicator(
                  color: AppColors.lightPrimary,
                ),
        ),
      ),
    );
  }
}
