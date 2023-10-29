import 'dart:io';

import 'package:fikkton/res/app_colors.dart';
import 'package:fikkton/ui/widgets/button_view.dart';
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
import '../widgets/image_container.dart';
import '../widgets/modals.dart';
import '../widgets/progress_indicator.dart';

class CreateAnnouncement extends StatefulWidget {
  const CreateAnnouncement({super.key});

  @override
  State<CreateAnnouncement> createState() => _AnnounceState();
}

class _AnnounceState extends State<CreateAnnouncement> {
  bool isChecked = false;

  int isTrending = 0;

  final _formKey = GlobalKey<FormState>();
 
  final thumbnailController = TextEditingController();
  final videoLinkController = TextEditingController();
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
              user.clearImage();
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
        builder: (context, state) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               SafeArea(
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.03,
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
                      height: 25,
                    ),
                    const Text(
                      "Video link",
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextEditView(
                      borderRadius: 16,
                      controller: videoLinkController,
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

                                   
                                  createAnnouncement(
                                    context,
                                    setToken.token,
                                    user.imageURl
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
      ))));
  }

  createAnnouncement(BuildContext ctx, String token,File? thumbnail) {
    if (_formKey.currentState!.validate()) {
      ctx.read<UserCubit>().createAnnouncement(
            thumbnail: thumbnail,
            token: token,
            videoLink: videoLinkController.text,
            content: contentController.text,
          );
      FocusScope.of(ctx).unfocus();
    }
  }

  clearFields() {
    videoLinkController.text = "";
    contentController.text = "";
    
  }
}
