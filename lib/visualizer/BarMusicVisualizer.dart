import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;
import 'dart:ui' as ui;

class BarMusicVisualizer extends CustomPainter {
  final List<int> waveData;
  final double height;
  final double width;
  final Paint wavePaint;
  final int density;
  final int gap;

  BarMusicVisualizer(
      {@required this.waveData,
      @required this.height,
      @required this.width,
      this.density = 100,
      this.gap = 2})
      : wavePaint = new Paint(),
        assert(waveData != null),
        assert(height != null),
        assert(width != null);

  @override
  void paint(Canvas canvas, Size size) {
    if (waveData != null) {
      double barWidth = width / density;
      double div = waveData.length / density;
      wavePaint.strokeWidth = barWidth - gap;
      for (int i = 0; i < density; i++) {
        int bytePosition = (i * div).ceil();
        double top = (height / 2 - (((waveData[bytePosition]) - 128).abs()));
        double barX = (i * barWidth) + (barWidth / 2);
        if (top > height) top = top - height;
        wavePaint.shader = ui.Gradient.linear(Offset(barX, height / 2),
            Offset(barX, top), [Color(0x409EFF33), Color(0x409EFF33)]);
        canvas.drawLine(Offset(barX, height / 2), Offset(barX, top), wavePaint);
      }
      // print(waveData.length);
      // for (var i = 0; i < waveData.length; i++) {
      //   final Map visibleData = getDrawData(i, ['x', 'y', 'w', 'h']);
      //   if (i == 0) {
      //     wavePaint.shader = ui.Gradient.linear(
      //         Offset(visibleData['x'], height),
      //         Offset(visibleData['x'], height),
      //         [Color(0x5cB87a33),Color(0x409EFF33)]);
      //   }
      //   canvas.drawRect(
      //       new Rect.fromLTWH(visibleData['x'], visibleData['y'],
      //           visibleData['w'], visibleData['h']),
      //       wavePaint);
      // }
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
    int v = waveData[i];
    Map result = new Map();

    arr.forEach((k) {
      switch (k) {
        case 'x':
          result[k] = width * i / num;
          break;
        case 'y':
          result[k] = height - 80 - v / 256 * height / 2;
          break;
        case 'y1':
          result[k] = height - 80 - getNum(v, 12) / 256 * height / 2;
          break;
        case 'y2':
          result[k] = height - 80 - getNum(v, 18) / 256 * height / 2;
          break;
        case 'w':
          result[k] = width * 0.9 / num;
          break;
        case 'h':
          result[k] = v / 256 * height / 2;
          break;
        case 'a':
          double a = math.pi / (num / 4 * 3);
          result[k] = {
            1: a * i,
            2: a * (i - num / 8),
          }[1];
          break;
        case 'r':
          result[k] = height / 4;
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
