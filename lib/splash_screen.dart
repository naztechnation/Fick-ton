import 'dart:async';
import 'package:flutter/material.dart';

import 'res/app_colors.dart';
import 'res/app_images.dart';
import 'res/app_routes.dart';
import 'ui/widgets/image_view.dart';
import 'utils/navigator/page_navigator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  var _visible = true;

  late AnimationController animationController;
  late Animation<double> animation;

  startTime() async {
    Future.delayed(
        const Duration(
          seconds: 5,
        ), () {
      navigationPage();
    });
  }

  void navigationPage() {
    AppNavigator.pushAndReplaceName(context, name: AppRoutes.onBoardingScreen);
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() => setState(() {}));
    animationController.forward();

    setState(() {
      _visible = !_visible;
    });
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      AppImages.bg1,
                    ),
                    fit: BoxFit.cover)),
          ),
          Container(
            color: AppColors.lightPrimary.withOpacity(0.97),
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(bottom: 30.0),
                  child: Text(
                    'developed by naztech',
                    style: TextStyle(color: AppColors.cardColor),
                  ))
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ImageView.asset(
                AppImages.logo,
                width: animation.value * 200,
                height: animation.value * 150,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'FIK-KTON',
                style: TextStyle(color: AppColors.cardColor, fontSize: 24),
              )
            ],
          ),
        ],
      ),
    );
  }
}
