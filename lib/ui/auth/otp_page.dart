


import 'package:fikkton/res/app_images.dart';
import 'package:fikkton/ui/auth/reset_password.dart';
import 'package:fikkton/ui/widgets/image_view.dart';
import 'package:fikkton/utils/navigator/page_navigator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../res/app_colors.dart';
import '../../res/app_strings.dart';
import '../widgets/button_view.dart';
import '../widgets/pin_code_view.dart';
import '../widgets/text_edit_view.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  final _formKey = GlobalKey<FormState>();

  bool isCountdownComplete = false;
  int countdown = 60;

  final _pinController = TextEditingController();

  @override
  void initState() {
    startCountdown();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: SingleChildScrollView(
        child: Container(
            height: MediaQuery.sizeOf(context).height,
                width: MediaQuery.sizeOf(context).width,
             decoration:   const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.lightSecondary,   
                      AppColors.lightPrimary,   
                    ],
                    stops: [0.1, 0.8],  
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )),
          child: Column(
            children: [
               SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.05,
          ),
             GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
               child: const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: ImageView.svg(AppImages.arrowBack),
                )),
             ),
               SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.18,
          ),
            
          const Text(
            'Check Your Email',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 32,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'We’ve sent a code to\n chima********@gmail.com',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
           const  SizedBox(
            height:61,
          ),
           Form(
                key: _formKey,
                child: Padding(
                  padding:   EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width * 0.14),
                  child: PinCodeView(
                    length: 4,
                    controller: _pinController,
                    onChanged: (_) {},
                    onCompleted: (_) {},
                    // validator: Validator.validate
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {},
                  child: Text.rich(
                      TextSpan(
                          text: (!isCountdownComplete) ? 'Send Code again' : '',
                          style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.lightSecondary,
                              fontWeight: FontWeight.w400,
                              fontFamily: AppStrings.montserrat,
                              height: 2),
                          children: [
                            if (!isCountdownComplete) 
                              TextSpan(
                                  text: ' in $countdown seconds',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: AppColors.lightSecondary,
                              fontFamily: AppStrings.montserrat,

                                    fontWeight: FontWeight.w500,
                                  )),
                              const TextSpan(
                                      text: '',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                              fontFamily: AppStrings.montserrat,

                                        fontWeight: FontWeight.w500,
                                      )),
                                  
                                if (isCountdownComplete)   TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                         
                                        },
                                      text: '  Resend  ',
                                      style: const TextStyle(
                                          fontSize: 18,
                                          color: AppColors.lightSecondary,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: AppStrings.interSans,
                                          height: 2),
                                    )
                          ]),
                      textAlign: TextAlign.start),
                ),
              ),
      const Spacer(),
      Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: ButtonView(
        color: Colors.white,
        borderColor: Colors.white,
        borderRadius: 30,
        onPressed: () {
          AppNavigator.pushAndStackPage(context, page:const ResetPasswordScreen());
        },
        child: const Text(
          'Change Password',
          style: TextStyle(color: AppColors.lightSecondary),
        ),
      ),
    ),
    const SizedBox(height: 100,)
            ],
          )),
      ),
    );
  }

   Future<void> startCountdown() async {
    for (int i = 60; i >= 0; i--) {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        countdown = i;
      });
    }
    setState(() {
      isCountdownComplete = true;
    });
  }

  
}