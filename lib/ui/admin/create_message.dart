import 'dart:io';

import 'package:fikkton/res/app_colors.dart';
import 'package:fikkton/ui/widgets/button_view.dart';
import 'package:fikkton/ui/widgets/image_container.dart';
import 'package:fikkton/ui/widgets/image_view.dart';
import 'package:fikkton/ui/widgets/text_edit_view.dart';
import 'package:fikkton/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../res/app_images.dart';
import '../../blocs/user/user_cubit.dart';
import '../../blocs/user/user_states.dart';
import '../../model/view_models/account_view_model.dart';
import '../../model/view_models/user_view_model.dart';
import '../../requests/repositories/user_repo/user_repository_impl.dart';
import '../../res/enum.dart';
import '../widgets/modals.dart';
import '../widgets/progress_indicator.dart';

class createMessage extends StatefulWidget {
  const createMessage({super.key});

  @override
  State<createMessage> createState() => _createMessageState();
}

class _createMessageState extends State<createMessage> {
  bool isChecked = false;

  int isTrending = 0;

  final _formKey = GlobalKey<FormState>();
 
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserViewModel>(context, listen: false);
    final setToken = Provider.of<AccountViewModel>(context, listen: false);
    setToken.getToken();

    return Scaffold(
        body: BlocProvider<UserCubit>(
      lazy: false,
      create: (_) => UserCubit(
          userRepository: UserRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child: BlocConsumer<UserCubit, UserStates>(
        listener: (context, state) {
          if (state is CreatePostLoaded) {
            if (state.createPost.status == 1) {
              Modals.showToast(state.createPost.message!,
                  messageType: MessageType.success);
              
              clearFields();
            } else {
              Modals.showToast(state.createPost.message!,
                  messageType: MessageType.error);
            }
          } else if (state is UserNetworkErr) {
            if (state.message != null) {
              Modals.showToast(state.message!, messageType: MessageType.error);
            }
          } else if (state is UserNetworkErrApiErr) {
            if (state.message != null) {
              Modals.showToast(state.message!, messageType: MessageType.error);
            }
          }
        },
        builder: (context, state) => Column(
          children: [
            SafeArea(
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.03,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Align(
                          alignment: Alignment.topLeft,
                          child: ImageView.svg(
                            AppImages.arrowBack,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      const ImageView.asset(
                        AppImages.logo,
                        width: 40,
                        height: 40,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      const Text(
                        'Fik-kton',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 25,
                        ),
                        const Text(
                          "Title",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextEditView(
                          borderRadius: 16,
                          controller: titleController,
                          validator: Validator.validate,
                          isDense: true,
                          fillColor: Colors.grey.shade200,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        const Text(
                          "Content",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextEditView(
                          maxLines: 10,
                          hintText: 'Start writing your content here...',
                          validator: Validator.validate,
                          borderRadius: 16,
                          controller: contentController,
                          isDense: true,
                          fillColor: Colors.grey.shade200,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        (state is CreatePostLoading)
                            ? Align(
                                alignment: Alignment.center,
                                child: ProgressIndicators.circularProgressBar(
                                    context))
                            : Column(
                                children: [
                                  ButtonView(
                                    onPressed: () {

                                       
                                      _verifyCode(
                                        context,
                                        setToken.token,
                                      );
                                    },
                                    color: AppColors.lightSecondary,
                                    child: const Text('Send'),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                ],
                              ),
                        const SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  _verifyCode(BuildContext ctx, String token) {
    if (_formKey.currentState!.validate()) {
      ctx.read<UserCubit>().createNotification(
            title: titleController.text,
            token: token,
            content: contentController.text,
          );
      FocusScope.of(ctx).unfocus();
    }
  }

  clearFields() {
    titleController.text = "";
    contentController.text = "";
    
  }
}
