

import 'package:fikkton/res/app_images.dart';
import 'package:fikkton/ui/auth/otp_page.dart';
import 'package:fikkton/ui/widgets/image_view.dart';
import 'package:fikkton/utils/navigator/page_navigator.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../res/app_colors.dart';
import '../widgets/button_view.dart';
import '../widgets/text_edit_view.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

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
            'Forgot Password',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 32,
            ),
          ),
          const SizedBox(height: 31),
          const Text(
            'Enter your email address',
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
            Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: TextEditView(
          controller: TextEditingController(text: ''),
          labelText: 'Email',
          prefixIcon: const Icon(
            Ionicons.mail_outline,
            color: Colors.white,
          ),
          filled: false,
          borderColor: Colors.white,
          textColor: Colors.white,
          borderRadius: 16,
          borderWidth: 1,
          isDense: true,
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
          AppNavigator.pushAndStackPage(context, page: const OtpScreen(email: '',));
        },
        child: const Text(
          'Continue',
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
}