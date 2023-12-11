import 'package:fikkton/ui/auth/forgot_password.dart';
import 'package:fikkton/ui/landing_page_component/main_page.dart';
import 'package:fikkton/utils/navigator/page_navigator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import '../../blocs/accounts/account.dart';
import '../../handlers/secure_handler.dart';
import '../../model/view_models/account_view_model.dart';
import '../../requests/repositories/account_repo/account_repository_impl.dart';
import '../../res/app_colors.dart';
import '../../res/app_images.dart';
import '../../res/enum.dart';
import '../../utils/validator.dart';
import '../auth/otp_page.dart';
import 'button_view.dart';
import 'image_view.dart';
import 'modals.dart';
import 'text_edit_view.dart';

class LoginContent extends StatefulWidget {
  const LoginContent({Key? key}) : super(key: key);

  @override
  State<LoginContent> createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _genderController = TextEditingController();
  final _phoneController = TextEditingController();

  bool isShowPassword = true;

  showPassword() {
    setState(() {
      isShowPassword = !isShowPassword;
    });
  }

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

  bool isLogin = true;

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
    return TextButton(
      onPressed: () {
        AppNavigator.pushAndStackPage(context,
            page: const ForgotPasswordScreen());
      },
      child: Align(
        alignment: Alignment.center,
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

  List<String> gender = [
    'Female',
    'Male',
  ];
  @override
  Widget build(BuildContext context) {
    final setToken = Provider.of<AccountViewModel>(context, listen: false);

    return BlocProvider<AccountCubit>(
        lazy: false,
        create: (_) => AccountCubit(
            accountRepository: AccountRepositoryImpl(),
            viewModel: Provider.of<AccountViewModel>(context, listen: false)),
        child: BlocConsumer<AccountCubit, AccountStates>(
          listener: (context, state) {
            if (state is AccountLoaded) {
              if (state.userData.status == 1) {
                setToken.setToken(state.userData.token!);
                StorageHandler.saveUserEmail(_emailController.text);
                Modals.showToast(state.userData.message ?? '',
                    messageType: MessageType.success);
                    FirebaseMessaging messaging = FirebaseMessaging.instance;
                messaging.subscribeToTopic('subscribed_users');
                AppNavigator.pushAndReplacePage(context,
                    page: OtpScreen(
                      email: _emailController.text.trim(),
                      isForgotPassword: false,
                    ));

                
                clearTextViews();
              } else {
                Modals.showToast(state.userData.message ?? '',
                    messageType: MessageType.success);
              }
            }
            if (state is AccountUpdated) {
              if (state.user.status == 1) {
                if (state.user.data!.status! == '1') {
                  setToken.setToken(state.user.token ?? '');
                  StorageHandler.saveUserEmail(_emailController.text);
                  StorageHandler.saveUserPassword(_passwordController.text);
                  StorageHandler.saveUserGender(state.user.data?.gender ?? '');
                  StorageHandler.saveUserPhone(state.user.data?.phone ?? '');
                  StorageHandler.saveUserAdmin(state.user.data?.isAdmin ?? '');
                  Modals.showToast(
                    state.user.message ?? '',
                  );
                  StorageHandler.login();
                  AppNavigator.pushAndReplacePage(context,
                      page: const LandingPage());
                } else {
                  Modals.showToast(state.user.message ?? '',
                      messageType: MessageType.success);
                }
              } else {
                Modals.showToast(state.user.message ?? '',
                    messageType: MessageType.success);
              }
            } else if (state is AccountApiErr) {
              if (state.message != null) {
                Modals.showToast(state.message ?? '',
                    messageType: MessageType.error);
              }
            } else if (state is AccountNetworkErr) {
              if (state.message != null) {
                Modals.showToast(state.message ?? '',
                    messageType: MessageType.error);
              }
            }
          },
          builder: (context, state) => SingleChildScrollView(
            child: Form(
              key: _formKey,
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
                    child: Column(
                      children: [
                        Visibility(
                          visible: !isLogin,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 12),
                                child: TextEditView(
                                  controller: _emailController,
                                  validator: Validator.validate,
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 12),
                                child: TextEditView(
                                  controller: _phoneController,
                                  validator: Validator.validate,
                                  keyboardType: TextInputType.phone,
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 12),
                                child: TextEditView(
                                  controller: _genderController,
                                  labelText: 'Gender',
                                  validator: Validator.validate,
                                  readOnly: true,
                                  onTap: () {
                                    Modals.showBottomSheetModal(context,
                                        isDissmissible: true,
                                        heightFactor: 0.3,
                                        page: selectGender());
                                  },
                                  prefixIcon: const Icon(
                                    Ionicons.male_female_outline,
                                    color: Colors.white,
                                  ),
                                  suffixIcon: const Icon(
                                    Icons.arrow_drop_down,
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 12),
                                child: TextEditView(
                                  controller: _passwordController,
                                  validator: Validator.validate,
                                  labelText: 'Password',
                                  obscureText: isShowPassword,
                                  suffixIcon: isShowPassword
                                      ? GestureDetector(
                                          onTap: () {
                                            showPassword();
                                          },
                                          child: Icon(
                                            Ionicons.eye,
                                            color: Colors.white,
                                            size: 25,
                                          ))
                                      : GestureDetector(
                                          onTap: () {
                                            showPassword();
                                          },
                                          child: Icon(
                                            Ionicons.eye_off,
                                            color: Colors.white,
                                            size: 25,
                                          )),
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
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                                child: ButtonView(
                                  color: Colors.white,
                                  processing: state is AccountProcessing,
                                  borderColor: Colors.white,
                                  borderRadius: 30,
                                  onPressed: () {
                                    _registerUser(context);
                                  },
                                  child: const Text(
                                    'Sign Up',
                                    style: TextStyle(
                                        color: AppColors.lightSecondary),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: isLogin,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text(
                                'Log In',
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 12),
                                child: TextEditView(
                                  controller: _emailController,
                                  validator: Validator.validateEmail,
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 12),
                                child: TextEditView(
                                  controller: _passwordController,
                                  validator: Validator.validate,
                                  obscureText: isShowPassword,
                                  labelText: 'Password',
                                  prefixIcon: const Icon(
                                    Ionicons.lock_closed_outline,
                                    color: Colors.white,
                                  ),
                                  suffixIcon: isShowPassword
                                      ? GestureDetector(
                                          onTap: () {
                                            showPassword();
                                          },
                                          child: Icon(
                                            Ionicons.eye,
                                            color: Colors.white,
                                            size: 25,
                                          ))
                                      : GestureDetector(
                                          onTap: () {
                                            showPassword();
                                          },
                                          child: Icon(
                                            Ionicons.eye_off,
                                            color: Colors.white,
                                            size: 25,
                                          )),
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
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                                child: ButtonView(
                                  color: Colors.white,
                                  processing: state is AccountLoading,
                                  borderColor: Colors.white,
                                  borderRadius: 30,
                                  onPressed: () {
                                    _loginUser(context);
                                  },
                                  child: const Text(
                                    'Log In',
                                    style: TextStyle(
                                        color: AppColors.lightSecondary),
                                  ),
                                ),
                              ),
                              forgotPassword(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isLogin = !isLogin;
                      });
                    },
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 50),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'Montserrat',
                              ),
                              children: [
                                TextSpan(
                                  text: isLogin
                                      ? 'Don\'t have an account?  '
                                      : 'Already have an account?  ',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(
                                  text: isLogin ? 'Sign Up' : 'Log In',
                                  style: const TextStyle(
                                    color: AppColors.lightSecondary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  _registerUser(BuildContext ctx) {
    if (_formKey.currentState!.validate()) {
      ctx.read<AccountCubit>().registerUser(
          gender: _genderController.text.trim(),
          phoneNumber: _phoneController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
      FocusScope.of(ctx).unfocus();
    }
  }

  _loginUser(BuildContext ctx) {
    if (_formKey.currentState!.validate()) {
      ctx.read<AccountCubit>().loginUser(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
      FocusScope.of(ctx).unfocus();
    }
  }

  selectGender() {
    return ListView.builder(
        itemCount: gender.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _genderController.text = gender[index];
                Navigator.pop(context);
              });
            },
            child: Container(
                height: 50,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom:
                        BorderSide(color: AppColors.lightPrimary, width: 0.3),
                  ),
                ),
                child: Center(
                    child: Text(
                  gender[index],
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.lightSecondary),
                ))),
          );
        });
  }

  clearTextViews() {
    setState(() {
      _emailController.clear();
      _phoneController.clear();
      _genderController.clear();
      _passwordController.clear();
    });
  }
}
