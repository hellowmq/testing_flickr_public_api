import 'package:wenmq_first_flickr_flutter_app/api/flickr_photo_api.dart';
import 'package:wenmq_first_flickr_flutter_app/base/base_tool.dart';

abstract class GetPhotoListViewModel {
  int page = 0;
  List<Photo> _photoList = new List();
  List<Photo> get photoList => _photoList;

  /// This is a time-consuming operation.
  /// remove all the Photo before and load one page.
  refreshPhotoList() {
    _photoList.clear();
    page = 0;
    loadMorePhotoList();
  }

  /// This is a time-consuming operation.
  /// Load another one page of ten photo.
  loadMorePhotoList() {
    page++;
    int perPage = 10;
    Map<String, String> params = new Map();
    params
      ..['per_page'] = perPage.toString()
      ..['page'] = page.toString();
    var onSuccess = (List<Photo> photoList) {
      _photoList.addAll(photoList);
    };
    var onError = (Exception e, response) {
      print(e);
      page--;
    };
    MFlickrPhotoApi().getPhotoList(
      getMethodName(),
      params: params,
      onSuccess: onSuccess,
      onError: onError,
    );
  }

  String getMethodName();
}

