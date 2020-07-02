import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;
import 'dart:ui' as ui;

class CircleMusicVisualizer extends CustomPainter {
  final List<int> waveData;
  final double height;
  final double width;

  CircleMusicVisualizer({
    @required this.waveData,
    @required this.height,
    @required this.width,
  })  : assert(waveData != null),
        assert(height != null),
        assert(width != null);

  @override
  void paint(Canvas canvas, Size size) {
    if (waveData != null) {
      List arr = [];
      final _paint = Paint();
      Path path = new Path();
      for (var i = 0; i < waveData.length - 1; i++) {
        final Map visibleData = getDrawData(i, ['a', 'r', 'h']);
        double r = visibleData['r'];
        double angle = visibleData['a'];
        double h = visibleData['h'];
        _paint.shader = ui.Gradient.radial(Offset(width / 2, height / 2), 10,
            [Color(0x409EFF00), Color(0x9c409EFF66)]);
        r *= 0.8;
        if (angle > math.pi || angle < 0) {
          return;
        } else if (angle > 0 && angle < math.pi) {
          Map map = new Map();
          map['x'] = width / 2 - math.sin(angle) * (r - 10 - h / 20);
          map['y'] = height / 2 - math.cos(angle) * (r - 10 - h / 20);
          map['x1'] = width / 2 - math.sin(angle) * (r + h / 6);
          map['y1'] = height / 2 - math.cos(angle) * (r + h / 6);
          arr.add(map);
        }
        print(angle);
        Map map = new Map();
        map['x'] = width / 2 + math.sin(angle) * (r - 10 - h / 20);
        map['y'] = height / 2 - math.cos(angle) * (r - 10 - h / 20);
        map['x1'] = width / 2 + math.sin(angle) * (r + h / 6);
        map['y1'] = height / 2 - math.cos(angle) * (r + h / 6);
        arr.add(map);

        if (angle == math.pi) {
          for (var i = 0; i < arr.length; i++) {
            path.moveTo(arr[i]['x'], arr[i]['y']);
            path.lineTo(arr[i]['x1'], arr[i]['y1']);
            _paint.style = PaintingStyle.stroke; // 画线模式
            _paint.strokeWidth = 0.8;
          }
        }
        canvas.drawPath(path, _paint);
      }

      // canvas.drawPath(_path1, _paint);
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
