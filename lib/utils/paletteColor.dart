import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class PaletteColor {
  Future<Color> getColor({String imageUrl}) async {
    ImageProvider imageProvider;
    Color color;
    if (imageUrl != null) {
      imageProvider = NetworkImage(imageUrl);
    } else {
      imageProvider = new AssetImage('assets/bg.png');
    }

    try {
      PaletteGenerator paletteGenerator =
          await PaletteGenerator.fromImageProvider(imageProvider);
      if (paletteGenerator.lightMutedColor != null &&
          paletteGenerator.lightMutedColor.color != null) {
        color = paletteGenerator.lightMutedColor.color;
      } else if (paletteGenerator.lightVibrantColor != null &&
          paletteGenerator.lightVibrantColor.color != null) {
        color = paletteGenerator.lightVibrantColor.color;
      } else if (paletteGenerator.vibrantColor != null &&
          paletteGenerator.vibrantColor.color != null) {
        color = paletteGenerator.vibrantColor.color;
      } else if (paletteGenerator.colors.length > 0) {
        color = paletteGenerator.colors.last;
      }
    } catch (e) {
      imageProvider = new AssetImage('assets/bg.png');
      PaletteGenerator paletteGenerator =
          await PaletteGenerator.fromImageProvider(imageProvider);
      if (paletteGenerator.lightMutedColor != null &&
          paletteGenerator.lightMutedColor.color != null) {
        color = paletteGenerator.lightMutedColor.color;
      } else if (paletteGenerator.lightVibrantColor != null &&
          paletteGenerator.lightVibrantColor.color != null) {
        color = paletteGenerator.lightVibrantColor.color;
      } else if (paletteGenerator.vibrantColor != null &&
          paletteGenerator.vibrantColor.color != null) {
        color = paletteGenerator.vibrantColor.color;
      } else if (paletteGenerator.colors.length > 0) {
        color = paletteGenerator.colors.last;
      }
    }
    return color;
  }

  Future<Color> getDarkColor({String imageUrl}) async {
    ImageProvider imageProvider;
    Color color;
    if (imageUrl != null) {
      imageProvider = NetworkImage(imageUrl);
    } else {
      imageProvider = new AssetImage('assets/menu_cover.jpg');
    }

    try {
      PaletteGenerator paletteGenerator =
          await PaletteGenerator.fromImageProvider(imageProvider);
      if (paletteGenerator.darkMutedColor != null &&
          paletteGenerator.darkMutedColor.color != null) {
        color = paletteGenerator.darkMutedColor.color;
      } else if (paletteGenerator.darkVibrantColor != null &&
          paletteGenerator.darkVibrantColor.color != null) {
        color = paletteGenerator.darkVibrantColor.color;
      } else if (paletteGenerator.vibrantColor != null &&
          paletteGenerator.vibrantColor.color != null) {
        color = paletteGenerator.vibrantColor.color;
      } else if (paletteGenerator.colors.length > 0) {
        color = paletteGenerator.colors.first;
      }
    } catch (e) {
      imageProvider = new AssetImage('assets/menu_cover.jpg');
      PaletteGenerator paletteGenerator =
          await PaletteGenerator.fromImageProvider(imageProvider);
      if (paletteGenerator.lightMutedColor != null &&
          paletteGenerator.lightMutedColor.color != null) {
        color = paletteGenerator.lightMutedColor.color;
      } else if (paletteGenerator.lightVibrantColor != null &&
          paletteGenerator.lightVibrantColor.color != null) {
        color = paletteGenerator.lightVibrantColor.color;
      } else if (paletteGenerator.vibrantColor != null &&
          paletteGenerator.vibrantColor.color != null) {
        color = paletteGenerator.vibrantColor.color;
      } else if (paletteGenerator.colors.length > 0) {
        color = paletteGenerator.colors.last;
      }
    }
    return color;
  }
}
