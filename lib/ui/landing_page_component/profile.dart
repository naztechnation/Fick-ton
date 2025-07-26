import 'package:fikkton/res/app_colors.dart';
import 'package:fikkton/res/enum.dart';
import 'package:fikkton/ui/auth/auth.dart';
import 'package:fikkton/ui/widgets/button_view.dart';
import 'package:fikkton/ui/widgets/text_edit_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import '../../blocs/user/user_cubit.dart';
import '../../blocs/user/user_states.dart';
import '../../handlers/secure_handler.dart';
import '../../model/view_models/user_view_model.dart';
import '../../requests/repositories/user_repo/user_repository_impl.dart';
import '../../res/app_images.dart';
import '../../utils/navigator/page_navigator.dart';
import '../admin/main_page.dart';
import '../widgets/empty_widget.dart';
import '../widgets/image_view.dart';
import '../widgets/loading_page.dart';
import '../widgets/modals.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (BuildContext context) => UserCubit(
          userRepository: UserRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child: const Profile(),
    );
  }
}

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String email = '';
  String password = '';
  String phone = '';
  String gender = '';
  String token = '';
  String isAdmin = '';

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final genderController = TextEditingController();

  final FocusNode myFocusNode = FocusNode();
  late UserCubit _userCubit;

  bool isShowPassword = true;
  showPassword() {
    setState(() {
      isShowPassword = !isShowPassword;
    });
  }

  getEmail() async {
    _userCubit = context.read<UserCubit>();

    email = await StorageHandler.getUserEmail() ?? '';
    password = await StorageHandler.getUserPassword() ?? '';
    phone = await StorageHandler.getUserPhone() ?? '';
    gender = await StorageHandler.getUserGender() ?? '';
    token = await StorageHandler.getUserToken() ?? '';
    isAdmin = await StorageHandler.getUserAdmin() ?? '';

    setState(() {
      passwordController.text = password;
    });
  }

  @override
  void initState() {
    getEmail();
    Future.delayed(Duration(milliseconds: 500), () {
      FocusScope.of(context).requestFocus(myFocusNode);
    });
    super.initState();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<UserCubit, UserStates>(listener: (context, state) {
        if (state is ChangePasswordLoaded) {
          if (state.data.status == 1) {
            Modals.showToast(state.data.message ?? '',
                messageType: MessageType.error);
            StorageHandler.saveUserPassword(passwordController.text);
            getEmail();
          } else {}
        }
      }, builder: (context, state) {
        if (state is UserNetworkErr) {
          return EmptyWidget(
            title: 'Network error',
            description: state.message,
            onRefresh: () => changePassword(
              context,
            ),
          );
        } else if (state is UserNetworkErrApiErr) {
          return EmptyWidget(
            title: 'Network error',
            description: state.message,
            onRefresh: () => changePassword(
              context,
            ),
          );
        } else if (state is ChangePasswordLoading) {
          return const LoadingPage();
        }

        return (state is ChangePasswordLoading)
            ? const LoadingPage()
            : SafeArea(
              child: Column(children: [
                  
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ImageView.asset(
                              AppImages.logo,
                              width: 40,
                              height: 40,
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Text(
                              'Fik-kton',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Profile",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Form(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              TextEditView(
                                borderRadius: 16,
                                hintText: email,
                                readOnly: true,
                                controller: emailController,
                                isDense: true,
                                fillColor: const Color(0xfffeee),
                              ),
                              const SizedBox(
                                height: 23,
                              ),
                              TextEditView(
                                borderRadius: 16,
                                controller: phoneController,
                                readOnly: true,
                                hintText: phone,
                                isDense: true,
                                fillColor: const Color(0xfffeee),
                              ),
                              const SizedBox(
                                height: 23,
                              ),
                              TextEditView(
                                borderRadius: 16,
                                hintText: gender,
                                readOnly: true,
                                controller: genderController,
                                isDense: true,
                                fillColor: const Color(0xfffeee),
                              ),
                              const SizedBox(
                                height: 23,
                              ),
                              TextEditView(
                                borderRadius: 16,
                                hintText: 'Password',
                                focusNode: myFocusNode,
                                controller: passwordController,
                                obscureText: isShowPassword,
                                suffixIcon: isShowPassword
                                    ? GestureDetector(
                                        onTap: () {
                                          showPassword();
                                        },
                                        child: Icon(
                                          Ionicons.eye,
                                          color: AppColors.lightPrimary,
                                          size: 25,
                                        ))
                                    : GestureDetector(
                                        onTap: () {
                                          showPassword();
                                        },
                                        child: Icon(
                                          Ionicons.eye_off,
                                          color: AppColors.lightPrimary,
                                          size: 25,
                                        )),
                                isDense: true,
                                fillColor: const Color(0xfffeee),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              ButtonView(
                                onPressed: () {
                                  changePassword(context);
                                },
                                borderRadius: 30,
                                color: Colors.white,
                                borderColor: AppColors.lightSecondary,
                                padding: const EdgeInsets.symmetric(vertical: 20),
                                child: const Text(
                                  'Change Password',
                                  style: TextStyle(
                                      color: AppColors.lightPrimary,
                                      fontSize: 14),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                               if (isAdmin == '1')
                                ButtonView(
                                  onPressed: () {
                                    AppNavigator.pushAndStackPage(context,
                                        page: const AdminMainPage());
                                  },
                                  borderRadius: 30,
                                  color: Colors.white,
                                  borderColor: AppColors.lightSecondary,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: const Text(
                                    'View Admin',
                                    style: TextStyle(
                                        color: AppColors.lightPrimary,
                                        fontSize: 14),
                                  ),
                                ),
                                 const SizedBox(
                                height: 20,
                              ),
                                ButtonView(
                                  onPressed: () {
                                    StorageHandler.clearCache();
                                    AppNavigator.pushAndReplacePage(context,
                                        page: const LoginScreen());
                                  },
                                  borderRadius: 30,
                                  color: Colors.red,
                                  borderColor: Colors.red,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: const Text(
                                    'Log Out',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14),
                                  ),
                                )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ]),
            );
      }),
    );
  }

  changePassword(BuildContext ctx) {
    if (password.trim() != passwordController.text.trim()) {
      ctx
          .read<UserCubit>()
          .changePassword(password: passwordController.text, token: token);
      FocusScope.of(ctx).unfocus();
    } else if (passwordController.text.isEmpty) {
      Modals.showToast('Please enter a password',
          messageType: MessageType.error);
    } else {
      Modals.showToast(
          'please enter a different password from the existing password',
          messageType: MessageType.error);
    }
  }
}
