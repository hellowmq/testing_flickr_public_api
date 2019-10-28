import 'package:wenmq_first_flickr_flutter_app/api/flickr_photo_api.dart';
import 'package:wenmq_first_flickr_flutter_app/base/base_tool.dart';

class GetPhotoListViewModel {
  int page = 0;
  final int _perPage;
  List<Photo> _photoList = List();

  List<Photo> get photoList => _photoList;

  GetPhotoListViewModel._(this._methodName, this._perPage);

  final String _methodName;

  GetPhotoListViewModel.build(this._methodName, this._perPage);

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
    int perPage = _perPage;
    Map<String, String> params = Map();
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
      _methodName,
      params: params,
      onSuccess: onSuccess,
      onError: onError,
    );
  }
}

class GetPhotoListViewModelBuilder {
  String methodName;
  int perPage;

  GetPhotoListViewModelBuilder();

  GetPhotoListViewModel build() {
    if (methodName == null || methodName == '') {
      throw Exception("GetPhotoListViewModelBuilder methodName is empty");
    }
    if (perPage <= 0) {
      throw Exception("GetPhotoListViewModelBuilder perPage <= 0");
    }
    return GetPhotoListViewModel.build(methodName, perPage);
  }

  static GetPhotoListViewModel getRecentViewModel() {
    var model = GetPhotoListViewModelBuilder()
      ..perPage = 10
      ..methodName = "flickr.photos.getRecent";
    return model.build();
  }

  static GetPhotoListViewModel getPopularViewModel() {
    var model = GetPhotoListViewModelBuilder()
      ..perPage = 10
      ..methodName = "flickr.photos.getPopular";
    return model.build();
  }
}
