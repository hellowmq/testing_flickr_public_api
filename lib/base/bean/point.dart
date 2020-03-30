import 'dart:math';

import 'package:ml_linalg/linalg.dart';
import 'package:ml_linalg/vector.dart';
import 'package:wenmq_first_flickr_flutter_app/base/tools/2d_utils.dart';

class Point {
  Vector pxy; // position vector
  Vector vxy; // velocity vector
  double get px => pxy[0];
  set px(double x) => (pxy as Iterable<double>)[0] = x;

  double get py => pxy[1];

  double get vx => vxy[0];

  double get vy => vxy[1];

  double get pr => vxy.norm();

  set pr(double radius) {
    if (pr > 0) {
      pxy = Vector.fromList([radius * cos(ptheta), radius * sin(ptheta)]);
    } else if (pr == 0) {
      pxy = Vector.fromList([0.0, 0.0]);
    } else {
      throw Exception("radius cannot be negative!");
    }
  }

  double get ptheta => TwoDUtils.XY2polarTheta(px, py);

  set ptheta(double theta) {
    pxy = Vector.fromList([pr * cos(theta), pr * sin(theta)]);
  }

  double get vr => vxy.norm();

  set vr(double radius) {
    if (vr > 0) {
      vxy = Vector.fromList([radius * cos(vtheta), radius * sin(vtheta)]);
    } else if (vr == 0) {
      vxy = Vector.fromList([0.0, 0.0]);
    } else {
      throw Exception("radius cannot be negative!");
    }
  }

  double get vtheta => TwoDUtils.XY2polarTheta(vx, vy);

  set vtheta(double theta) {
    vxy = Vector.fromList([vr * cos(theta), vr * sin(theta)]);
  }

  void step(double time) {
        pxy = pxy + vxy * time;
  }
}
