library proste_bezier_curve;

import 'dart:math';

import 'package:flutter/material.dart';


/// Points of a Bezier curve
class BezierCurveSection {
  /// Bezier curve start point
  Offset start;

  /// Bezier top
  Offset top;

  /// Bezier end point
  Offset end;

  /// The ratio of the vertices of the Bezier curve
  double proportion;

  BezierCurveSection({
    required this.start,
    required this.top,
    required this.end,
    this.proportion = 1 / 2,
  })  : assert(proportion > 0),
        assert(proportion < 1);
}

/// A collection of points for a third-order Bézier curve
class ThirdOrderBezierCurveSection {
  /// starting point
  Offset p1;

  /// Second point
  Offset p2;

  /// third point
  Offset p3;

  /// fourth point
  Offset p4;

  /// Smoothness 0~1, the larger the value, the straighter the smaller the value, the larger the arc
  double smooth;

  ThirdOrderBezierCurveSection({
    required this.p1,
    required this.p2,
    required this.p3,
    required this.p4,
    this.smooth = .5,
  })  : assert(smooth >= 0),
        assert(smooth <= 1);
}

/// Line drawing position of Bezier curve
class BezierCurveDots {
  /// x-coordinate of the first point
  double x1;

  /// The y-coordinate of the first point
  double y1;

  /// x coordinate of the second point
  double x2;

  /// The y coordinate of the second point
  double y2;
  BezierCurveDots(
      this.x1,
      this.y1,
      this.x2,
      this.y2,
      );

  /// return array object
  List<double> getList() {
    return [x1, y1, x2, y2];
  }

  Map<String, double> getMap() {
    return {
      'x1': x1,
      'y1': y1,
      'x2': x2,
      'y2': y2,
    };
  }
}

/// Line drawing position of third-order Bézier
class ThirdOrderBezierCurveDots {
  /// x-coordinate of the first point
  double x1;

  /// The y-coordinate of the first point
  double y1;

  /// x coordinate of the second point
  double x2;

  /// The y coordinate of the second point
  double y2;

  /// x-coordinate of the third point
  double x3;

  /// The y-coordinate of the third point
  double y3;

  ThirdOrderBezierCurveDots(
      this.x1,
      this.y1,
      this.x2,
      this.y2,
      this.x3,
      this.y3,
      );

  List<double> getList() {
    return [x1, y1, x2, y2, x3, y3];
  }

  Map<String, double> getMap() {
    return {
      'x1': x1,
      'y1': y1,
      'x2': x2,
      'y2': y2,
      'x3': x3,
      'y3': y3,
    };
  }
}

/// Determining the position of the Bezier curve
enum ClipPosition {
  /// drawn on the left side of the element
  left,

  /// drawn at the bottom of the element
  bottom,

  /// drawn on the right side of the element
  right,

  /// drawn on top of the element
  top,
}

/// Create and return a Bezier cutting path
class ProsteBezierCurve extends CustomClipper<Path> {
  /// Whether to redraw the clip object
  bool reclip;

  /// Plot Bezier data
  List<BezierCurveSection> list;

  /// Bezier curve drawing position
  ClipPosition position;

  ProsteBezierCurve({
    required this.list,
    this.reclip = true,
    this.position = ClipPosition.left,
  }) : assert(list.length > 0);

  /// Calculating the drawing point data of the Bezier curve
  static BezierCurveDots calcCurveDots(BezierCurveSection param) {
    double x = (param.top.dx -
            (param.start.dx * pow((1 - param.proportion), 2) +
                pow(param.proportion, 2) * param.end.dx)) /
        (2 * param.proportion * (1 - param.proportion));
    double y = (param.top.dy -
            (param.start.dy * pow((1 - param.proportion), 2) +
                pow(param.proportion, 2) * param.end.dy)) /
        (2 * param.proportion * (1 - param.proportion));

    return BezierCurveDots(x, y, param.end.dx, param.end.dy);
  }

  /// Traverse drawing Bezier curve
  void _eachPath(List<BezierCurveSection> list, Path path) {
    list.forEach((element) {
      BezierCurveDots item = calcCurveDots(element);
      path.quadraticBezierTo(item.x1, item.y1, item.x2, item.y2);
    });
  }

  /// Get the Bezier curve path
  @override
  Path getClip(Size size) {
    Path path = Path();
    double firstStartX = list[0].start.dx;
    double firstStartY = list[0].start.dy;

    if (position == ClipPosition.left) {
      path.lineTo(max(0, firstStartX), 0);
      _eachPath(list, path);
      path.lineTo(0, size.height);
      path.lineTo(size.width, size.height);
      path.lineTo(size.width, 0);
      path.lineTo(max(0, firstStartX), 0);
    } else {
      path.lineTo(0, 0);
      path.lineTo(
        0,
        position == ClipPosition.bottom
            ? min(size.height, firstStartY)
            : size.height,
      );
    }

    if (position == ClipPosition.bottom) {
      _eachPath(list, path);
      path.lineTo(size.width, size.height);
      path.lineTo(size.width, 0);
      path.lineTo(0, 0);
    } else {
      path.lineTo(
        position == ClipPosition.right
            ? min(size.width, firstStartX)
            : size.width,
        size.height,
      );
    }

    if (position == ClipPosition.right) {
      _eachPath(list, path);
      path.lineTo(size.width, 0);
      path.lineTo(0, 0);
    } else {
      path.lineTo(
          size.width, position == ClipPosition.top ? max(0, firstStartY) : 0);
    }

    if (position == ClipPosition.top) {
      _eachPath(list, path);
      path.lineTo(0, 0);
    }

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => reclip;
}

/// Creates and returns a third-order Bézier cutting path
class ProsteThirdOrderBezierCurve extends CustomClipper<Path> {
  /// Whether to redraw the clip object
  bool reclip;

  /// Plot Bezier data
  List<ThirdOrderBezierCurveSection> list;

  /// Bezier curve drawing position
  ClipPosition position;

  ProsteThirdOrderBezierCurve({
    required this.list,
    this.position = ClipPosition.left,
    this.reclip = true,
  }) : assert(list.length > 0);

  /// Calculating the drawing point data of the third-order Bezier curve
  static ThirdOrderBezierCurveDots calcCurveDots(
      ThirdOrderBezierCurveSection param) {
    double x0 = param.p1.dx,
        y0 = param.p1.dy,
        x1 = param.p2.dx,
        y1 = param.p2.dy,
        x2 = param.p3.dx,
        y2 = param.p3.dy,
        x3 = param.p4.dx,
        y3 = param.p4.dy;

    double xc1 = (x0 + x1) / 2.0;
    double yc1 = (y0 + y1) / 2.0;
    double xc2 = (x1 + x2) / 2.0;
    double yc2 = (y1 + y2) / 2.0;
    double xc3 = (x2 + x3) / 2.0;
    double yc3 = (y2 + y3) / 2.0;

    double len1 = sqrt((x1 - x0) * (x1 - x0) + (y1 - y0) * (y1 - y0));
    double len2 = sqrt((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1));
    double len3 = sqrt((x3 - x2) * (x3 - x2) + (y3 - y2) * (y3 - y2));

    double k1 = len1 / (len1 + len2);
    double k2 = len2 / (len2 + len3);

    double xm1 = xc1 + (xc2 - xc1) * k1;
    double ym1 = yc1 + (yc2 - yc1) * k1;
    double xm2 = xc2 + (xc3 - xc2) * k2;
    double ym2 = yc2 + (yc3 - yc2) * k2;

    double resultX1 = xm1 + (xc2 - xm1) * param.smooth + x1 - xm1;
    double resultY1 = ym1 + (yc2 - ym1) * param.smooth + y1 - ym1;
    double resultX2 = xm2 + (xc2 - xm2) * param.smooth + x2 - xm2;
    double resultY2 = ym2 + (yc2 - ym2) * param.smooth + y2 - ym2;

    return ThirdOrderBezierCurveDots(
        resultX1, resultY1, resultX2, resultY2, param.p4.dx, param.p4.dy);
  }

  /// traversal draw curve
  void _eachPath(List<ThirdOrderBezierCurveSection> list, Path path) {
    list.forEach((element) {
      ThirdOrderBezierCurveDots item = calcCurveDots(element);
      path.cubicTo(item.x1, item.y1, item.x2, item.y2, item.x3, item.y3);
    });
  }

  /// Get the third-order Bezier curve path
  @override
  Path getClip(Size size) {
    Path path = Path();

    double firstStartX = list[0].p1.dx;
    double firstStartY = list[0].p1.dy;

    if (position == ClipPosition.left) {
      path.lineTo(max(0, firstStartX), 0);
      _eachPath(list, path);
      path.lineTo(0, size.height);
      path.lineTo(size.width, size.height);
      path.lineTo(size.width, 0);
      path.lineTo(max(0, firstStartX), 0);
    } else {
      path.lineTo(0, 0);
      path.lineTo(
        0,
        position == ClipPosition.bottom
            ? min(size.height, firstStartY)
            : size.height,
      );
    }

    if (position == ClipPosition.bottom) {
      _eachPath(list, path);
      path.lineTo(size.width, size.height);
      path.lineTo(size.width, 0);
      path.lineTo(0, 0);
    } else {
      path.lineTo(
        position == ClipPosition.right
            ? min(size.width, firstStartX)
            : size.width,
        size.height,
      );
    }

    if (position == ClipPosition.right) {
      _eachPath(list, path);
      path.lineTo(size.width, 0);
      path.lineTo(0, 0);
    } else {
      path.lineTo(
          size.width, position == ClipPosition.top ? max(0, firstStartY) : 0);
    }

    if (position == ClipPosition.top) {
      _eachPath(list, path);
      path.lineTo(0, 0);
    }

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => reclip;
}
