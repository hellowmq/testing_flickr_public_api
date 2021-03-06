import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class CustomCacheManager extends BaseCacheManager {
  static const CacheKey = "customCache";

  static CustomCacheManager _instance;

  factory CustomCacheManager() {
    if (_instance == null) {
      _instance = new CustomCacheManager._();
    }
    return _instance;
  }

  CustomCacheManager._()
      : super(CacheKey,
            maxAgeCacheObject: Duration(days: 7),
            maxNrOfCacheObjects: 20,
            fileFetcher: _customHttpGetter);

  Future<String> getFilePath() async {
    var directory = await getTemporaryDirectory();
    return p.join(directory.path, CacheKey);
  }

  static Future<FileFetcherResponse> _customHttpGetter(String url,
      {Map<String, String> headers}) async {
    // Do things with headers, the url or whatever.
    return HttpFileFetcherResponse(await http.get(url, headers: headers));
  }
}
