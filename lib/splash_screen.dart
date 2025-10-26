import 'dart:async';
import 'package:fikkton/ui/auth/auth.dart';
import 'package:fikkton/ui/auth/otp_page.dart';
import 'package:flutter/material.dart';

import 'handlers/secure_handler.dart';
import 'res/app_colors.dart';
import 'res/app_images.dart';
import 'res/app_routes.dart';
import 'ui/admin/new_post_page.dart';
import 'ui/landing_page_component/main_page.dart';
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

  bool userLoggedIn = false;
  String isOnBoarding = '';

  String token = '';

  getUserDetails() async {
    token = await StorageHandler.getUserToken() ?? '';
    userLoggedIn = await StorageHandler.isLoggedIn();
    isOnBoarding = await StorageHandler.getOnBoardState();
  }

  startTime() async {
    Future.delayed(
        const Duration(
          seconds: 5,
        ), () {
      navigationPage();
    });
  }

  void navigationPage() {
    // AppNavigator.pushAndReplacePage(context, page: MovieArticleUploadPage());

    if (isOnBoarding == '') {
      AppNavigator.pushAndReplaceName(context,
          name: AppRoutes.onBoardingScreen);
    } else if (userLoggedIn) {
      AppNavigator.pushAndReplacePage(context,
          page: LandingPage(
            token: token,
          ));
    } else {
      StorageHandler.logout();
      StorageHandler.saveUserToken("");
      AppNavigator.pushAndReplacePage(context, page: LandingPage(token: token));
    }
  }

  @override
  void initState() {
    super.initState();

    getUserDetails();
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
            color: Colors.black.withOpacity(0.8),
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ImageView.asset(
                AppImages.logo,
                width: animation.value * 200,
                height: animation.value * 150,
              ),
              // const SizedBox(
              //   height: 20,
              // ),
              // const Text(
              //   'Mulo',
              //   style: TextStyle(color: AppColors.cardColor, fontSize: 24),
              // )
            ],
          ),
        ],
      ),
    );
  }
}
