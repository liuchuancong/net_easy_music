import 'package:flutter/material.dart';

class CardViewModel {
  final String backdropAssetPath;
  final String headerTitle;
  final String title;
  final String subTitle;
  final IconData weatherType;
  final String temp;
  final String time;
  final IconData weatherCenterIcon;
  
  CardViewModel({
    this.backdropAssetPath,
    this.headerTitle,
    this.title,
    this.subTitle,
    this.weatherType,
    this.temp,
    this.time,
    this.weatherCenterIcon,
  });
}


final List<CardViewModel> heroCards = [
  new CardViewModel(
    backdropAssetPath: 'https://pics6.baidu.com/feed/0b55b319ebc4b7452ab683666889f2118a82151f.png?token=7a08a149c4ca0088d786fdfdc2cd9af9',
    headerTitle: '氤氲山气',
    title: '山水画卷',
    subTitle: '亮丽',
    weatherType: Icons.wb_cloudy,
    temp: '31.1℃',
    time: '2018 22:19:53',
    weatherCenterIcon: Icons.wb_cloudy,
  ),
  new CardViewModel(
    backdropAssetPath: 'https://pics6.baidu.com/feed/0b55b319ebc4b7452ab683666889f2118a82151f.png?token=7a08a149c4ca0088d786fdfdc2cd9af9',
    headerTitle: '高耸入云',
    title: '腾飞的龙',
    subTitle: '一条',
    weatherType: Icons.wb_cloudy,
    temp: '31.1℃',
    time: '2018 22:19:53',
    weatherCenterIcon: Icons.wb_cloudy,
  ),
  new CardViewModel(
    backdropAssetPath: 'https://pics6.baidu.com/feed/0b55b319ebc4b7452ab683666889f2118a82151f.png?token=7a08a149c4ca0088d786fdfdc2cd9af9',
    headerTitle: '和蔼可亲',
    title: '美丽的花纹',
    subTitle: '倒映',
    weatherType: Icons.wb_cloudy,
    temp: '31.1℃',
    time: '2018 22:19:53',
    weatherCenterIcon: Icons.wb_cloudy,
  )
];