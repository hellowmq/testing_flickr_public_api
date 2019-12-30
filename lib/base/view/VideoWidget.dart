import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:wenmq_first_flickr_flutter_app/base/base_tool.dart';

class VideoWidget extends StatefulWidget {
  static Widget startPage(BuildContext context) {
    return VideoWidget();
  }

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  VideoPlayerController _controller;
  String testVideoUrl = 'https://media.w3.org/2010/05/sintel/trailer.mp4';
  bool isOptionVisible = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        testVideoUrl + new DateTime.now().toIso8601String())
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even
        // before the play button has been pressed.
        print(_controller.value.initialized);
        setState(() {
          _controller.play();
        });
      });
    _controller.setLooping(true);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(children: [
        _controller.value.initialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : Container(
                color: CommonBuilder.getRandomColor(),
                width: 400.0,
                height: 200.0,
              ),
        Container(
          child: GestureDetector(
            onTap: () => setState(() {
              isOptionVisible = !isOptionVisible;
            }),
            child: Container(
              color: Color.fromARGB(0x80, 0xFF, 0xFF, 0xFF),
              child: Center(
                child: FloatingActionButton(
                  onPressed: () => setState(() {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  }),
                  child: Icon(
                    _controller.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                  ),
                ),
              ),
            ),
          ),
//        visible: isOptionVisible,
        ),
      ]),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
