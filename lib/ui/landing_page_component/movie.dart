
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../res/app_colors.dart';

class YoutubePlayerDemoApp extends StatelessWidget {
  final String videoLink;

  const YoutubePlayerDemoApp({super.key, required this.videoLink});
  @override
  Widget build(BuildContext context) {
    return MyHomePage(videoLink: videoLink,);
  }
}

class MyHomePage extends StatefulWidget {
  final String videoLink;

  const MyHomePage({super.key, required this.videoLink});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;

  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;

  String videoId = "";

  @override
  void initState() {
    super.initState();
    
videoId = YoutubePlayer.convertUrlToId(widget.videoLink) ?? '';

    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
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
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      onExitFullScreen: () {
        // SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      },
       onEnterFullScreen: () {
      //   SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      },
      
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        aspectRatio: 16/15,
        width: MediaQuery.sizeOf(context).width,
        progressIndicatorColor: AppColors.lightPrimary,
        topActions: <Widget>[
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              _controller.metadata.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          IconButton(
            icon: Icon(
              _muted ? Icons.volume_off : Icons.volume_up,
              color: Colors.white,
            ),
            onPressed: _isPlayerReady
                ? () {
                    _muted ? _controller.unMute() : _controller.mute();
                    setState(() {
                      _muted = !_muted;
                    });
                  }
                : null,
          ),
        ],
        onReady: () {
          _isPlayerReady = true;
        },
        onEnded: (data) {
           
        },
      ),
      builder: (context, player) => Scaffold(
        body: ListView(
          children: [
            player,
            
          ],
        ),
      ),
    );
  }
}

Widget get _space => const SizedBox(height: 10);
