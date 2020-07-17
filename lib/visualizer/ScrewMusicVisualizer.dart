import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;

class ScrewMusicVisualizer extends CustomPainter {
  final List<int> waveData;
  final double height;
  final double width;

  ScrewMusicVisualizer({
    @required this.waveData,
    @required this.height,
    @required this.width,
  })  : assert(waveData != null),
        assert(height != null),
        assert(width != null);

  @override
  void paint(Canvas canvas, Size size) {
    if (waveData != null) {
      int fftSize = 256;
      List arr = [];
      final _paint = Paint();
      Path path = new Path();
      for (var i = 0; i < waveData.length - 1; i++) {
        final Map visibleData = getDrawData(i, ['a', 'r']);
        double r = visibleData['r'];
        double angle = visibleData['a'];
        r *= 0.6 * (1 - i / (fftSize / 2)) * (1 - i / ((fftSize / 2)));
        angle *= 4;
        if (angle > 4 * math.pi || angle < 0) {
          return;
        } else if (angle > 0 && angle < 4 * math.pi) {
          Map map = new Map();
          map['x'] = width / 2 +
              math.sin(angle) * (r + waveData[i] / fftSize * r * 0.4);
          map['y'] = height / 2 -
              math.cos(angle) * (r + waveData[i] / fftSize * r * 0.4);
          map['x1'] = width / 2 + math.sin(angle) * r * 0.8;
          map['y1'] = height / 2 - math.cos(angle) * r * 0.8;
          // _paint.shader = ui.Gradient.radial(Offset(width / 2, height / 2), r,
          //     [Color(0x409EFF66), Color(0x5cB87a66)]);
          arr.add(map);
        }
        if (angle == 4 * math.pi) {
          for (var i = 0; i < arr.length; i++) {
            path.moveTo(arr[i]['x'], arr[i]['y']);
            path.lineTo(arr[i]['x1'], arr[i]['y1']);

            _paint.style = PaintingStyle.stroke; // 画线模式
            _paint.strokeWidth = math.max(4 * math.pi * r / (fftSize / 2), 2);
            final Gradient gradient = new LinearGradient(
              colors: <Color>[
                Colors.lightGreen.withOpacity(1.0),
                Colors.green.withOpacity(0.3),
                Colors.yellow.withOpacity(0.2),
                Colors.red.withOpacity(0.1),
                Colors.red.withOpacity(0.0),
              ],
              stops: [
                0.0,
                0.5,
                0.7,
                0.9,
                1.0,
              ],
            );
            _paint.shader = gradient.createShader(new Rect.fromLTWH(arr[i]['x'], arr[i]['y'], arr[i]['x1'], arr[i]['y1']));
            _paint.color = Colors.black;

            canvas.drawPath(path, _paint);
          }
        }
      }
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
