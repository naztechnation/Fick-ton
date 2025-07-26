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
import '../../handlers/secure_handler.dart';
import '../../model/posts/post_details.dart';
import '../../model/view_models/account_view_model.dart';
import '../../model/view_models/user_view_model.dart';
import '../../requests/repositories/user_repo/user_repository_impl.dart';
import '../../res/app_strings.dart';
import '../../res/enum.dart';
import '../landing_page_component/homepage/widgets/filter_modal.dart';
import '../widgets/loading_page.dart';
import '../widgets/modals.dart';
import '../widgets/progress_indicator.dart';
import 'widget/image1.dart';

class NewPost extends StatelessWidget {
  final bool isUpdate;
  final String postId;
  const NewPost({
    Key? key,
    required this.isUpdate,
    required this.postId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (BuildContext context) => UserCubit(
          userRepository: UserRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child: Post(
        isUpdate: isUpdate,
        postId: postId,
      ),
    );
  }
}

class Post extends StatefulWidget {
  final bool isUpdate;
  final String postId;

  const Post({super.key, required this.isUpdate, required this.postId});

  @override
  State<Post> createState() => _NewPostState();
}

class _NewPostState extends State<Post> {
  bool isChecked = false;

  int isTrending = 0;

  final _formKey = GlobalKey<FormState>();
  late UserCubit _userCubit;
  Data? postDetails;

  String token = '';
  String postId = '';

  bool isLoading = false;
  getPosts() async {
    _userCubit = context.read<UserCubit>();

    token = await StorageHandler.getUserToken() ?? '';

    setState(() {
      isLoading = true;
    });
    await _userCubit.getPostDetails(token: token, postId: widget.postId);

    setState(() {
      isLoading = false;
    });
  }

  List<String> filterByList = [];
  List<String> genresList = [];

  String recent = 'Recent';
  String genres = 'All Genres';

  final videoUrlController = TextEditingController();
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final content2Controller = TextEditingController();
  final genresController = TextEditingController();
  final authorController = TextEditingController();

  @override
  void initState() {
      Provider.of<UserViewModel>(context, listen: false).clearImage();
            Provider.of<UserViewModel>(context, listen: false).clearImage1();
            Provider.of<UserViewModel>(context, listen: false).clearImage2();
    if (widget.isUpdate) {
      getPosts();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserViewModel>(context, listen: true);
    final setToken = Provider.of<AccountViewModel>(context, listen: false);
    setToken.getToken();

    return Scaffold(
      body: BlocConsumer<UserCubit, UserStates>(listener: (context, state) {
        if (state is CreatePostLoaded) {
          if (state.createPost.status == 1) {
            Modals.showToast(state.createPost.message ?? '',
                messageType: MessageType.success);
            user.imageURl = null;
            user.imageURl2 = null;
            user.imageURl1 = null;
            clearFields();
            user.clearImage();
            user.clearImage1();
            user.clearImage2();
             
          } else {}
        } else if (state is PostDetailsLoaded) {
          // Modals.showToast(state.postDetails.message ?? '',
          //     messageType: MessageType.success);
          if (state.postDetails.status == 1) {
            titleController.text = state.postDetails.data?.title ?? '';
            contentController.text = state.postDetails.data?.content ?? '';
            content2Controller.text = state.postDetails.data?.content2 ?? '';
            videoUrlController.text = state.postDetails.data?.videoLink ?? '';
            genresController.text = state.postDetails.data?.genre ?? '';
            authorController.text = state.postDetails.data?.author ?? '';
            postId = state.postDetails.data?.id ?? '';
            isChecked =
                state.postDetails.data?.isTrending == "0" ? false : true;
            isTrending = int.parse(state.postDetails.data?.isTrending ?? '');

            user.fileFromImageUrl(state.postDetails.data?.thumbnail ?? '');
            user.fileFromImageUrl1(state.postDetails.data?.image1 ?? '');
            user.fileFromImageUrl2(state.postDetails.data?.image2 ?? '');
          } else {}
        }
      }, builder: (context, state) {
        if (state is PostDetailsLoaded) {
          if (state.postDetails.status == 1) {
          } else {}
        }

        return (isLoading)
            ? const LoadingPage()
            : SafeArea(
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
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
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
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
                                // const SizedBox(
                                //   height: 20,
                                // ),
                                // const Text(
                                //   "Video URL",
                                //   style: TextStyle(
                                //       fontSize: 16, fontWeight: FontWeight.w400),
                                // ),
                                // const SizedBox(
                                //   height: 5,
                                // ),
                                // TextEditView(
                                //   borderRadius: 16,
                                //   controller: videoUrlController,
                                //   validator: Validator.validate,
                                //   isDense: true,
                                //   fillColor: Colors.grey.shade200,
                                // ),
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
                                  height: 20,
                                ),
                                const Text(
                                  "Article1",
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextEditView(
                                  maxLines: 9,
                                  hintText: 'Start writing your article here...',
                                  validator: Validator.validate,
                                  borderRadius: 16,
                                  controller: contentController,
                                  isDense: true,
                                  fillColor: Colors.grey.shade200,
                                ),
              
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  "Article2",
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextEditView(
                                  maxLines: 9,
                                  hintText: 'Start writing your article here...',
                                  validator: Validator.validate,
                                  borderRadius: 16,
                                  controller: content2Controller,
                                  isDense: true,
                                  fillColor: Colors.grey.shade200,
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                // const Text(
                                //   "Types",
                                //   style: TextStyle(
                                //       fontSize: 16, fontWeight: FontWeight.w400),
                                // ),
                                // const SizedBox(
                                //   height: 5,
                                // ),
                                // TextEditView(
                                //    onTap: ( ) {
                                //     Modals.showBottomSheetModal(context,
                                //                 isDissmissible: true,
                                //                 heightFactor: 0.7,
                                //                 page: filterModalContent(
                                //                     filterItems: user.overallPosts?.data?.type ?? [],
                                //                     title: 'Select Type',
                                //                     context: context,
                                //                     onPressed: (item) {
                                //                       Navigator.pop(context);
              
                                //                       setState(() {
                                //                         genres = item;
                                //                         authorController.text = genres;
                                //                       });
                                //                     }));
                                //   },
                                //   validator: Validator.validate,
                                //    readOnly: true,
                                //   suffixIcon: Icon(Icons.arrow_drop_down, size: 35, color: AppColors.lightSecondary,),
                                //   hintText: 'Select Types',
                                //   borderRadius: 16,
                                //   controller: authorController,
                                //   isDense: true,
                                //   fillColor: Colors.grey.shade200,
                                // ),
                                const Text(
                                  "Image 1",
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                CoverImageContainer1(),
              
                                const SizedBox(
                                  height: 25,
                                ),
                                const Text(
                                  "Image 2",
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                CoverImageContainer2(),
              
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
                                  onTap: () {
                                    Modals.showBottomSheetModal(context,
                                        isDissmissible: true,
                                        heightFactor: 1,
                                        page: filterModalContent(
                                            filterItems:
                                                user.overallPosts?.data?.genres ??
                                                    [],
                                            title: 'Select Genre',
                                            context: context,
                                            onPressed: (item) {
                                              Navigator.pop(context);
              
                                              setState(() {
                                                genres = item;
                                                genresController.text = genres;
                                              });
                                            }));
                                  },
                                  validator: Validator.validate,
                                  hintText: 'Enter Genres',
                                  borderRadius: 16,
                                  readOnly: true,
                                  suffixIcon: Icon(
                                    Icons.arrow_drop_down,
                                    size: 35,
                                    color: AppColors.lightSecondary,
                                  ),
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
                                            if (isChecked) {
                                              isTrending = 1;
                                            } else {
                                              isTrending = 0;
                                            }
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
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                (state is CreatePostLoading)
                                    ? Align(
                                        alignment: Alignment.center,
                                        child: ProgressIndicators
                                            .circularProgressBar(context))
                                    : Column(
                                        children: [
                                          ButtonView(
                                            onPressed: () {
                                              if (user.imageURl != null &&
                                                  user.imageURl1 != null &&
                                                  user.imageURl2 != null) {
                                                if (widget.isUpdate) {
                                                  _createPost(
                                                      context,
                                                      setToken.token,
                                                      user.imageURl ?? File(''),
                                                       user.imageURl1 ?? File(''),
                                                      user.imageURl2 ?? File(''),
                                                      '1',
                                                      AppStrings.updatePost,
                                                      postId);
              
                                                  // Modals.showToast(postId);
                                                } else {
                                                  _createPost(
                                                      context,
                                                      setToken.token,
                                                      user.imageURl ?? File(''),
                                                       user.imageURl1 ?? File(''),
                                                      user.imageURl2 ?? File(''),
                                                      '1',
                                                      AppStrings.createPost,
                                                      postId);
                                                }
                                              } else {
                                                Modals.showToast(
                                                    'please upload all images');
                                              }
                                            },
                                            color: AppColors.lightSecondary,
                                            child: const Text('Publish'),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          ButtonView(
                                            onPressed: () {
                                              if (user.imageURl != null &&
                                                  user.imageURl1 != null &&
                                                  user.imageURl2 != null) {
                                                if (widget.isUpdate) {
                                                  _createPost(
                                                      context,
                                                      setToken.token,
                                                      user.imageURl ?? File(''),
                                                       user.imageURl1 ?? File(''),
                                                      user.imageURl2 ?? File(''),
                                                      '0',
                                                      AppStrings.updatePost,
                                                      postId);
                                                } else {
                                                  _createPost(
                                                      context,
                                                      setToken.token,
                                                      user.imageURl ?? File(''),
                                                      user.imageURl1 ?? File(''),
                                                      user.imageURl2 ?? File(''),
                                                      '0',
                                                      AppStrings.createPost,
                                                      postId);
                                                }
                                              } else {
                                                Modals.showToast(
                                                    'please upload image');
                                              }
                                            },
                                            color: Colors.white,
                                            borderColor: AppColors.lightSecondary,
                                            child: const Text(
                                              'Save to Draft',
                                              style: TextStyle(
                                                  color:
                                                      AppColors.lightSecondary),
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
            );
      }),
    );
  }

  _createPost(BuildContext ctx, String token, File thumbnail, File image1,
      File image2, String status, String url, String postId) {
    if (_formKey.currentState!.validate()) {
      ctx.read<UserCubit>().createPost(
            url: url,
            title: titleController.text,
            postId: postId,
            content: contentController.text,
            thumbnail: thumbnail,
            genre: genresController.text,
            status: status,
            author: authorController.text,
            trending: isTrending.toString(),
            image1: image1,
            image2: image2,
            content2: content2Controller.text,
          );
      FocusScope.of(ctx).unfocus();
    }
  }

  clearFields() {
    titleController.text = "";
    contentController.text = "";
    content2Controller.text = "";
    videoUrlController.text = "";
    genresController.text = "";
    authorController.text = "";
  }
}
