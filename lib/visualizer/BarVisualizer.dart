import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui' as ui;

class BarVisualizer extends CustomPainter {
  final List<int> waveData;
  final double height;
  final double width;
  final Paint wavePaint;
  final int density;
  final int gap;

  BarVisualizer(
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
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
