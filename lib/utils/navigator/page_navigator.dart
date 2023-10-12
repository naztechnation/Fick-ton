import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../res/enum.dart';
import 'custom_routes.dart';

class AppNavigator {
  static Future<dynamic> pushAndReplacePage(BuildContext context,
      {required Widget page,
      bool rootNavigator = false,
      RouteStyle routeStyle = RouteStyle.material}) async {
    final result = await Navigator.of(context, rootNavigator: rootNavigator)
        .pushReplacement(route(page, routeStyle: routeStyle));
    return result;
  }

  static Future<dynamic> pushAndStackPage(BuildContext context,
      {required Widget page,
      bool rootNavigator = false,
      RouteStyle routeStyle = RouteStyle.material}) async {
    final result = await Navigator.of(context, rootNavigator: rootNavigator)
        .push(route(page, routeStyle: routeStyle));
    return result;
  }

  static Future<dynamic> pushAndRemovePreviousPages(BuildContext context,
      {required Widget page}) async {
    final result = await Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (BuildContext context) => page),
      (route) => false,
    );
    return result;
  }

  static Future<dynamic> pushAndStackNamed(BuildContext context,
      {required String name, bool rootNavigator = false, var arguments}) async {
    final result = await Navigator.of(
      context,
      rootNavigator: rootNavigator,
    ).pushNamed(name, arguments: arguments);
    return result;
  }

  static Future<dynamic> pushNamedAndRemoveUntil(BuildContext context,
      {required String name,
      bool condition = false,
      bool rootNavigator = false}) async {
    final result = await Navigator.of(context, rootNavigator: rootNavigator)
        .pushNamedAndRemoveUntil(name, (route) => condition);
    return result;
  }

  static Future<dynamic> pushAndReplaceName(BuildContext context,
      {required String name, bool rootNavigator = false}) async {
    final result = await Navigator.of(context, rootNavigator: rootNavigator)
        .pushReplacementNamed(name);
    return result;
  }

  static Future<dynamic> popAndPushName(BuildContext context,
      {required String name, bool rootNavigator = false}) async {
    final result = await Navigator.of(context, rootNavigator: rootNavigator)
        .popAndPushNamed(name);
    return result;
  }

  static Route route(Widget page, {required RouteStyle routeStyle}) {
    switch (routeStyle) {
      case RouteStyle.material:
        return MaterialPageRoute(builder: (BuildContext context) => page);
      case RouteStyle.cupertino:
        return CupertinoPageRoute(builder: (BuildContext context) => page);
      case RouteStyle.fadeIn:
        return CustomRoutes.fadeIn(page);
      case RouteStyle.slideIn:
        return CustomRoutes.slideIn(page);
      case RouteStyle.slideUp:
        return CustomRoutes.slideUp(page);
    }
  }
}
