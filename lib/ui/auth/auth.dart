import 'dart:math' as math;

import 'package:fikkton/res/app_colors.dart';
import 'package:flutter/material.dart';

import '../widgets/login_content.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Widget topWidget(double screenWidth) {
    return Transform.rotate(
      angle: -35 * math.pi / 180,
      child: Container(
        width: 1.2 * screenWidth,
        height: 1.2 * screenWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(150),
          gradient: const LinearGradient(
            begin: Alignment(-0.2, -0.8),
            end: Alignment.bottomCenter,
            colors: [
              Color(0x007CBFCF),
              Color(0xB316BFC4),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomWidget(double screenWidth) {
    return Container(
      width: 1.5 * screenWidth,
      height: 1.5 * screenWidth,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment(0.6, -1.1),
          end: Alignment(0.7, 0.8),
          colors: [
            Color(0xDB4BE8CC),
            Color(0x005CDBCF),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          Container(
               height: MediaQuery.sizeOf(context).height,
                width: MediaQuery.sizeOf(context).width,
             decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.lightSecondary,   
                      AppColors.lightPrimary,   
                    ],
                    stops: [0.1, 0.8],  
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )),
          ),
           
          const LoginContent(),
        ],
      ),
    );
  }
}
