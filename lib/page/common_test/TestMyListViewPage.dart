import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wenmq_first_flickr_flutter_app/base/base_tool.dart';

import 'package:wenmq_first_flickr_flutter_app/base/view/MyListView.dart';
import 'package:wenmq_first_flickr_flutter_app/base/view/MyScrollPhysics.dart';

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
      body: MyGridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20.0,
          crossAxisSpacing: 3.0,
          childAspectRatio: 9 / 16.0,
        ),
        controller: ScrollController(debugLabel: "MyScrollControllerRR"),
        itemBuilder: (_, index) => Container(
          height: 100.0,
          padding:EdgeInsets.all(10.0),
          color: CommonBuilder.getRandomColor(),
          child: Center(
            child: MyFadeTest(
//              title: Container(
//                decoration: new BoxDecoration(
//                  color: CommonBuilder.getRandomColor(),
//                  borderRadius: new BorderRadius.all(Radius.circular(5.0)),
//                ),
//                padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 5.0),
//                child: MyFadeTest(
//                  title: Container(
//                    padding:
//                        EdgeInsets.symmetric(vertical: 25.0, horizontal: 5.0),
//                    child: MyFadeTest(
              title: Text(index.toString()),
//                    ),
//                  ),
//                ),
//              ),
            ),
          ),
        ),
        itemCount: 100,
        scrollDirection: direction,
        physics: scrollPhysics,
//        dragStartBehavior: DragStartBehavior.start,
//        itemExtent: 100.0,
      ),
    );
  }
}

class MyFadeTest extends StatefulWidget {
  MyFadeTest({Key key, this.title}) : super(key: key);
  final Widget title;

  @override
  State createState() => new _MyFadeTest(title);
}

class _MyFadeTest extends State<MyFadeTest> with TickerProviderStateMixin {
  AnimationController controller; //动画控制器
  CurvedAnimation curved; //曲线动画，动画插值，
  bool forward = true;
  final Widget title;

  _MyFadeTest(this.title);

  @override
  void initState() {
    super.initState();
    controller = new AnimationController(
        vsync: this, duration: const Duration(seconds: 5));
    curved = new CurvedAnimation(parent: controller, curve: Curves.ease);
    controller.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    controller.forward(); //放在这里开启动画 ，打开页面就播放动画
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: buildFadeTransition(),
    );
  }

  RotationTransition buildRotationTransition() {
    return new RotationTransition(
      turns: curved,
      child: Container(
        color: CommonBuilder.getRandomColor(),
        child: Center(
          child: title,
        ),
      ),
    );
  }

  FadeTransition buildFadeTransition() {
    return new FadeTransition(
      opacity: curved,
      child: Container(
        padding: EdgeInsets.all(5.0),
        color: CommonBuilder.getRandomColor(),
        child: Center(
          child: title,
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
