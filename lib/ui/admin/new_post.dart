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
import '../../blocs/accounts/account.dart';
import '../../blocs/user/user_cubit.dart';
import '../../blocs/user/user_states.dart';
import '../../model/view_models/account_view_model.dart';
import '../../model/view_models/user_view_model.dart';
import '../../requests/repositories/account_repo/account_repository_impl.dart';
import '../../requests/repositories/user_repo/user_repository_impl.dart';
import '../../res/enum.dart';
import '../../utils/navigator/page_navigator.dart';
import '../auth/auth.dart';
import '../widgets/modals.dart';
import '../widgets/progress_indicator.dart';

class NewPost extends StatefulWidget {
  const NewPost({super.key});

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  bool isChecked = false;

  int isTrending = 0;

  final _formKey = GlobalKey<FormState>();

  void _toggleCheckbox(bool? value) {
    setState(() {
      isChecked = value!;
      if (isChecked) {
        isTrending = 1;
      } else {
        isTrending = 0;
      }
    });
  }

  final videoUrlController = TextEditingController();
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final genresController = TextEditingController();
  final authorController = TextEditingController();

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
                user.imageURl = null;
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
        builder: (context, state) => Form(
          key: _formKey,
          child: Column(
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 14,
                        ),
                        const Align(
                          child: Text(
                            'New Post',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          "Add Cover Image",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CoverImageContainer(),
                        const SizedBox(
                          height: 20,
                        ),

                        const Text(
                          "Video URL",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextEditView(
                          borderRadius: 16,
                          controller: videoUrlController,
                          validator: Validator.validate,
                          isDense: true,
                          fillColor: Colors.grey.shade200,
                        ),
                        
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
                          "Article",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextEditView(
                          maxLines: 20,
                          hintText: 'Start writing your article here...',
                          validator: Validator.validate,
                          borderRadius: 16,
                          controller: contentController,
                          isDense: true,
                          fillColor: Colors.grey.shade200,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        const Text(
                          "Author",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextEditView(
                          onChanged: (value) {},
                          validator: Validator.validate,
                          hintText: 'Enter Author',
                          borderRadius: 16,
                          controller: authorController,
                          isDense: true,
                          fillColor: Colors.grey.shade200,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        const Text(
                          "Genres",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextEditView(
                          onChanged: (value) {},
                          validator: Validator.validate,
                          hintText: 'Enter Genres',
                          borderRadius: 16,
                          controller: genresController,
                          isDense: true,
                          fillColor: Colors.grey.shade200,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          children: [
                            Center(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    isChecked = !isChecked;
                                  });
                                },
                                child: Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    border: Border.all(
                                      color: AppColors.lightSecondary,
                                      width: 2,
                                    ),
                                    color: isChecked
                                        ? AppColors.lightSecondary
                                        : Colors.white,
                                  ),
                                  child: isChecked
                                      ? const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 20,
                                        )
                                      : const SizedBox(),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            const Text(
                              "Make it Trending",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                    (state is CreatePostLoading)  ? Align(
                      alignment: Alignment.center,
                      child: ProgressIndicators.circularProgressBar(context)) : Column(
                          children: [
                            ButtonView(
                              onPressed: () {
                                if (user.imageURl != null) {
                                  _verifyCode(
                                      context, setToken.token, user.imageURl!, '1');
                                } else {
                                  Modals.showToast('please upload image');
                                }
                              },
                              color: AppColors.lightPrimary,
                              child: const Text('Publish'),
                            ),
                             const SizedBox(
                          height: 15,
                        ),
                        ButtonView(
                          onPressed: () {
                            if (user.imageURl != null) {
                              _verifyCode(
                                  context, setToken.token, user.imageURl!, '0');
                            } else {
                              Modals.showToast('please upload image');
                            }
                          },
                          
                          color: Colors.white,
                          borderColor: AppColors.lightPrimary,
                          child: const Text(
                            'Save to Draft',
                            style: TextStyle(color: AppColors.lightPrimary),
                          ),
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
            ],
          ),
        ),
      ),
    ));
  }

  _verifyCode(BuildContext ctx, String token, File thumbnail, String status) {
    if (_formKey.currentState!.validate()) {
      ctx.read<UserCubit>().createPost(
            title: titleController.text,
            token: token,
            content: contentController.text,
            videoLink: videoUrlController.text,
            thumbnail: thumbnail,
            genre: genresController.text,
            status: status,
            author: authorController.text,
            trending: isTrending.toString(),
          );
      FocusScope.of(ctx).unfocus();
    }
  }

  clearFields() {
    titleController.text = "";
    contentController.text = "";
    videoUrlController.text = "";
    genresController.text = "";
    authorController.text = "";
  }
}
