import 'package:flutter/material.dart';
import 'package:wenmq_first_flickr_flutter_app/base/string.dart';
import 'package:wenmq_first_flickr_flutter_app/page/common_test/QrCodePage.dart';
import 'package:wenmq_first_flickr_flutter_app/page/all_page.dart';

///
/// auth: hellowmq 2019/07/23
/// This File include all indexes of the MainPage.
/// Add a PageIndex to pageIndexList and then it will build the corresponding
/// ListTile entrance and Material routeMap.
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
    @required this.routeName,
    @required this.buildRoute,
    this.subtitle,
    this.documentationUrl,
  })  : assert(title != null),
        assert(routeName != null),
        assert(buildRoute != null);

  @override
  String toString() {
    return 'PageIndex{title: $title, subtitle: $subtitle, routeName: $routeName, buildRoute: $buildRoute, documentationUrl: $documentationUrl}';
  }
}

// All sub routes are stored in a PageIndex List.
const List<PageIndex> pageIndexList = const <PageIndex>[
  PageIndex(
    title: 'flickr.test.echo',
    subtitle:
        "A testing method which echo's all parameters back in the response.",
    routeName: '/echo',
    documentationUrl:
        'https://www.flickr.com/services/api/flickr.test.echo.html',
    buildRoute: EchoTestPage.startPage,
  ),
  PageIndex(
    title: 'request.token',
    subtitle: "signing request",
    routeName: '/signingRequest',
    documentationUrl: 'https://www.flickr.com/services/api/auth.oauth.html',
    buildRoute: SigningRequestPage.startPage,
  ),
  PageIndex(
    title: 'auth.oauth',
    subtitle: "AuthOAuthTestPage",
    routeName: '/authOAuth',
    documentationUrl: 'https://www.flickr.com/services/api/auth.oauth.html',
    buildRoute: AuthOAuthTestPage.startPage,
  ),
  PageIndex(
    title: FlickrConstant.FLICKR_PHOTOS_GET_RECENT,
    subtitle: "Returns a list of the latest public photos uploaded to flickr.",
    routeName: '/getRecent',
    documentationUrl:
        'https://www.flickr.com/services/api/flickr.photos.getRecent.html',
    buildRoute: GetRecentPhotosPage.startPage,
  ),
  PageIndex(
    title: FlickrConstant.FLICKR_PHOTOS_SEARCH,
    subtitle:
        "Return a list of photos matching some criteria. Only photos visible to "
        "the calling user will be returned. To return private or "
        "semi-private photos, the caller must be authenticated with 'read' "
        "permissions, and have permission to view the photos. "
        "Unauthenticated calls will only return public photos.",
    routeName: '/search',
    documentationUrl:
        'https://www.flickr.com/services/api/flickr.photos.search.html',
    buildRoute: SearchPhotosPage.startPage,
  ),
  PageIndex(
    title: 'flickr.photos.getPopular',
    subtitle: "Returns a list of popular photos",
    routeName: '/getPopular',
    documentationUrl:
        'https://www.flickr.com/services/api/flickr.photos.getPopular.html',
    buildRoute: GetPopularPhotosPage.startPage,
  ),
  PageIndex(
    title: 'sqflite test',
    subtitle:
        "sqflite # SQLite plugin for Flutter. Supports both iOS and Android.",
    routeName: '/testSqflite',
    documentationUrl: 'https://pub.dev/packages/sqflite#-readme-tab-',
    buildRoute: SqfLiteTestPage.startPage,
  ),
  PageIndex(
    title: 'QrCode test',
    subtitle:
        "sqflite # SQLite plugin for Flutter. Supports both iOS and Android.",
    routeName: '/testQrCode',
    documentationUrl: 'https://pub.dev/packages/sqflite#-readme-tab-',
    buildRoute: QrCodePage.startPage,
  ),
  PageIndex(
    title: 'Video test',
    subtitle:
        "A Flutter plugin for iOS and Android for playing back video on a Widget surface.",
    routeName: '/videoTest',
    documentationUrl: 'https://pub.dev/packages/video_player',
    buildRoute: VideoTestPage.startPage,
  ),
  PageIndex(
    title: 'Provider Sample',
    subtitle:
        "A mixture between dependency injection (DI) and state management, built with widgets for widgets.",
    routeName: '/providerSample',
    documentationUrl: 'https://pub.dev/packages/provider',
    buildRoute: MultiScreensPage.startPage,
  ),
  PageIndex(
    title: 'My ListView Sample',
    subtitle: 'rewrite a listview class',
    routeName: '/testMyListView',
    buildRoute: TestMyListViewPage.startPage,
  ),
  PageIndex(
    title: 'My Listener Sample',
    subtitle: 'rewrite a listview class',
    routeName: '/testMyListenerWidget',
    buildRoute: TestMyListViewPage.startPage,
  )
];

// a routeMap should be submit to MaterialApp as a route
final Map<String, WidgetBuilder> routeMap =
    (Map<String, WidgetBuilder>.fromIterable(pageIndexList,
        key: (v) => v.routeName, value: (v) => v.buildRoute))
      ..['/'] = ((context) => MainPage());

// create the enter for the sub page
List<Widget> buildPageIndexWidgetList(context) {
  return pageIndexList
      .map((page) => ListTile(
            title: Text(page.title),
            subtitle: Text(page.subtitle),
            isThreeLine: true,
            onTap: () => Navigator.pushNamed(context, page.routeName),
          ))
      .toList();
}
