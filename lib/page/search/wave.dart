import 'dart:async';
import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:net_easy_music/page/search/wave_config.dart';

class WaveWidget extends StatefulWidget {
  final Config config;
  final Size size;
  final double waveAmplitude;
  final double wavePhase;
  final double waveFrequency;
  final double heightPercentange;
  final int duration;
  final Color backgroundColor;
  final bool isLoop;

  WaveWidget({
    @required this.config,
    this.duration = 6000,
    @required this.size,
    this.waveAmplitude = 20.0,
    this.waveFrequency = 1.6,
    this.wavePhase = 10.0,
    this.backgroundColor,
    this.heightPercentange = 0.2,
    this.isLoop = true,
  });

  @override
  State<StatefulWidget> createState() => _WaveWidgetState();
}

class _WaveWidgetState extends State<WaveWidget> with TickerProviderStateMixin {
  List<AnimationController> _waveControllers;
  List<Animation<double>> _wavePhaseValues;

  List<double> _waveAmplitudes = [];
  Map<Animation<double>, AnimationController> valueList;
  Timer _endAnimationTimer;

  _initAnimations() {
    if (widget.config.colorMode == ColorMode.custom) {
      _waveControllers =
          (widget.config as CustomConfig).durations.map((duration) {
        _waveAmplitudes.add(widget.waveAmplitude + 10);
        return AnimationController(
            vsync: this, duration: Duration(milliseconds: duration));
      }).toList();

      _wavePhaseValues = _waveControllers.map((controller) {
        CurvedAnimation _curve =
            CurvedAnimation(parent: controller, curve: Curves.linear);
        Animation<double> value = Tween(
          begin: widget.wavePhase,
          end: 360 + widget.wavePhase,
        ).animate(
          _curve,
        );
        controller.repeat();
        return value;
      }).toList();

      // If isLoop is false, stop the animation after the specified duration.
      if (!widget.isLoop) {
        _endAnimationTimer = Timer(Duration(milliseconds: widget.duration), () {
          for (AnimationController waveController in _waveControllers) {
            waveController.stop();
          }
        });
      }
    }
  }

  _buildPaints() {
    List<Widget> paints = [];
    if (widget.config.colorMode == ColorMode.custom) {
      List<Color> _colors = (widget.config as CustomConfig).colors;
      List<List<Color>> _gradients = (widget.config as CustomConfig).gradients;
      Alignment begin = (widget.config as CustomConfig).gradientBegin;
      Alignment end = (widget.config as CustomConfig).gradientEnd;
      for (int i = 0; i < _wavePhaseValues.length; i++) {
        paints.add(
          Container(
            child: CustomPaint(
              painter: _CustomWavePainter(
                color: _colors == null ? null : _colors[i],
                gradient: _gradients == null ? null : _gradients[i],
                gradientBegin: begin,
                gradientEnd: end,
                heightPercentange:
                    (widget.config as CustomConfig).heightPercentages[i],
                repaint: _waveControllers[i],
                waveFrequency: widget.waveFrequency,
                wavePhaseValue: _wavePhaseValues[i],
                waveAmplitude: _waveAmplitudes[i],
                blur: (widget.config as CustomConfig).blur,
              ),
              size: widget.size,
            ),
          ),
        );
      }
    }
    return paints;
  }

  _disposeAnimations() {
    _waveControllers.forEach((controller) {
      controller.dispose();
    });
  }

  @override
  void initState() {
    super.initState();
    _initAnimations();
  }

  @override
  void dispose() {
    _disposeAnimations();
    _endAnimationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor,
      child: Stack(
        children: _buildPaints(),
      ),
    );
  }
}

/// Meta data of layer
class Layer {
  final Color color;
  final List<Color> gradient;
  final MaskFilter blur;
  final Path path;
  final double amplitude;
  final double phase;

  Layer({
    this.color,
    this.gradient,
    this.blur,
    this.path,
    this.amplitude,
    this.phase,
  });
}

class _CustomWavePainter extends CustomPainter {
  final ColorMode colorMode;
  final Color color;
  final List<Color> gradient;
  final Alignment gradientBegin;
  final Alignment gradientEnd;
  final MaskFilter blur;

  double waveAmplitude;

  Animation<double> wavePhaseValue;

  double waveFrequency;

  double heightPercentange;

  double _tempA = 0.0;
  double _tempB = 0.0;
  double viewWidth = 0.0;
  Paint _paint = Paint();

  _CustomWavePainter(
      {this.colorMode,
      this.color,
      this.gradient,
      this.gradientBegin,
      this.gradientEnd,
      this.blur,
      this.heightPercentange,
      this.waveFrequency,
      this.wavePhaseValue,
      this.waveAmplitude,
      Listenable repaint})
      : super(repaint: repaint);

  _setPaths(double viewCenterY, Size size, Canvas canvas) {
    Layer _layer = Layer(
      path: Path(),
      color: color,
      gradient: gradient,
      blur: blur,
      amplitude: (1.6) * waveAmplitude,
      phase: wavePhaseValue.value * 2 + 30,
    );

    _layer.path.reset();
    _layer.path.moveTo(
        0.0,
        viewCenterY +
            _layer.amplitude * _getSinY(_layer.phase, waveFrequency, -1));
    _layer.path.quadraticBezierTo(
        0.0,
        viewCenterY +
            _layer.amplitude * _getSinY(_layer.phase, waveFrequency, -1),
        size.width,
        viewCenterY +
            _layer.amplitude *
                _getSinY(_layer.phase, waveFrequency, size.height.toInt()));
    _layer.path.lineTo(size.width, size.height);
    _layer.path.lineTo(0.0, size.height);
    _layer.path.close();
    if (_layer.color != null) {
      _paint.color = _layer.color;
    }
    if (_layer.gradient != null) {
      var rect = Offset.zero &
          Size(size.width, size.height - viewCenterY * heightPercentange);
      _paint.shader = LinearGradient(
              begin: gradientBegin == null
                  ? Alignment.bottomCenter
                  : gradientBegin,
              end: gradientEnd == null ? Alignment.topCenter : gradientEnd,
              colors: _layer.gradient)
          .createShader(rect);
    }
    if (_layer.blur != null) {
      _paint.maskFilter = _layer.blur;
    }

    _paint.style = PaintingStyle.fill;
    canvas.drawPath(_layer.path, _paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    double viewCenterY = size.height * (heightPercentange + 0.1);
    viewWidth = size.width;
    _setPaths(viewCenterY, size, canvas);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  double _getSinY(
      double startradius, double waveFrequency, int currentposition) {
    if (_tempA == 0) {
      _tempA = pi / viewWidth;
    }
    if (_tempB == 0) {
      _tempB = 2 * pi / 360.0;
    }

    return (sin(
        _tempA * waveFrequency * (currentposition + 1) + startradius * _tempB));
  }
}
