import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubePlay extends StatefulWidget {
  YoutubePlay({super.key});
  final String? url = Get.arguments;

  @override
  State<YoutubePlay> createState() => _YoutubePlayState();
}

class _YoutubePlayState extends State<YoutubePlay> {
  @override
  void initState() {
    _controller = YoutubePlayerController.fromVideoId(
      videoId: YoutubePlayerController.convertUrlToId(widget.url!)!,
      autoPlay: true,
      params: const YoutubePlayerParams(
        showFullscreenButton: true,
        strictRelatedVideos: true,
      ),
    );
    // _controller.listen((event) {
    //   _controller.duration.then((value) {
    //     if (value * 60 / 60 == 5) log(_controller.currentTime.toString());
    //   });
    // });
    super.initState();
  }

  dynamic duration;

  RxBool hasStart = false.obs;
  RxBool hasPlayedHalf = false.obs;
  RxBool hasPlayed = false.obs;

  YoutubePlayerController? _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black,
      body: Stack(
        children: [
          Center(
            child: YoutubePlayer(
              controller: _controller!,
              aspectRatio: 1,
            ),
          ),
          Positioned(
            top: 70,
            right: 20,
            child: GestureDetector(
              onTap: Get.back,
              child: const Icon(
                Icons.close,
                color: AppColor.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
