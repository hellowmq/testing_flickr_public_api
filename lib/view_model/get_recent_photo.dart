import 'get_popular_photo.dart';

class GetRecentViewModel extends GetPhotoListViewModel{

  @override
  String getMethodName() {
    // TODO: implement getMethodName
    return "flickr.photos.getRecent";
  }

}