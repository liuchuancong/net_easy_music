import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BlurBackground extends StatelessWidget {
  final String imageUrl;

  const BlurBackground({Key key,this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Image(
          image: imageUrl != null
              ? CachedNetworkImageProvider(
                  imageUrl.toString(),
                )
              : new AssetImage('assets/bg.png'),
          fit: BoxFit.cover,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          gaplessPlayback: true,
        ),
        BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaY: 50, sigmaX: 60),
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent.withOpacity(0.5),
                Colors.transparent.withOpacity(0.4),
                Colors.transparent.withOpacity(0.2),
                Colors.transparent.withOpacity(0.1),
              ],
            )),
          ),
        ),
      ],
    );
  }
}

// BoxDecoration(
//               gradient: new LinearGradient(begin: Alignment.topCenter, colors: [
//             HSLColor.fromAHSL(.53, 0, 0, 1).toColor(),
//             HSLColor.fromAHSL(.4, 0, 0, 1).toColor(),
//             HSLColor.fromAHSL(.0, 0, 0, 1).toColor(),
//             HSLColor.fromAHSL(.0, 0, 0, 1).toColor()
//           ])),
