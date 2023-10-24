import 'package:fikkton/model/posts/comment_lists.dart';
import 'package:fikkton/res/app_strings.dart';
import 'package:fikkton/ui/widgets/text_edit_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../blocs/user/user.dart';
import '../../../handlers/secure_handler.dart';
import '../../../model/posts/post_details.dart';
import '../../../model/view_models/user_view_model.dart';
import '../../../requests/repositories/user_repo/user_repository_impl.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_images.dart';
import '../../../res/enum.dart';
import '../../widgets/empty_widget.dart';
import '../../widgets/image_view.dart';
import '../../widgets/loading_page.dart';
import '../../widgets/modals.dart';
import '../../widgets/progress_indicator.dart';
import '../movie.dart';
import 'widgets/comment_section.dart';

class MovieDetailsScreen extends StatelessWidget {
  final String videoLinks;
  final String postId;

  const MovieDetailsScreen(
      {Key? key, required this.videoLinks, required this.postId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (BuildContext context) => UserCubit(
          userRepository: UserRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child: MovieDetails(
        videoLinks: videoLinks,
        postId: postId,
      ),
    );
  }
}

class MovieDetails extends StatefulWidget {
  final String videoLinks;
  final String postId;

  const MovieDetails(
      {super.key, required this.videoLinks, required this.postId});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;

  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;

  final _formKey = GlobalKey<FormState>();

  final commentController = TextEditingController();

  late UserCubit _userCubit;

  Data? postDetails;
  List<Comments> comments = [];

  bool isPostComment = false;

  String token = '';
  String email = '';
  getPosts() async {
    _userCubit = context.read<UserCubit>();

    token = await StorageHandler.getUserToken() ?? '';
    email = await StorageHandler.getUserEmail() ?? '';

    _userCubit.getPostDetails(token: token);

    await _userCubit.getComment(token: token, postId: widget.postId);

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {});
    });
  }

  @override
  void initState() {
    getPosts();

    super.initState();
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocConsumer<UserCubit, UserStates>(listener: (context, state) {
          if (state is PostDetailsLoaded) {
            if (state.postDetails.status == 1) {
              postDetails = state.postDetails.data;
            } else {}
          }
          if (state is CommentLoaded) {
            if (state.postComment.status == 1) {
              comments = state.postComment.data ?? [];
            } else {}
          }

          if (state is CreateCommentLoaded) {
            if (state.postComment.status == 1) {
              setState(() {
                isPostComment = false;
              });
            } else {}
          }
          if (state is CreateCommentLoading) {
            isPostComment = true;
          } else {}
          if (state is LikeBookmarkLoaded) {
            if (state.createPost.status == 1) {
                  _userCubit.getPostDetails(token: token);
             
              Modals.showToast(state.createPost.message ?? '',
                  messageType: MessageType.error);
            } else {
              Modals.showToast(state.createPost.message ?? '',
                  messageType: MessageType.error);
            }
          }
        }, builder: (context, state) {
          if (state is PostDetailsLoaded) {
            if (state.postDetails.status == 1) {
              postDetails = state.postDetails.data;
               
            } else {
               
            }
          } else if (state is UserNetworkErr) {
            return EmptyWidget(
              title: 'Network error',
              description: state.message,
              onRefresh: () => _userCubit.getPostDetails(token: token),
            );
          } else if (state is UserNetworkErrApiErr) {
            return EmptyWidget(
              title: 'Network error',
              description: state.message,
              onRefresh: () => _userCubit.getPostDetails(token: token),
            );
          } else if (state is PostDetailsLoading) {
            return const LoadingPage();
          }else if (state is LikeBookmarkLoading) {
            return const LoadingPage();
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SafeArea(
                  child: SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.04,
                  ),
                ),
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
                    const Text(
                      "Fik-kton",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                    height: 300,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(30)),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: YoutubePlayerDemoApp(
                            videoLink: widget.videoLinks))),
                Expanded(
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  postDetails?.genre ?? '',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: Colors.black),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    likeBookmark(context, widget.postId, AppStrings.bookmarkPost);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: ImageView.svg(
                                      postDetails?.isBooked == '0'
                                          ? AppImages.bookmarkOutline
                                          : AppImages.bookmark,
                                      height: 25,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12.0),
                            Text(
                              postDetails?.title ?? '',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 16),
                            ),
                            const SizedBox(height: 16.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  postDetails?.createdAt ?? '',
                                ),
                                const SizedBox(width: 15.0),
                                Padding(
                                  padding: const EdgeInsets.only(right: 12.0),
                                  child: Text(
                                    postDetails?.createdAt ?? '',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Divider(),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              postDetails?.content ?? '',
                              textAlign: TextAlign.justify,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                         onTap: (){
                                    likeBookmark(context, widget.postId, AppStrings.likePost);
                                  },
                        child: Row(
                          children: [
                            const ImageView.svg(AppImages.thumbUp),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              postDetails?.likes ?? '',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Comments (${comments.length})",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 16),
                            ),
                            const Icon(Icons.arrow_forward_sharp)
                          ],
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      (state is CommentLoading)
                          ? ProgressIndicators.circularProgressBar(context)
                          : ListView.builder(
                              itemCount: comments.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, index) {
                                return CommentSection(
                                  comment: comments[index].comment ?? '',
                                  title: replaceSubstring(
                                      comments[index].email ?? ''),
                                );
                              }),
                    ],
                  )),
                ),
              ],
            ),
          );
        }),
        bottomNavigationBar: (isPostComment)
            ? Container(
                height: 25,
                padding: const EdgeInsets.only(bottom: 20),
                child: ProgressIndicators.linearProgressBar(context))
            : SizedBox(
                height: 90,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Container(
                        width: 31,
                        height: 31,
                        decoration: const BoxDecoration(
                          color: AppColors.lightPrimary,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            email.isNotEmpty ? email[0].toUpperCase() : '?',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 14,
                      ),
                      Expanded(
                          child: Form(
                        key: _formKey,
                        child: TextEditView(
                          controller: commentController,
                          isDense: true,
                          filled: true,
                          hintText: 'Add a comment',
                          fillColor: Colors.grey.shade50,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              makeComment(context, postDetails?.content ?? '',
                                  commentController.text);
                            },
                            child: const SizedBox(
                                height: 12,
                                child: ImageView.svg(
                                  AppImages.send,
                                  height: 10,
                                )),
                          ),
                        ),
                      )),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  makeComment(BuildContext ctx, String postId, String comment) {
    if (_formKey.currentState!.validate()) {
      ctx
          .read<UserCubit>()
          .createComment(token: token, postId: postId, comment: comment);
      FocusScope.of(ctx).unfocus();
    }
  }

  likeBookmark(BuildContext ctx, String postId, String url) {
    ctx.read<UserCubit>().likeBookMark(token: token, postId: postId, url: url);
    FocusScope.of(ctx).unfocus();
  }

  String replaceSubstring(String input) {
    input = input.replaceRange(3, 7, '*****');

    return input;
  }
}
