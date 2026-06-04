import 'dart:io';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoWidget extends StatefulWidget {
  const VideoWidget({super.key});

  @override
  State<VideoWidget> createState() => _ResortVideoWidgetTwoState();
}

class _ResortVideoWidgetTwoState extends State<VideoWidget> {
  bool _isPlaying = false;
  YoutubePlayerController? _controller;

  Future<bool> hasInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  Future<void> _initVideo() async {
    bool internet = await hasInternet();

    if (!internet) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("No internet connection"),
        ),
      );
      return;
    }

    _controller = YoutubePlayerController(
      initialVideoId: "pVduLqe9IKc",
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );

    setState(() {
      _isPlaying = true;
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: hasInternet(),
      builder: (context, snapshot) {

        if (!snapshot.hasData) {
          return const SizedBox(
            height: 200,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.data == false) {
          return Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.wifi_off,
                    size: 40,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "No Internet Connection",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        }

        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(
                    scale: animation,
                    child: child,
                  ),
                );
              },
              child: _isPlaying
                  ? YoutubePlayerBuilder(
                      key: const ValueKey("video"),
                      player: YoutubePlayer(
                        controller: _controller!,
                        showVideoProgressIndicator: true,
                        bottomActions: const [
                          CurrentPosition(),
                          ProgressBar(isExpanded: true),
                          RemainingDuration(),
                          PlaybackSpeedButton(),
                        ],
                      ),
                      builder: (context, player) {
                        return player;
                      },
                    )
                  : GestureDetector(
                      key: const ValueKey("thumbnail"),
                      onTap: _initVideo,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.network(
                            YoutubePlayer.getThumbnail(
                              videoId: "pVduLqe9IKc",
                            ),
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                          Container(
                            color: Colors.black.withOpacity(0.3),
                          ),
                          const Icon(
                            Icons.play_circle_fill,
                            color: Colors.white,
                            size: 70,
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}