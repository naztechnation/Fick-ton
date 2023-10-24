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
import '../movie.dart';
import 'widgets/comment_section.dart';



class MovieDetailsScreen extends StatelessWidget {
  final String videoLinks;

  const MovieDetailsScreen({Key? key, required this.videoLinks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (BuildContext context) => UserCubit(
          userRepository: UserRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child:   MovieDetails(videoLinks: videoLinks,),
    );
  }
}
class MovieDetails extends StatefulWidget {
  final String videoLinks;
  const MovieDetails({super.key, required this.videoLinks});

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

    late UserCubit _userCubit;

    Data? postDetails;

  String token = '';
 getPosts() async {
    _userCubit = context.read<UserCubit>();

    token = await StorageHandler.getUserToken() ?? '';

    _userCubit.getPostDetails(token: token);
  }

  @override
  void initState() {
    getPosts();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoLinks,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;

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
        body: BlocConsumer<UserCubit, UserStates>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is PostDetailsLoaded) {
                if (state.postDetails.status == 1) {
                  postDetails = state.postDetails.data;
                  Modals.showToast(state.postDetails.message!,
                      messageType: MessageType.error);
                } else {
                  Modals.showToast(state.postDetails.message!,
                      messageType: MessageType.error);
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
              }

              return (state is PostDetailsLoading)
                  ? const LoadingPage()
                  : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
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
                        child: YoutubePlayerDemoApp())),
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
                            postDetails!.genre!,
                            style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colors.black),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 12.0),
                            child: ImageView.svg(
                              AppImages.bookmark,
                              height: 25,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12.0),
                        Text(
                        postDetails!.title!,
                        style:
                            const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                      const SizedBox(height: 16.0),
                        Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            postDetails!.createdAt!,
                          ),
                          const SizedBox(width: 15.0),
                          Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: Text(
                               postDetails!.createdAt!,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 30,
                      ),
                        Text(
                         postDetails!.content!,
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
                const Row(
                  children: [
                    ImageView.svg(AppImages.thumbUp),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "50",
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const Divider(),
                const SizedBox(
                  height: 15,
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Comments (20)",
                        style:
                            TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                      Icon(Icons.arrow_forward_sharp)
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                ListView.builder(
                    itemCount: 3,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, index) {
                      return CommentSection(
                        comment:
                            'House of the Dragon sounds incredibly exciting! Exploring the history.',
                        title: 'kennd************@gmail.com',
                      );
                    }),
              ],
            )),
          );
  }),
        bottomNavigationBar: SizedBox(
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
                  child: const Center(
                    child: Text(
                      'K',
                      style: TextStyle(
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
                    child: TextEditView(
                  controller: TextEditingController(),
                  isDense: true,
                  filled: true,
                  hintText: 'Add a comment',
                  fillColor: Colors.grey.shade50,
                  suffixIcon: const SizedBox(
                      height: 12,
                      child: ImageView.svg(
                        AppImages.send,
                        height: 10,
                      )),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
