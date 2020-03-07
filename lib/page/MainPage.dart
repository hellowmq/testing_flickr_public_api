import 'package:flutter/material.dart';

import 'package:wenmq_first_flickr_flutter_app/base/base_tool.dart';
import 'PageIndex.dart' as page;

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          DebugUtils.isDebug
              ? (DebugUtils.getPlatformName())
              : 'This is our Flickr Api',
          style: TextStyle(fontFamily: 'Steiner', fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: page.PageIndexList().buildPageIndexWidgetList(context),
      ),
    );
  }
}

class NewMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          DebugUtils.isDebug
              ? (DebugUtils.getPlatformName())
              : 'This is our Flickr Api',
          style: TextStyle(fontFamily: 'Steiner', fontWeight: FontWeight.bold),
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("This is a app bar"),
            ),
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 1.0,
              childAspectRatio: 3.0 / 4.0,
              crossAxisCount: 2
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                page.PageIndex p = page.PageIndexList.pageIndexList[index];
                return Card(
                  child: GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 0.0),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              p.title,
                              textAlign: TextAlign.start,
                              textScaleFactor: 1.5,
                              style: new TextStyle(
                                  color: CommonBuilder.getRandomColor()),
                            ),
                          ),
                          Divider(),
                          SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  0.0, 10.0, 0.0, 10.0),
                              child: Text(
                                p.subtitle,
                                textAlign: TextAlign.start,
                                textScaleFactor: 1.2,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 8,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () => Navigator.pushNamed(context, p.routeName),
                  ),
                );
              },
              childCount: page.PageIndexList.pageIndexList.length,
            ),
          )
        ],
      ),
    );
  }
}
