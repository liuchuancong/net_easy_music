import 'package:flutter/material.dart';

class ControlButton extends StatelessWidget {
  final int codePoint;
  final double size;
  final Function onControlTaped;
  final Color color;
  const ControlButton(
      {Key key,
      @required this.codePoint,
      this.size = 20.0,
      this.onControlTaped,
      this.color = Colors.white60})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: IconButton(
            icon: Icon(
              IconData(codePoint, fontFamily: 'iconfont'),
              color: color,
              size: size,
            ),
            onPressed: onControlTaped));
  }
}
