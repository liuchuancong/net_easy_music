import 'package:flutter/material.dart';

class ControlButton extends StatelessWidget {
  final int codePoint;
  final double size;
  const ControlButton({Key key, @required this.codePoint, this.size = 20.0})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: IconButton(
            icon: Icon(
              IconData(codePoint, fontFamily: 'iconfont'),
              color: Colors.white60,
              size: size,
            ),
            onPressed: null));
  }
}
