import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
      body: buildMyBoxScrollView(),
    );
  }

  MyGridView buildMyGridView() {
    return MyGridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20.0,
        crossAxisSpacing: 3.0,
        childAspectRatio: 9 / 16.0,
      ),
      controller: ScrollController(debugLabel: "MyScrollControllerRR"),
      itemBuilder: (_, index) => Container(
        height: 100.0,
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
        color: CommonBuilder.getRandomColor(),
        child: Center(
          child: Text(index.toString()),
        ),
      ),
      itemCount: 100,
      scrollDirection: direction,
      physics: scrollPhysics,
//        dragStartBehavior: DragStartBehavior.start,
//        itemExtent: 100.0,
    );
  }

  MyBoxScrollView buildMyBoxScrollView() {
    return MyBoxScrollView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20.0,
        crossAxisSpacing: 3.0,
        childAspectRatio: 9 / 6,
      ),
      children: buildWidgetList(),
    );
  }

  List<Widget> buildWidgetList() {
    return List.generate(100, (index) {
      return Center(
        child: Container(
          height: 300.0,
          width: 400.0,
          color: CommonBuilder.getRandomColor(),
          padding: EdgeInsets.all(5.0),
          child: Container(
            child: Text(index.toString() + ""),
          ),
        ),
      );
    });
  }
}
