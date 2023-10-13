import 'package:fikkton/ui/widgets/text_edit_view.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../res/app_colors.dart';
import '../../../res/app_images.dart';
import '../../widgets/image_view.dart';
import '../movie.dart';
import 'widgets/comment_section.dart';

class MovieDetailsScreen extends StatefulWidget {
  MovieDetailsScreen({super.key});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;

  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;

  final List<String> _ids = [
    'nPt8bK2gbaU',
    'gQDByCdjUXw',
    'iLnmTe5Q2Qw',
    '_WoCV4c6XOE',
    'KmzdUe0RSJo',
    '6jZDSSZZxjQ',
    'p2lYr3vM_1w',
    '7QUtEmBT_-w',
    '34_PXCzGw1M',
  ];

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: _ids.first,
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
        body: Padding(
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
                  const SizedBox(width: 30,),
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
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "TV SERIES",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Colors.black),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 12.0),
                          child: ImageView.svg(
                            AppImages.bookmark,
                            height: 25,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      "House Of The Dragon - Season 1",
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "17 June, 2023",
                        ),
                        SizedBox(width: 15.0),
                        Padding(
                          padding: EdgeInsets.only(right: 12.0),
                          child: Text(
                            "3 min ago",
                          ),
                        ),
                      ],
                    ),
                     SizedBox(
                      height: 25,
                    ),
                    Divider(),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      """House of the Dragon" is an American television series that serves as a prequel to the immensely popular fantasy series "Game of Thrones." The show is based on George R.R. Martin's book "Fire & Blood," which chronicles the history of House Targaryen, a prominent family in the fictional world of Westeros.
    
Set roughly 200 years before the events of "Game of Thrones," "House of the Dragon" delves into the tumultuous and often violent history of the Targaryen dynasty, known for their affinity for dragons and their quest for power.
The series explores the early days of House Targaryen, focusing on key historical events, political intrigues, and the complex relationships among the Targaryen family members.""",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
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
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 16),
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
        ),
        bottomNavigationBar:  SizedBox(
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
                  suffixIcon: const ImageView.svg(AppImages.send),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
