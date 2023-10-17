import 'package:flutter/material.dart';

//navigation helper
class NavigationHelper {
  static void navigateToPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}
