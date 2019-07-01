import 'package:flutter/material.dart';
import 'package:wenmq_first_flickr_flutter_app/page/all.dart';

class PageIndex {
  final String title;
  final String subtitle;
  final String routeName;
  final WidgetBuilder buildRoute;
  final String documentationUrl;

  const PageIndex({
    @required this.title,
    this.subtitle,
    @required this.routeName,
    this.documentationUrl,
    @required this.buildRoute,
  })  : assert(title != null),
        assert(routeName != null),
        assert(buildRoute != null);

  @override
  String toString() {
    return '$runtimeType($title $routeName)';
  }
}

List<PageIndex> pageIndexs = <PageIndex>[
  PageIndex(
    title: 'flickr.test.echo',
    subtitle:
        "A testing method which echo's all parameters back in the response.",
    routeName: '/echo',
    documentationUrl:
        'https://www.flickr.com/services/api/flickr.test.echo.html',
    buildRoute: (context) => EchoTestPage(),
  ),
  PageIndex(
    title: 'flickr.photos.getRecent',
    subtitle: "Returns a list of the latest public photos uploaded to flickr.",
    routeName: '/getRecent',
    documentationUrl:
        'https://www.flickr.com/services/api/flickr.photos.getRecent.html',
    buildRoute: (context) => GetRecentPhotosPage(),
  ),
  PageIndex(
    title: 'flickr.photos.search',
    subtitle:
        "Return a list of photos matching some criteria. Only photos visible to the calling user will be returned. To return private or semi-private photos, the caller must be authenticated with 'read' permissions, and have permission to view the photos. Unauthenticated calls will only return public photos.",
    routeName: '/search',
    documentationUrl:
        'https://www.flickr.com/services/api/flickr.photos.search.html',
    buildRoute: (context) => SearchPhotosPage(),
  ),
];

final Map<String, WidgetBuilder> routeMap =
    new Map<String, WidgetBuilder>.fromIterable(pageIndexs,
        key: (v) => v.routeName, value: (v) => v.buildRoute)
      ..['/'] = (context) => MainPage();

List<Widget> buildWidgetList(context) {
  return pageIndexs.map((v) {
    return new ListTile(
      title: Text(v.title),
      subtitle: Text(v.subtitle),
      isThreeLine: true,
      onTap: () {
        Navigator.pushNamed(context, v.routeName);
      },
    );
  }).toList();
}
