
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../splash_screen.dart';
import '../ui/on_boarding/boarding_screen.dart';

class AppRoutes {
  static const String splashScreen = 'splashScreen';
  static const String onBoardingScreen = 'onBoardingScreen';
  static const String welcomeScreen = 'welcomeScreen';
  static const String loginScreen = 'loginScreen';
  static const String landingPage = 'landingPage';

  static Map<String, Widget Function(BuildContext)> routes = {
    splashScreen: (context) => const SplashScreen(),
    onBoardingScreen: (context) => const OnboardingScreen(),
    
  };

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Add your screen here as well as the transition you want
      case splashScreen:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case onBoardingScreen:
        return MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
        );
     
      default:
        return CupertinoPageRoute(
            builder: (context) => errorView(settings.name!));
    }
  }

  static Widget errorView(String name) {
    return Scaffold(body: Center(child: Text('404 $name View not found')));
  }
}
