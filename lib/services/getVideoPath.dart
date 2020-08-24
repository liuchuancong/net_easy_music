import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:net_easy_music/api/apiList.dart';
import 'package:net_easy_music/plugin/httpManage.dart';

Future<VideoModel> getVideoPath(String id, String platform) async {
  // 一般为网易的
  VideoModel _videoModel;
  if (platform.toString() == '163') {
    final Response response =
        await HttpManager().get(apiList['GET_MV_INFO'], data: {
      'mvid': id,
    });
    Map songsMap = json.decode(response.toString());
    print(songsMap);
    if (songsMap['code'] == 200) {
      String id = songsMap['data']['id'].toString();
      String cover = songsMap['data']['cover'].toString();
      String brs240 = songsMap['data']['brs']['240'].toString();
      String brs480 = songsMap['data']['brs']['480'].toString();
      _videoModel =
          new VideoModel(id: id, cover: cover, brs240: brs240, brs480: brs480);
    } else {
      print('error');
    }
  }else if (platform.toString() == 'qq') {
    final Response response =
        await HttpManager().get(apiList['QQ_MV_URL'], data: {
      'id': id,
    });
    print(id);
    Map songsMap = json.decode(response.toString());
    if (songsMap['result'] == 100) {
      String id = songsMap['data']['id'].toString();
      String cover = songsMap['data']['cover'].toString();
      String brs240 = songsMap['data']['brs']['240'].toString();
      String brs480 = songsMap['data']['brs']['480'].toString();
      _videoModel =
          new VideoModel(id: id, cover: cover, brs240: brs240, brs480: brs480);
    } else {
      print('error');
    }
  }

  return _videoModel;
}

class VideoModel {
  final String brs240;
  final String id;
  final String brs480;

  final String cover;

  VideoModel({this.brs240, this.id, this.brs480, this.cover});
}
