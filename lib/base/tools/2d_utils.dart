import 'dart:math';
import 'package:ml_linalg/linalg.dart';

class TwoDUtils {
  static List<double> polar2XY(num rou, num theta) {
    double x = rou * cos(theta);
    double y = rou * sin(theta);
    return new List()..add(x)..add(y);
  }

  static double XY2polarRou(num x, num y) {
    return sqrt(x * x + y * y);
  }

  static double XY2polarTheta(num x, num y) {
    if (x == 0) return ((y > 0) ? (pi / 2) : pi * 3 / 2);
    if (x < 0) {
      return atan(y / x) + pi;
    } else if (y < 0) {
      return atan(y / x) + pi * 2;
    } else {
      return atan(y / x);
    }
  }

  static double distance(List<num> point1, List<num> point2) {
    Vector v1 = Vector.fromList(point1);
    Vector v2 = Vector.fromList(point2);
    return (v1 - v2).norm();
  }
}
