import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:wenmq_first_flickr_flutter_app/base/base_tool.dart';

import 'package:wenmq_first_flickr_flutter_app/base/view/MyListView.dart'
    as myList;
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
    final double statusBarHeight = MediaQuery.of(context).padding.top;
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
      body: ListView(
        children: <Widget>[
          _buildAppBarWidget(
            context,
            statusBarHeight,
            title: CommonBuilder.getRandomColor().toString(),
            color: CommonBuilder.getRandomColor(),
          )
        ],
      ),
    );
  }

  CustomScrollView buildCustomScrollView(
      BuildContext context, double statusBarHeight) {
    return new CustomScrollView(
      slivers: List<Widget>.generate(
        100,
        (index) => _buildAppBar(
          context,
          statusBarHeight,
          title: index.toString(),
          color: CommonBuilder.getRandomColor(),
        ),
      ),
    );
  }

  myList.MyGridView buildMyGridView() {
    return myList.MyGridView.builder(
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
    );
  }

  myList.MyBoxScrollView buildMyBoxScrollView() {
    return myList.MyBoxScrollView(
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
            child: Text(index.toString()),
          ),
        ),
      );
    });
  }

  Widget _buildAppBar(BuildContext context, double statusBarHeight,
      {String title = "title", Color color}) {
    final _kAppbarHeight = 128.0;
    return SliverAppBar(
      pinned: false,
      expandedHeight: _kAppbarHeight,
      actions: <Widget>[
        Builder(
          builder: (BuildContext context) => IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search',
            onPressed: () {
              ShowMessage.showSnackBarWithContext(context, "no supported");
            },
          ),
        )
      ],
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final Size size = constraints.biggest;
          final double appBarHeight = size.height - statusBarHeight;
          final double t = (appBarHeight - kToolbarHeight) /
              (_kAppbarHeight - kToolbarHeight);
          final double extraPadding =
              Tween<double>(begin: 10.0, end: 24.0).transform(t);
          final double logoHeight = appBarHeight - 1.5 * extraPadding;
          return Padding(
            padding: EdgeInsets.only(
              top: statusBarHeight + 0.5 * extraPadding,
              bottom: extraPadding,
            ),
            child: Center(
              child: Container(
                height: logoHeight,
                width: logoHeight * 2,
                color: color,
                child: Center(
                  child: Text(title),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAppBarWidget(BuildContext context, double statusBarHeight,
      {String title = "title", Color color}) {
    final _kAppbarHeight = 158.0;
    return SliverAppBar(
      pinned: false,
      automaticallyImplyLeading: false,
      expandedHeight: _kAppbarHeight,
//      actions: <Widget>[
//        Builder(
//          builder: (BuildContext context) => IconButton(
//            icon: const Icon(Icons.search),
//            tooltip: 'Search',
//            onPressed: () {
//              ShowMessage.showSnackBarWithContext(context, "no supported");
//            },
//          ),
//        )
//      ],
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final Size size = constraints.biggest;
          final double appBarHeight = size.height - statusBarHeight;
          final double t = (appBarHeight - kToolbarHeight) /
              (_kAppbarHeight - kToolbarHeight);
          final double extraPadding =
              Tween<double>(begin: 10.0, end: 24.0).transform(t);
          final double logoHeight = appBarHeight - 1.5 * extraPadding;
          return Padding(
            padding: EdgeInsets.only(
              top: statusBarHeight + 0.5 * extraPadding,
              bottom: extraPadding,
            ),
            child: Center(
              child: Container(
                height: logoHeight,
                width: logoHeight * 2,
                color: color,
                child: Center(
                  child: VideoWidget(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
