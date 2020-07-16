import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

///播放列表头部背景
class PlayListHeaderBackground extends StatelessWidget {
  final String imageUrl;

  const PlayListHeaderBackground({Key key, @required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: <Widget>[
        imageUrl != null
            ? new CachedNetworkImage(
                width: 120,
                height: 1,
                imageUrl:
                    imageUrl.contains('http') ? imageUrl : 'http' + imageUrl,
                errorWidget: (context, url, error) => new Image.asset(
                    'assets/menu_cover.jpg',
                    fit: BoxFit.cover,
                    width: 120,
                    height: 1),
                fit: BoxFit.cover)
            : new Image.asset(
                'assets/menu_cover.jpg',
                fit: BoxFit.cover,
                width: 120,
                height: 1,
              ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
          child: Container(color: Colors.black.withOpacity(0.3)),
        ),
        Container(color: Colors.black.withOpacity(0.3))
      ],
    );
  }
}
