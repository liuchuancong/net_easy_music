import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:net_easy_music/api/apiList.dart';
import 'package:net_easy_music/json/playlist.dart' as playlist;
import 'package:net_easy_music/json/searchAlbum/search_album_migu/search_album_migu.dart';
import 'package:net_easy_music/json/searchAlbum/search_album_netease/search_album_netease.dart';
import 'package:net_easy_music/json/searchAlbum/search_album_qq/search_album_qq.dart';
import 'package:net_easy_music/model/playlist_manage.dart';
import 'package:net_easy_music/plugin/audioPlayer_plugin.dart';
import 'package:net_easy_music/plugin/httpManage.dart';
import 'package:net_easy_music/type/platform_type.dart';
import 'package:provider/provider.dart';
import 'package:assets_audio_player/assets_audio_player.dart' as audioPlayer;

import 'albumSongItem.dart';

class AlbumList extends StatefulWidget {
  final SearchAlbumNetease searchAlbumNetease;
  final SearchAlbumQq searchAlbumQq;
  final SearchAlbumMigu searchAlbumMigu;
  final PlatformMusic platformMusic;
  final Function refresh;
  const AlbumList({
    Key key,
    this.searchAlbumNetease,
    this.searchAlbumQq,
    this.searchAlbumMigu,
    this.platformMusic,
    this.refresh,
  }) : super(key: key);

  @override
  _AlbumListState createState() => _AlbumListState();
}

class _AlbumListState extends State<AlbumList> {
  List<AlbumSong> _songList = [];
  audioPlayer.Playlist _audioPlaylist = new audioPlayer.Playlist();
  //需要一个状态来控制是否是第一次初始化播放列表,后续只需要往播放列表里面添加
  bool _openState = false;
  @override
  void initState() {
    super.initState();
    _buildSongsList();
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => GestureDetector(
          onTap: () => playAtIndex(_songList[index]),
          child: AlbumSongItem(
            index: index,
            canPlay: _songList[index].canPlay,
            content: _songList[index].song,
          ),
        ),
        childCount: _songList.length,
      ),
    );
  }

  _buildSongsList() async {
    switch (widget.platformMusic) {
      case PlatformMusic.NETEASE:
        await _getAudioPlaylist(widget.searchAlbumNetease.data.content);
        break;
      case PlatformMusic.QQ:
        await _getAudioPlaylist(widget.searchAlbumQq.data.content);
        break;
      case PlatformMusic.MIGU:
        await _getAudioPlaylist(widget.searchAlbumMigu.data.content);
        break;
    }
  }

  String getPlatformPara() {
    String _platform = '163';
    switch (widget.platformMusic) {
      case PlatformMusic.NETEASE:
        _platform = '163';
        break;
      case PlatformMusic.QQ:
        _platform = 'qq';
        break;
      case PlatformMusic.MIGU:
        _platform = 'migu';
        break;
    }
    return _platform;
  }

  playAtIndex(AlbumSong content) async {
    final playManage = context.read<PlaylistManage>();
    if (!content.canPlay) return;
    // 是否是第一次播放
    if (_openState) {
    } else {
      _openState = true;
      List<playlist.DataList> list = [];
      _songList.forEach((AlbumSong albumSong) {
        List<playlist.Ar> arList = [];
        albumSong.song.ar.forEach((ar) {
          arList.add(new playlist.Ar(ar.id, ar.name, ar.picUrl, ar.platform));
        });
        playlist.Al al = new playlist.Al(
            albumSong.song.al.id,
            albumSong.song.al.name,
            albumSong.song.al.picUrl,
            albumSong.song.al.platform);
        if (widget.platformMusic == PlatformMusic.MIGU) {
          list.add(new playlist.DataList(
              albumSong.song.name,
              albumSong.song.id,
              arList,
              al,
              albumSong.song.mvId,
              null,
              albumSong.song.platform,
              null,
              albumSong.song.aId));
        } else {
          list.add(new playlist.DataList(
              albumSong.song.name,
              albumSong.song.id,
              arList,
              al,
              albumSong.song.mvId,
              albumSong.song.trackNo,
              albumSong.song.platform,
              albumSong.song.duration,
              albumSong.song.aId));
        }
      });
      playManage.setPlaylist(list);
      await AudioInstance().initPlaylist(_audioPlaylist);
    }
    final idxSong =
        playManage.playlist.indexWhere((song) => content.song.id == song.id);
    playManage.setPlayIndex(idxSong);
    playManage.setCurrentPlay(playManage.playlist[idxSong]);
    await AudioInstance().playlistPlayAtIndex(idxSong);
  }

  _getAudioPlaylist(List songArr) async {
    List unFoundList = [];
    List reMoveList = [];
    List<audioPlayer.Audio> _audios = [];
    if (widget.platformMusic == PlatformMusic.NETEASE) {
      int baseLoop = 50;
      List<int> ids = [];
      songArr.forEach((song) {
        ids.add(song.id);
      });
      int loopCount = (songArr.length / baseLoop).ceil();
      // 循环获取歌曲的uir
      for (var i = 0; i < loopCount; i++) {
        String idString;
        int loopEnd = 0;
        if (i == loopCount - 1) {
          idString = ids.getRange(baseLoop * i, songArr.length).join(',');
          loopEnd = songArr.length;
        } else {
          idString = ids.getRange(baseLoop * i, (1 + i) * baseLoop).join(',');
          loopEnd = (1 + i) * baseLoop;
        }
        final Response response = await HttpManager(context)
            .get(apiList['BATCH_URL'], data: {
          'id': idString,
          '_p': getPlatformPara(),
          '_t': Duration().inMicroseconds
        });
        final String songsurl = jsonEncode(response.data['data']);

        songArr.getRange(baseLoop * i, loopEnd).forEach((song) {
          String url = jsonDecode(songsurl)[song.id.toString()];
          if (url != null) {
            audioPlayer.Audio _audio = _getAudio(song, url);
            _audios.add(_audio);
            _audioPlaylist.add(_audio);
            _songList.add(new AlbumSong(song: song));
          } else {
            unFoundList.add(song);
          }
        });
      }
      // 先删掉找不到的歌曲 然后获取然后添加不然歌曲和歌曲链接不对应
      unFoundList.forEach((song) {
        _songList.remove(song);
      });
      //找不到去QQ音乐找
      int unFoundListLoopCount = (unFoundList.length / baseLoop).ceil();
      for (var i = 0; i < unFoundListLoopCount; i++) {
        Map findByQQ = {};
        int loopEnd = 0;
        if (i == unFoundListLoopCount - 1) {
          unFoundList
              .getRange(baseLoop * i, unFoundList.length)
              .forEach((song) {
            findByQQ[song.id.toString()] = '${song.name}' +
                ' ' +
                '${song.ar.map((a) => a.name).join(' ')}';
            loopEnd = unFoundList.length;
          });
        } else {
          unFoundList
              .getRange(baseLoop * i, (1 + i) * baseLoop)
              .forEach((song) {
            findByQQ[song.id.toString()] = '${song.name}' +
                ' ' +
                '${song.ar.map((a) => a.name).join(' ')}';
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
              audioPlayer.Audio _audio = _getAudio(song, url);
              _audioPlaylist.add(_audio);
              _songList.add(new AlbumSong(song: song));
              _audios.add(_audio);
            } else {
              reMoveList.add(song);
            }
          });
        }
      }
    } else if (widget.platformMusic == PlatformMusic.QQ) {
      Map findByQQ = {};
      songArr.forEach((song) {
        findByQQ[song.id.toString()] =
            '${song.name}' + ' ' + '${song.ar.map((a) => a.name).join(' ')}';
      });
      final Response response = await HttpManager(context)
          .post(apiList['QQ_SONG_FINDS'], data: {'data': findByQQ});
      if (response.data['result'] == 100) {
        String songsurl = jsonEncode(response.data['data']);
        songArr.forEach((song) {
          String url = jsonDecode(songsurl)[song.id.toString()]['url'];
          if (url != null) {
            audioPlayer.Audio _audio = _getAudio(song, url);
            _audioPlaylist.add(_audio);
            _songList.add(new AlbumSong(song: song));
          } else {
            reMoveList.add(song);
          }
        });
      }
      reMoveList.forEach((song) {
        songArr.remove(song);
      });
    } else if (widget.platformMusic == PlatformMusic.MIGU) {
      songArr.forEach((song) {
        String url = song.ar[0].picUrl;
        if (url != null) {
          audioPlayer.Audio _audio = _getAudio(song, url);
          _audioPlaylist.add(_audio);
          _songList.add(new AlbumSong(song: song));
        } else {
          reMoveList.add(song);
        }
      });
    }
    reMoveList.forEach((song) {
      _songList.add(new AlbumSong(song: song, canPlay: false));
    });
    //reMoveList
    // 将新增加的歌曲加入播放列表
    if (_openState) {
      List<playlist.DataList> list = [];
      songArr.forEach((song) {
        List<playlist.Ar> arList = [];
        song.ar.forEach((ar) {
          arList.add(new playlist.Ar(ar.id, ar.name, ar.picUrl, ar.platform));
        });

        if (widget.platformMusic == PlatformMusic.MIGU) {
          playlist.Al al =
              new playlist.Al(song.al.id, song.al.name, null, song.al.platform);
          list.add(new playlist.DataList(song.name, song.id, arList, al,
              song.mvId, null, song.platform, null, song.aId));
        } else {
          playlist.Al al = new playlist.Al(
              song.al.id, song.al.name, song.al.picUrl, song.al.platform);
          list.add(new playlist.DataList(
              song.name,
              song.id,
              arList,
              al,
              song.mvId,
              song.trackNo ?? song.trackNo,
              song.platform,
              song.duration ?? song.duration,
              song.aId));
        }
      });
      context.read<PlaylistManage>().addAll(list);
      await AudioInstance().addAll(_audios);
    }
    if (mounted) setState(() {});
  }

  audioPlayer.Audio _getAudio(song, url) {
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
          image: widget.platformMusic != PlatformMusic.MIGU
              ? audioPlayer.MetasImage.network(
                  song.al.picUrl + '?param=1440y1440',
                )
              : audioPlayer.MetasImage.network(
                  url,
                ) //can be MetasImage.network
          ),
    );
    return audio;
  }
}

class AlbumSong {
  final bool canPlay;
  final song;

  AlbumSong({this.canPlay = true, this.song});
}
