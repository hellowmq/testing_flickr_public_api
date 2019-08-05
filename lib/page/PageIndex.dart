import 'package:flutter/material.dart';
import 'package:wenmq_first_flickr_flutter_app/page/all_page.dart';

///
/// auth: hellowmq 2019/07/23
///

// All sub page should be routed with a PageIndex.
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

// All sub routes are stored in a PageIndex List.
List<PageIndex> pageIndexList = <PageIndex>[
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
    title: 'request.token',
    subtitle: "signing request",
    routeName: '/signingRequest',
    documentationUrl: 'https://www.flickr.com/services/api/auth.oauth.html',
    buildRoute: (context) => SigningRequestPage(),
  ),
  PageIndex(
    title: 'auth.oauth',
    subtitle: "AuthOAuthTestPage",
    routeName: '/authOAuth',
    documentationUrl: 'https://www.flickr.com/services/api/auth.oauth.html',
    buildRoute: (context) => AuthOAuthTestPage(),
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
  PageIndex(
    title: 'flickr.photos.getPopular',
    subtitle: "Returns a list of popular photos",
    routeName: '/getPopular',
    documentationUrl:
        'https://www.flickr.com/services/api/flickr.photos.getPopular.html',
    buildRoute: (context) => GetPopularPhotosPage(),
  ),
  PageIndex(
    title: 'sqflite test',
    subtitle:
        "sqflite # SQLite plugin for Flutter. Supports both iOS and Android.",
    routeName: '/testSqflite',
    documentationUrl: 'https://pub.dev/packages/sqflite#-readme-tab-',
    buildRoute: (context) => GetPopularPhotosPage(),
  )
];

// a routeMap should be submit to MaterialApp as a route
final Map<String, WidgetBuilder> routeMap =
    new Map<String, WidgetBuilder>.fromIterable(pageIndexList,
        key: (v) => v.routeName, value: (v) => v.buildRoute)
      ..['/'] = (context) => MainPage();

// create the enter for the sub page
List<Widget> buildWidgetList(context) {
  List<Widget> pageEnterList = new List();
  pageIndexList.forEach((v) {
    pageEnterList.add(new ListTile(
      title: Text(v.title),
      subtitle: Text(v.subtitle),
      isThreeLine: true,
      onTap: () {
        Navigator.pushNamed(context, v.routeName);
      },
    ));
    pageEnterList.add(Divider());
  });
  return pageEnterList;
}
