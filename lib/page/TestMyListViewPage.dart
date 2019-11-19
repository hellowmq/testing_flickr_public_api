import 'package:flutter/material.dart';
import 'package:wenmq_first_flickr_flutter_app/base/base_tool.dart';

import 'package:wenmq_first_flickr_flutter_app/base/view/MyListView.dart';
import 'package:wenmq_first_flickr_flutter_app/base/view/MyScrollPhysics.dart';

///
/// Actually, this page is the sample page of plugin: video_player.
/// I found it cost a lot of time to prepare the video. Maybe I should find my
/// way to solve it.
///

class TestMyListViewPage extends StatefulWidget {
  static Widget startPage(BuildContext context) {
    return TestMyListViewPage();
  }

  @override
  _TestMyListViewPageState createState() => _TestMyListViewPageState();
}

class _TestMyListViewPageState extends State<TestMyListViewPage> {
  bool isVertical = false;
  Axis direction = Axis.horizontal;
  ScrollPhysics scrollPhysics = ClampingScrollPhysics();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.build),
        onPressed: () {
          setState(() {
            isVertical = !isVertical;
            direction = (isVertical) ? Axis.vertical : Axis.horizontal;
            scrollPhysics =
                (isVertical) ? MyScrollPhysics() : ClampingScrollPhysics();
          });
        },
      ),
      body: MyListView.separated(
        separatorBuilder: (_, index) => Divider(),
        itemBuilder: (_, index) => Container(
          height: 100.0,
          width: 100.0,
          color: CommonBuilder.getRandomColor(),
          child: Center(
            child: Text(
              index.toString(),
            ),
          ),
        ),
        itemCount: 60,
        scrollDirection: direction,
        physics: scrollPhysics,
      ),
    );
  }
}


