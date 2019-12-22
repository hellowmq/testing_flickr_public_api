import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {
  static Widget startPage(BuildContext context) {
    return VideoWidget();
  }

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  VideoPlayerController _controller;
  String testVideoUrl =
      'http://vfx.mtime.cn/Video/2019/03/21/mp4/190321153853126488.mp4';
  bool isOptionVisible = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(testVideoUrl)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even
        // before the play button has been pressed.
        setState(() {
          _controller.play();
        });
      });
    _controller.setLooping(true);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Center(
        child: _controller.value.initialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : Container(),
      ),
//      Container(
//        child: GestureDetector(
//          onTap: () => setState(() {
//            isOptionVisible = !isOptionVisible;
//          }),
//          child: Container(
//            color: Color.fromARGB(0x80, 0xFF, 0xFF, 0xFF),
//            child: Center(
//              child: FloatingActionButton(
//                onPressed: () => setState(() {
//                  _controller.value.isPlaying
//                      ? _controller.pause()
//                      : _controller.play();
//                }),
//                child: Icon(
//                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
//                ),
//              ),
//            ),
//          ),
//        ),
////        visible: isOptionVisible,
//      ),
    ]);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
