import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class videoPlayerScreen extends StatefulWidget {
  // const videoPlayerScreen({super.key});
  final VideoPlayerController videoPlayerController;
  final bool looping;
  final bool autoplay;

  videoPlayerScreen(this.videoPlayerController, this.looping, this.autoplay);

  @override
  State<videoPlayerScreen> createState() => _videoPlayerScreenState();
}

class _videoPlayerScreenState extends State<videoPlayerScreen> {
  late ChewieController chewieController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    setState(() {
      chewieController = ChewieController(
          videoPlayerController: widget.videoPlayerController,
          aspectRatio: 9 / 4,
          autoInitialize: true,
          autoPlay: widget.autoplay,
          looping: widget.looping,
          errorBuilder: ((context, errorMessage) {
            return Center(
              child: Text("Something went wrong"),
            );
          }));
    });
    // chewieController = ChewieController(
    //     videoPlayerController: widget.videoPlayerController,
    //     aspectRatio: 9 / 4,
    //     autoInitialize: true,
    //     autoPlay: widget.autoplay,
    //     looping: widget.looping,
    //     errorBuilder: ((context, errorMessage) {
    //       return Center(
    //         child: Text("Something went wrong"),
    //       );
    //     }));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 20,
      // width: 200,
      child: Chewie(controller: chewieController),
    );
  }
}
