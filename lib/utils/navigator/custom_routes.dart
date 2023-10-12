
import 'package:flutter/material.dart';

class CustomRoutes {

  static Route fadeIn(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 700),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, page) {
        const begin = 0.0;
        const end = 1.0;
        const curve = Curves.easeInExpo;

        final tween =
        Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return FadeTransition(
          opacity: animation.drive(tween),
          child: page,
        );
      },
    );
  }

  static Route slideIn(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(seconds: 4),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, page) {
        const begin = Offset(10, 0);
        const end = Offset.zero;
        const curve = Curves.easeInExpo;

        final tween =
        Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: page,
        );
      },
    );
  }

  static Route slideUp(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, page) {
        const begin =  Offset(0, 1);
        const end = Offset.zero;
        const curve = Curves.ease;

        final tween =
        Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: page,
        );
      },
    );
  }

}