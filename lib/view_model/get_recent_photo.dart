import 'dart:async';

import 'package:wenmq_first_flickr_flutter_app/base/base_tool.dart';
import 'package:wenmq_first_flickr_flutter_app/api/flickr_photo_api.dart';
import 'get_popular_photo.dart';

class GetRecentViewModel extends GetPhotoListViewModel{

  @override
  String getMethodName() {
    // TODO: implement getMethodName
    return "flickr.photos.getRecent";
  }

}