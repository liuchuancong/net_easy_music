import 'package:flutter/material.dart';
import 'package:net_easy_music/type/platform_type.dart';

class CustomIcon extends StatelessWidget {
  final int codePoint;
  final double size;
  final Function onTape;
  final Color color;
  final PlatformMusic platformMusic;
  final PlatformMusic activePlatformMusic;
  const CustomIcon({
    Key key,
    @required this.codePoint,
    this.size = 20,
    this.onTape,
    this.color = Colors.white24,
    @required this.platformMusic,
    this.activePlatformMusic,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        IconData(codePoint, fontFamily: 'iconfont'),
        color: platformMusic == activePlatformMusic
            ? Colors.white60
            : Colors.white24,
        size: size,
      ),
      onPressed: onTape,
    );
  }
}
