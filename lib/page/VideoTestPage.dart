import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

///
/// Actually, this page is the sample page of plugin: video_player.
/// I found it cost a lot of time to prepare the video. Maybe I should find my
/// way to solve it.
///

class VideoTestPage extends StatefulWidget {
  static Widget startPage(BuildContext context) {
    return VideoTestPage();
  }

  @override
  _VideoTestPageState createState() => _VideoTestPageState();
}

class _VideoTestPageState extends State<VideoTestPage> {
  VideoPlayerController _controller;
  static const String testVideoUrl =
      'http://vfx.mtime.cn/Video/2019/03/21/mp4/190321153853126488.mp4';

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
    return MaterialApp(
      title: 'Video Demo',
      home: Scaffold(
        body: Center(
          child: _controller.value.initialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Container(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          }),
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
