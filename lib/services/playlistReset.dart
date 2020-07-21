import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:net_easy_music/api/apiList.dart';
import 'package:net_easy_music/json/playlist.dart';
import 'package:assets_audio_player/assets_audio_player.dart' as audioPlayer;
import 'package:net_easy_music/model/playlist_manage.dart';
import 'package:net_easy_music/plugin/audioPlayer_plugin.dart';
import 'package:net_easy_music/plugin/httpManage.dart';
import 'package:net_easy_music/settings/global.dart';
import 'package:net_easy_music/utils/songExpired.dart';
import 'package:provider/provider.dart';

reSetAudioPlaylist(int nowPlayIndex) async {
  //nowPlayIndex 当前歌曲不刷新 不然陷入死循环
  int nowTime = DateTime.now().millisecondsSinceEpoch;
  if (songExpired.expiresTime < nowTime) {
    songExpired.songInitTime = nowTime;

    final context = navigatorKey.currentContext;
    List<DataList> list = context.read<PlaylistManage>().playlist;
    //能在这里面的歌曲一般不会出现播放路劲为null
    String platform = '163';
    int baseLoop = 50;
    List<int> ids = [];
    List<DataList> unFoundList = [];
    List<DataList> reMoveList = [];
    list.forEach((song) {
      ids.add(song.id);
    });
    List<ReplaceSong> _songsList = [];
    int loopCount = (list.length / baseLoop).ceil();
    // 循环获取歌曲的uir
    for (var i = 0; i < loopCount; i++) {
      String idString;
      int loopEnd = 0;
      if (i == loopCount - 1) {
        idString = ids.getRange(baseLoop * i, list.length).join(',');
        loopEnd = list.length;
      } else {
        idString = ids.getRange(baseLoop * i, (1 + i) * baseLoop).join(',');
        loopEnd = (1 + i) * baseLoop;
      }
      final Response response = await HttpManager(context)
          .get(apiList['BATCH_URL'], data: {
        'id': idString,
        '_p': platform,
        '_t': Duration().inMicroseconds
      });
      final String songsurl = jsonEncode(response.data['data']);

      list.getRange(baseLoop * i, loopEnd).forEach((song) {
        String url = jsonDecode(songsurl)[song.id.toString()];
        if (url != null) {
          _songsList.add(new ReplaceSong(song.id.toString(), url));
        } else {
          unFoundList.add(song);
        }
      });
    }

    //找不到去QQ音乐找
    int unFoundListLoopCount = (unFoundList.length / baseLoop).ceil();
    for (var i = 0; i < unFoundListLoopCount; i++) {
      Map findByQQ = {};
      int loopEnd = 0;
      if (i == unFoundListLoopCount - 1) {
        unFoundList.getRange(baseLoop * i, unFoundList.length).forEach((song) {
          findByQQ[song.id.toString()] =
              '${song.name}' + ' ' + '${song.ar.map((a) => a.name).join(' ')}';
          loopEnd = unFoundList.length;
        });
      } else {
        unFoundList.getRange(baseLoop * i, (1 + i) * baseLoop).forEach((song) {
          findByQQ[song.id.toString()] =
              '${song.name}' + ' ' + '${song.ar.map((a) => a.name).join(' ')}';
        });
        loopEnd = (1 + i) * baseLoop;
      }
      final Response response = await HttpManager(context)
          .post(apiList['QQ_SONG_FINDS'], data: {'data': findByQQ});
      if (response.data['result'] == 100) {
        String songsurl = jsonEncode(response.data['data']);
        unFoundList.getRange(baseLoop * i, loopEnd).forEach((song) {
          String url = jsonDecode(songsurl)[song.id.toString()]['url'];
          if (url != null) {
            _songsList.add(new ReplaceSong(song.id.toString(), url));
          } else {
            reMoveList.add(song);
          }
        });
      }
    }
    //这些歌曲都是找不到的 不过几乎没有
    //reMoveList 都找不到
    print('开始替换');
    for (var i = 0; i < list.length; i++) {
      //当前歌曲不替换
      for (var j = 0; j < _songsList.length; j++) {
        if (i != nowPlayIndex && list[i].id == _songsList[j].id) {
          AudioInstance().assetsAudioPlayer.playlist.replaceAt(
              i, (oldAudio) => oldAudio.copyWith(path: _songsList[j].url));
        }
      }
    }
    for (var i = 0; i < reMoveList.length; i++) {
      print(reMoveList[i].id);
      context.read<PlaylistManage>().playlist.remove(reMoveList[i]);
    }
  }
}

audioPlayer.Audio getAudio(song, url) {
  String _artist;
  song.ar.forEach((ar) {
    if (_artist == null) {
      _artist = ar.name;
    } else {
      _artist = _artist + ' ' + ar.name;
    }
  });
  audioPlayer.Audio audio = audioPlayer.Audio.network(
    url,
    metas: audioPlayer.Metas(
      title: song.name,
      artist: _artist,
      album: song.al.name,
      image: audioPlayer.MetasImage.network(
        song.al.picUrl + '?param=1440y1440',
      ), //can be MetasImage.network
    ),
  );
  return audio;
}

class ReplaceSong {
  final String id;
  final String url;

  ReplaceSong(this.id, this.url);
}
