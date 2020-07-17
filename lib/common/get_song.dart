import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:net_easy_music/api/apiList.dart';
import 'package:net_easy_music/model/playlist_manage.dart';
import 'package:net_easy_music/plugin/httpManage.dart';
import 'package:provider/provider.dart';

Future<String> getSongNewPath(BuildContext context) async {
  // 一般为网易的
  String path;
  final Response response =
      await HttpManager(context).get(apiList['SONG_URL'], data: {
    'id': context.read<PlaylistManage>().currentPlay.id,
    '_p': context.read<PlaylistManage>().currentPlay.platform,
  });
  Map songsMap = json.decode(response.toString());
  if (songsMap['code'] == 200) {
    path = songsMap['data'][0]['url'];
  } else {
    print('error');
  }
  return path;
}
