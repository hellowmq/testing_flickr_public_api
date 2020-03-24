import 'package:wenmq_first_flickr_flutter_app/base/tools/2d_utils.dart';

class Point {
  double x;
  double y;

  double get rou => TwoDUtils.XY2polarRou(x, y);

  double get theta => TwoDUtils.XY2polarTheta(x, y);
}
