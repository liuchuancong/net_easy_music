import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class PaletteColor {

  Future<Color> getColor({String imageUrl}) async {
    ImageProvider imageProvider;
    Color color;
    if (imageUrl != null) {
      imageProvider = CachedNetworkImageProvider(
        imageUrl,
      );
    } else {
      imageProvider = new AssetImage('assets/bg.png');
    }

    PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(imageProvider);
        if(paletteGenerator.lightMutedColor!=null && paletteGenerator.lightMutedColor.color !=null){
          color = paletteGenerator.lightMutedColor.color;
        }else if(paletteGenerator.lightVibrantColor!=null &&paletteGenerator.lightVibrantColor.color!=null){
           color = paletteGenerator.lightVibrantColor.color;
        }else if(paletteGenerator.vibrantColor!=null &&paletteGenerator.vibrantColor.color!=null){
           color = paletteGenerator.vibrantColor.color;
        }else if(paletteGenerator.colors.length>0){
           color = paletteGenerator.colors.last;
        }
    return color;
  }
}
