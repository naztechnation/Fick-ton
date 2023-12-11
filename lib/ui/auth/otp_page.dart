import 'package:fikkton/res/app_images.dart';
import 'package:fikkton/ui/auth/auth.dart';
import 'package:fikkton/ui/auth/reset_password.dart';
import 'package:fikkton/ui/widgets/image_view.dart';
import 'package:fikkton/utils/navigator/page_navigator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../blocs/accounts/account.dart';
import '../../model/view_models/account_view_model.dart';
import '../../requests/repositories/account_repo/account_repository_impl.dart';
import '../../res/app_colors.dart';
import '../../res/app_strings.dart';
import '../../res/enum.dart';
import '../../utils/validator.dart';
import '../widgets/button_view.dart';
import '../widgets/modals.dart';
import '../widgets/pin_code_view.dart';

class OtpScreen extends StatefulWidget {
  final bool isForgotPassword;
  
  final String email;
  const OtpScreen(
      {super.key, required this.email, required this.isForgotPassword});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _formKey = GlobalKey<FormState>();

  bool isCountdownComplete = false;
  int countdown = 180;

  bool isResetPassword = false;

  final _pinController = TextEditingController();

  @override
  void initState() {
    startCountdown();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final getToken = Provider.of<AccountViewModel>(context, listen: true);

    getToken.getToken();
    

    return Scaffold(
        body: BlocProvider<AccountCubit>(
      lazy: false,
      create: (_) => AccountCubit(
          accountRepository: AccountRepositoryImpl(),
          viewModel: Provider.of<AccountViewModel>(context, listen: false)),
      child: BlocConsumer<AccountCubit, AccountStates>(
        listener: (context, state) {
          if (state is AccountLoaded) {
            if (state.userData.status == 1) {
              if (widget.isForgotPassword) {
                Modals.showToast('Token verified Successfully.',
                    messageType: MessageType.success);
                AppNavigator.pushAndReplacePage(context,
                    page: ResetPasswordScreen(
                      email: widget.email,
                      token: state.userData.token ?? '',
                    ));
              }else if (isResetPassword){
                 Modals.showToast(state.userData.message ?? '',
                    messageType: MessageType.success);
                     getToken.setToken(state.userData.token ?? '');
                     startCountdown();

              } else {
                AppNavigator.pushAndReplacePage(context,
                    page: const LoginScreen());
                Modals.showToast(state.userData.message ?? '',
                    messageType: MessageType.success);
              }
            } else {
              Modals.showToast(state.userData.message ?? '',
                  messageType: MessageType.error);
            }
          } else if (state is AccountApiErr) {
            if (state.message != null) {
              Modals.showToast(state.message ?? '', messageType: MessageType.error);
            }
          } else if (state is AccountNetworkErr) {
            if (state.message != null) {
              Modals.showToast(state.message ?? '', messageType: MessageType.error);
            }
          }
        },
        builder: (context, state) => SingleChildScrollView(
          child: Container(
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
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.05,
                  ),
                  GestureDetector(
                    onTap: () {
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
                  Text(
                    'We’ve sent a code to\n ${replaceSubstring(
                      widget.email,
                    )}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    height: 61,
                  ),
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.sizeOf(context).width * 0.14),
                      child: PinCodeView(
                          length: 4,
                          controller: _pinController,
                          onChanged: (_) {},
                          onCompleted: (_) {
                            //_verifyCode(context, token);
                          },
                          validator: Validator.validate),
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
                                  fontFamily: AppStrings.urbanist,
                                  height: 2),
                              children: [
                                if (!isCountdownComplete)
                                  TextSpan(
                                      text: ' in $countdown seconds',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                  fontFamily: AppStrings.urbanist,

                                        fontWeight: FontWeight.w500,
                                      )),
                                  const TextSpan(
                                          text: '',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                  fontFamily: AppStrings.urbanist,

                                            fontWeight: FontWeight.w500,
                                          )),

                                     if (isCountdownComplete) 
                                      TextSpan(
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              forgotPassword(context);
                                            },
                                          text: (state is AccountProcessing) ? '':'Resend',
                                          style: const TextStyle(
                                              fontSize: 18,
                                              
                                              color: AppColors.lightSecondary,
                                              decoration: TextDecoration.underline,
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: ButtonView(
                      color: Colors.white,
                      borderColor: Colors.white,
                      processing: state is AccountLoading || state is AccountProcessing,
                      borderRadius: 30,
                      onPressed: () {
                        _verifyCode(context, getToken.token);
                      },
                      child: const Text(
                        'Verify Code',
                        style: TextStyle(color: AppColors.lightSecondary),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  )
                ],
              )),
        ),
      ),
    ));
  }

  Future<void> startCountdown() async {
    
    for (int i = 180; i >= 0; i--) {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        countdown = i;
      });
    }
    setState(() {
      isCountdownComplete = true;
    });
  }

  _verifyCode(BuildContext ctx, String token) async{

    if (_formKey.currentState!.validate()) {
     await ctx
          .read<AccountCubit>()
          .verifyCode(code: _pinController.text, token: token);

           setState(() {
            isResetPassword = false;
          });
      FocusScope.of(ctx).unfocus();
    }
  }

  String replaceSubstring(String input) {
    input = input.replaceRange(3, 6, '****');

    return input;
  }

  forgotPassword(BuildContext ctx) async{
   
    await  ctx.read<AccountCubit>().forgotPassword(
            email: widget.email, 
          );
          

          setState(() {
            isResetPassword = true;
          });
      FocusScope.of(ctx).unfocus();
    
  }
}
