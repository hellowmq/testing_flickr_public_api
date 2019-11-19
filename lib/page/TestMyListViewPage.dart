import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
      body: MyListView.builder(
        controller: ScrollController(debugLabel: "MyScrollControllerRR"),
        itemBuilder: (_, index) =>
            Container(
              height: 100.0,
              width: 100.0,
              color: CommonBuilder.getRandomColor(),
              child: Center(
                child: MyFadeTest(title: "",),
//                Foo(
//                  text: index.toString(),
//                  duration: new Duration(seconds: 5),
//                ),
              ),
            ),
        itemCount: 60,
        scrollDirection: direction,
        physics: scrollPhysics,
        dragStartBehavior: DragStartBehavior.start,
        itemExtent: 100.0,
      ),
    );
  }
}

class Foo extends StatefulWidget {
  Foo({Key key, this.duration, this.text}) : super(key: key);

  final Duration duration;
  final String text;

  @override
  _FooState createState() => _FooState(text);
}

class _FooState extends State<Foo> with SingleTickerProviderStateMixin {
  AnimationController controller;
  CurvedAnimation curvedAnimation;
  String text;

  _FooState(this.text);

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration: widget.duration,
    );
    curvedAnimation =
    new CurvedAnimation(parent: controller, curve: Curves.bounceOut);
    controller.forward();
  }

  @override
  void didUpdateWidget(Foo oldWidget) {
    super.didUpdateWidget(oldWidget);
    controller.duration = widget.duration;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      color: CommonBuilder.getRandomColor(),
      child: RotationTransition(
        turns: curvedAnimation,
        child: Text(text),
      ),
    ); // ...
  }
}


class MyFadeTest extends StatefulWidget {
  MyFadeTest({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State createState() => new _MyFadeTest();
}

class _MyFadeTest extends State<MyFadeTest> with TickerProviderStateMixin {
  AnimationController controller; //动画控制器
  CurvedAnimation curved; //曲线动画，动画插值，
  bool forward = true;

  @override
  void initState() {
    //初始化，当当前widget被插入到树中时调用
    super.initState();
    controller = new AnimationController(
        vsync: this, duration: const Duration(seconds: 3));
    curved = new CurvedAnimation(
        parent: controller, curve: Curves.bounceOut); //模仿小球自由落体运动轨迹
    controller.forward();//放在这里开启动画 ，打开页面就播放动画
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
//        child: new FadeTransition(//透明度动画
//          opacity: curved,//将动画传入不同的动画widget
//          child: new FlutterLogo(//创建一个小部件，用于绘制Flutter徽标
//            size: 200.0,
//          ),
//        ),
      child: new RotationTransition( //旋转动画
        turns: curved,
        child: new FlutterLogo(
          size: 40.0,
        ),
      ),
    );
  }

  void change() {
    if (forward)
      controller.forward(); //向前播放动画
    else
      controller.reverse(); //向后播放动画
    forward = !forward;
  }
}