import 'dart:math';

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
}
