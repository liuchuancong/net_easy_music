import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;
import 'dart:ui';

class CurveMusicVisualizer extends CustomPainter {
  final List<int> waveData;
  final double height;
  final double width;
  final int density;
  final int gap;

  CurveMusicVisualizer(
      {@required this.waveData,
      @required this.height,
      @required this.width,
      this.density = 100,
      this.gap = 2})
      : assert(waveData != null),
        assert(height != null),
        assert(width != null);

  @override
  void paint(Canvas canvas, Size size) {
    if (waveData != null) {
      double _strokeWidth = 1;
      List<Offset> arr0 = [], arr1 = [], arr2 = [];
      final _paint1 = Paint()
        ..color = Color(0x409EFF33)
        ..strokeWidth = _strokeWidth;
      final _paint2 = Paint()
        ..color = Color(0x5cB87a33)
        ..strokeWidth = _strokeWidth;
      final _paint3 = Paint()
        ..color = Color(0xE6A23C33)
        ..strokeWidth = _strokeWidth;
      for (var i = 0; i < waveData.length - 1; i++) {
        final Map visibleData = getDrawData(i, ['x', 'y', 'y1', 'y2']);
        arr0.add(new Offset(visibleData['x'], visibleData['y'] - 50));
        arr1.add(new Offset(visibleData['x'], visibleData['y1'] - 50));
        arr2.add(new Offset(visibleData['x'], visibleData['y2'] - 50));
      }
      canvas.drawPoints(PointMode.polygon, arr0, _paint1);
      canvas.drawPoints(PointMode.polygon, arr1, _paint2);
      canvas.drawPoints(PointMode.polygon, arr2, _paint3);
      // canvas.drawPath(_path1, _paint1);
      // canvas.drawPath(_path1, _paint2);
      // canvas.drawPath(_path1, _paint3);
    }
  }

  getNum(v, val) {
    if (v == 0) return 0;
    double n = v + math.Random().nextInt(30) - val;
    if (n < 0) return 0;
    if (n > 255) return 255;
    return n;
  }

  getDrawData(i, arr) {
    double num = 256 / 2;
    double v = waveData[i].toDouble();
    Map result = new Map();

    arr.forEach((k) {
      switch (k) {
        case 'x':
          result[k] = (width * i / num).toDouble();
          break;
        case 'y':
          result[k] = (height - 80 - v / 256 * height / 2).toDouble();
          break;
        case 'y1':
          result[k] =
              (height - 80 - getNum(v, 12) / 256 * height / 2).toDouble();
          break;
        case 'y2':
          result[k] =
              (height - 80 - getNum(v, 18) / 256 * height / 2).toDouble();
          break;
        case 'w':
          result[k] = (width * 0.9 / num).toDouble();
          break;
        case 'h':
          result[k] = (v / 256 * height / 2).toDouble();
          break;
        case 'a':
          double a = math.pi / (num / 4 * 3);
          result[k] = {
            1: (a * i).toDouble(),
            2: (a * (i - num / 8)).toDouble(),
          }[1];
          break;
        case 'r':
          result[k] = (height / 4).toDouble();
          break;
      }
    });
    return result;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
