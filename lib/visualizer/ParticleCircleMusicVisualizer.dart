import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;

class ParticleCircleMusicVisualizer extends CustomPainter {
  final List<int> waveData;
  final double height;
  final double width;
  ParticleCircleMusicVisualizer({
    @required this.waveData,
    @required this.height,
    @required this.width,
  })  : assert(waveData != null),
        assert(height != null),
        assert(width != null);

  @override
  void paint(Canvas canvas, Size size) {
    if (waveData != null) {
      List<Bubble> musicParticleList = [];

      for (var i = 0; i < waveData.length - 1; i++) {
        if (waveData[i] > 0 && math.Random().nextDouble() < 0.02) {
          musicParticleList
              .add(Bubble(Colors.white, width, height, waveData[i], i));
        }
      }
      musicParticleList = musicParticleList.where((p) => !p.disappear).toList();
      musicParticleList.forEach((it) => it.draw(canvas, size));
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class Bubble {
  Color color;
  double direction;
  double speed;
  double radius;
  int wava;
  double x;
  double y;
  bool disappear = false;
  Bubble(Color color, double width, double height, int wava, int index) {
    this.wava = wava;
    this.color = color.withAlpha((wava / 256 * 100).floor());
    this.direction = math.Random().nextDouble() * 360;
    this.speed = 0.01;
    this.radius = math.Random().nextDouble() * 5 + (wava / 256 * 7);
  }

  draw(Canvas canvas, Size canvasSize) {
    Paint paint = new Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    assignRandomPositionIfUninitialized(canvasSize);

    randomlyChangeDirectionIfEdgeReached(canvasSize);

    canvas.drawCircle(Offset(x, y), radius, paint);
  }

  void assignRandomPositionIfUninitialized(Size canvasSize) {
    if (x == null) {
      this.x = math.Random().nextDouble() * canvasSize.width;
    }

    if (y == null) {
      this.y = math.Random().nextDouble() * canvasSize.height;
    }
  }

  updatePosition() {
    if (radius < 2) {
      this.disappear = true;
      return;
    }
    var a = 180 - (direction + 90);
    radius*= 0.99;
    direction > 0 && direction < 180
        ? x += speed * math.sin(direction) / math.sin(speed)
        : x -= speed * math.sin(direction) / math.sin(speed);
    direction > 90 && direction < 270
        ? y += speed * math.sin(a) / math.sin(speed)
        : y -= speed * math.sin(a) / math.sin(speed);
  }

  randomlyChangeDirectionIfEdgeReached(Size canvasSize) {
    if (x > canvasSize.width || x < 0 || y > canvasSize.height || y < 0) {
      direction = math.Random().nextDouble() * 360;
    }
  }
}
