import 'package:fikkton/ui/auth/forgot_password.dart';
import 'package:fikkton/utils/navigator/page_navigator.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../res/app_colors.dart';
import '../../res/app_images.dart';
import '../../utils/change_animation.dart';
import '../../utils/helper_functions.dart';
import 'bottom_text.dart';
import 'button_view.dart';
import 'image_view.dart';
import 'text_edit_view.dart';

enum Screens {
  createAccount,
  welcomeBack,
}

class LoginContent extends StatefulWidget {
  const LoginContent({Key? key}) : super(key: key);

  @override
  State<LoginContent> createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent>
    with TickerProviderStateMixin {
  late final List<Widget> createAccountContent;
  late final List<Widget> loginContent;

  Widget inputField(String hint, IconData iconData) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 8),
      child: SizedBox(
        height: 50,
        child: Material(
          elevation: 8,
          shadowColor: Colors.black87,
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          child: TextField(
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              hintText: hint,
              prefixIcon: Icon(iconData),
            ),
          ),
        ),
      ),
    );
  }

  Widget loginButton(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: ButtonView(
        color: Colors.white,
        borderColor: Colors.white,
        borderRadius: 30,
        onPressed: () {},
        child: Text(
          title,
          style: const TextStyle(color: AppColors.lightSecondary),
        ),
      ),
    );
  }

  Widget orDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 130, vertical: 8),
      child: Row(
        children: [
          Flexible(
            child: Container(
              height: 1,
              color: AppColors.lightSecondary,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'or',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Flexible(
            child: Container(
              height: 1,
              color: AppColors.lightSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget logos() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/facebook.png'),
          const SizedBox(width: 24),
          Image.asset('assets/images/google.png'),
        ],
      ),
    );
  }

  Widget forgotPassword() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 110),
      child: TextButton(
        onPressed: () {
          AppNavigator.pushAndStackPage(context, page: const ForgotPasswordScreen());
        },
        child: const Text(
          'Forgot Password?',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.lightSecondary,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    createAccountContent = [
       const Text(
            'Sign Up',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 32,
            ),
          ),
          const SizedBox(height: 25),
          const Text(
            'Enter your email and password\n to create an account',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 32),

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
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: TextEditView(
          controller: TextEditingController(text: ''),
          labelText: 'Phone Number',
          prefixIcon: const Icon(
            Ionicons.call_outline,
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
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: TextEditView(
          controller: TextEditingController(text: ''),
          labelText: 'Gender',
          prefixIcon: const Icon(
            Ionicons.male_female_outline,
            color: Colors.white,
          ),
          suffixIcon: const Icon(Icons.arrow_drop_down,
          size: 32,
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
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: TextEditView(
          controller: TextEditingController(text: ''),
          labelText: 'Password',
          prefixIcon: const Icon(
            Ionicons.lock_closed_outline,
            color: Colors.white,
          ),
          suffixIcon: const Icon(Ionicons.eye, 
          
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
      const SizedBox(
        height: 20,
      ),
      loginButton('Sign Up'),
      // orDivider(),
      // logos(),
    ];

    loginContent = [
       const Text(
            'Sign In',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 32,
            ),
          ),
          const SizedBox(height: 25),
          const Text(
            'Please enter your email and\n password to login',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 32),

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
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: TextEditView(
          controller: TextEditingController(text: ''),
          labelText: 'Password',
          prefixIcon: const Icon(
            Ionicons.lock_closed_outline,
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
      const SizedBox(
        height: 20,
      ),
      loginButton('Sign In'),
      forgotPassword(),
    ];

    ChangeScreenAnimation.initialize(
      vsync: this,
      createAccountItems: createAccountContent.length,
      loginItems: loginContent.length,
    );

    for (var i = 0; i < createAccountContent.length; i++) {
      createAccountContent[i] = HelperFunctions.wrapWithAnimatedBuilder(
        animation: ChangeScreenAnimation.createAccountAnimations[i],
        child: createAccountContent[i],
      );
    }

    for (var i = 0; i < loginContent.length; i++) {
      loginContent[i] = HelperFunctions.wrapWithAnimatedBuilder(
        animation: ChangeScreenAnimation.loginAnimations[i],
        child: loginContent[i],
      );
    }

    super.initState();
  }

  @override
  void dispose() {
    ChangeScreenAnimation.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.08,
          ),
          const ImageView.svg(
            AppImages.logo,
            width: 100,
            height: 100,
          ), 
         
          Padding(
            padding: const EdgeInsets.only(top: 32),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: createAccountContent,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: loginContent,
                ),
              ],
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 50),
              child: BottomText(),
            ),
          ),
        ],
      ),
    );
  }
}
