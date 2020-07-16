import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:assets_audio_player/assets_audio_player.dart' as audioPlayer;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:net_easy_music/api/apiList.dart';
import 'package:net_easy_music/components/blurBackground.dart';
import 'package:net_easy_music/json/playlist.dart';
import 'package:net_easy_music/json/recommend_playlist.dart';
import 'package:net_easy_music/lyric/lyric.dart';
import 'package:net_easy_music/model/playlist_manage.dart';
import 'package:net_easy_music/plugin/audioPlayer_plugin.dart';
import 'package:net_easy_music/plugin/httpManage.dart';
import 'package:provider/provider.dart';
import 'package:net_easy_music/model/drawer_manage.dart';
import 'audioControl.dart';
import 'my_drawer.dart';
import 'dart:ui' as ui;

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  StreamSubscription _sessionIdsubscription;
  StreamSubscription _currentPlaySubscription;
  bool _showLyric = false;
  AnimationController _albumController;
  LyricContent lyricContent, lyricTranslateContent;
  double _currentSeconds = 0.0;
  @override
  void initState() {
    super.initState();
    AudioInstance().requestRecordAudioPermission();
    getRecommendPlaylist();
    currentPlaySong();
    _handlePlayerErr();
    _albumController =
        new AnimationController(vsync: this, duration: Duration(seconds: 60));
  }

  @override
  void dispose() {
    _sessionIdsubscription.cancel();
    _albumController.dispose();
    _currentPlaySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentPlay = Provider.of<PlaylistManage>(context).currentPlay;
    return Scaffold(
      backgroundColor: Colors.transparent,
      key: _scaffoldKey,
      drawer: MyDrawer(callback: _onDrawerOpenOrClose),
      body: SafeArea(
        child: new Stack(
          children: <Widget>[
            BlurBackground(
              imageUrl: currentPlay != null
                  ? currentPlay.al.picUrl + '?param=1440y1440'
                  : null,
            ),
            Column(
              children: <Widget>[
                _buildTopBar(context),
                _buildCenterSection(context),
                if (currentPlay != null)
                  AudioControl(
                    showLyric: _showLyric,
                  )
              ],
            ),
            // AudioControl()
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.menu,
          color: Provider.of<DrawerManage>(context).isOpen
              ? Colors.transparent
              : Colors.white,
          size: 20,
        ),
        onPressed: () {
          _scaffoldKey.currentState.openDrawer();
        },
      ),
    );
  }

  Widget _buildCenterSection(context) {
    return Expanded(
        child: AnimatedCrossFade(
            crossFadeState: _showLyric
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            layoutBuilder: (Widget topChild, Key topChildKey,
                Widget bottomChild, Key bottomChildKey) {
              return Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  Center(
                    key: bottomChildKey,
                    child: bottomChild,
                  ),
                  Center(
                    key: topChildKey,
                    child: topChild,
                  ),
                ],
              );
            },
            firstChild: _buildImage(context),
            secondChild: _buildLyric(context),
            duration: Duration(milliseconds: 300)));
  }

  Widget _buildLyric(BuildContext context) {
    TextStyle style = Theme.of(context)
        .textTheme
        .bodyText2
        .copyWith(height: 2, fontSize: 16, color: Colors.white);
    if (lyricContent != null && lyricContent.size > 0) {
      return LayoutBuilder(builder: (context, constraints) {
        final normalStyle = style.copyWith(color: style.color.withOpacity(0.7));
        //歌词顶部与尾部半透明显示
        return ShaderMask(
          shaderCallback: (rect) {
            return ui.Gradient.linear(Offset(rect.width / 2, 0),
                Offset(rect.width / 2, constraints.maxHeight), [
              const Color(0x00FFFFFF),
              style.color,
              style.color,
              const Color(0x00FFFFFF),
            ], [
              0.0,
              0.15,
              0.85,
              1
            ]);
          },
          child: _songILyricAnimate(normalStyle, style, constraints),
        );
      });
    } else {
      return GestureDetector(
        onTap: _setLyricState,
        child: Container(
          child: Center(
            child: Text('没有歌词哟，好好享受', style: style),
          ),
        ),
      );
    }
  }

  StreamBuilder<bool> _songILyricAnimate(
      TextStyle normalStyle, TextStyle style, BoxConstraints constraints) {
    return StreamBuilder(
        stream: AudioInstance().assetsAudioPlayer.isPlaying,
        builder: (context, snapshot) {
          bool isPlaying = snapshot.data;
          if (snapshot.data == null) {
            isPlaying = false;
          }
          if (isPlaying) {
            _albumController.repeat();
          } else {
            _albumController.stop();
          }
          String songId =
              context.watch<PlaylistManage>().currentPlay.id.toString();
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: StreamBuilder(
                stream: AudioInstance().assetsAudioPlayer.currentPosition,
                builder: (context, AsyncSnapshot<Duration> snapshot) {
                  if (snapshot.data == null) {
                    _currentSeconds = 0;
                  } else {
                    _currentSeconds = snapshot.data.inSeconds.toDouble();
                  }
                  return Lyric(
                    id: songId,
                    lyricTranslation: lyricTranslateContent,
                    lyric: lyricContent,
                    lyricLineStyle: normalStyle,
                    highlight: style.color,
                    position: _currentSeconds.floor() * 1000,
                    onTap: _setLyricState,
                    size: Size(
                        constraints.maxWidth,
                        constraints.maxHeight == double.infinity
                            ? 0
                            : constraints.maxHeight),
                    playing: isPlaying,
                  );
                }),
          );
        });
  }

  Widget _buildImage(BuildContext context) {
    double expandedSize = MediaQuery.of(context).size.width;
    final _currentPlay = Provider.of<PlaylistManage>(context).currentPlay;
    return AnimatedBuilder(
      animation: _albumController,
      builder: (BuildContext context, Widget child) {
        return StreamBuilder(
            stream: AudioInstance().assetsAudioPlayer.isPlaying,
            builder: (context, snapshot) {
              bool isPlaying = snapshot.data;
              if (snapshot.data == null) {
                isPlaying = false;
              }
              if (isPlaying) {
                _albumController.repeat();
              } else {
                _albumController.stop();
              }
              return Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  if (_currentPlay != null)
                    Transform(
                      alignment: Alignment.center,
                      transform:
                          Matrix4.rotationZ(-_albumController.value * 2 * pi),
                      child: GestureDetector(
                        onTap: _setLyricState,
                        child: Container(
                            width: expandedSize * 0.8,
                            height: expandedSize * 0.8,
                            child: new Center(
                                child: Container(
                              width: expandedSize * 0.65,
                              height: expandedSize * 0.65,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(200),
                                child: _currentPlay.al.picUrl != null
                                    ? new CachedNetworkImage(
                                        imageUrl: _currentPlay.al.picUrl +
                                            '?param=1440y1440',
                                        fit: BoxFit.cover,
                                        errorWidget: (context, url, error) =>
                                            new Image.asset(
                                          'assets/music2.jpg',
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : new Image.asset(
                                        'assets/music2.jpg',
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ))),
                      ),
                    ),
                ],
              );
            });
      },
      child: Neumorphic(
        style: NeumorphicStyle(
          boxShape: NeumorphicBoxShape.circle(),
        ),
      ),
    );
  }

  void _setLyricState() {
    setState(() {
      _showLyric = !_showLyric;
    });
  }

  currentPlaySong() {
    _currentPlaySubscription =
        AudioInstance().assetsAudioPlayer.current.listen((playingAudio) {
      _albumController.reset();
      _getSonglyric(playingAudio.playlist.currentIndex);
    });
  }

  getRecommendPlaylist() async {
    final Response response = await HttpManager(context)
        .get(apiList['RECOMMEND_PLAYLIST'], data: {'login': 0, '_p': 163});
    final _playlist = RecommendPlaylist.fromJson(response.data);
    if (_playlist.result == 100) {
      getPlaylist(_playlist);
    }
  }

  getPlaylist(RecommendPlaylist playlist) async {
    final Response response = await HttpManager(context).get(
        apiList['PLAYLIST'],
        data: {'id': playlist.data[0].id, '_p': playlist.data[0].platform});
    final _playlist = Playlist.fromJson(response.data);
    if (_playlist.result == 100) {
      context.read<PlaylistManage>().setPlaylist(_playlist.data.list);
      getAudioPlaylist(_playlist.data.list);
    }
  }

  getAudioPlaylist(List<DataList> list) async {
    String platform = '163';
    int baseLoop = 50;
    List<int> ids = [];
    List<DataList> unFoundList = [];
    List<DataList> reMoveList = [];
    list.forEach((song) {
      ids.add(song.id);
    });
    audioPlayer.Playlist _songsList = new audioPlayer.Playlist();
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
          audioPlayer.Audio _audio = _getAudio(song, url);
          _songsList.add(_audio);
        } else {
          unFoundList.add(song);
        }
      });
    }
    // 先删掉找不到的歌曲 然后获取然后添加不然歌曲和歌曲链接不对应
    unFoundList.forEach((song) {
      context.read<PlaylistManage>().playlist.remove(song);
    });
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
            audioPlayer.Audio _audio = _getAudio(song, url);
            context.read<PlaylistManage>().playlist.add(song);
            _songsList.add(_audio);
          } else {
            reMoveList.add(song);
          }
        });
      }
    }
    //这些歌曲都是找不到的 不过几乎没有
    //reMoveList
    await AudioInstance().initPlaylist(_songsList);
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
        image: audioPlayer.MetasImage.network(
          song.al.picUrl + '?param=1440y1440',
        ), //can be MetasImage.network
      ),
    );
    return audio;
  }

  Future<void> _getSonglyric(int index) async {
    final play = context.read<PlaylistManage>();
    print(
        'play.playlist[play.playIndex].id ${play.playlist[play.playIndex].id}');
    print(
        'play.playlist[play.playIndex].platform ${play.playlist[play.playIndex].platform}');
    lyricContent = null;
    lyricTranslateContent = null;
    try {
      final Response response =
          await HttpManager(context).get(apiList['LYRIC'], data: {
        'id': play.playlist[index].id,
        '_p': play.playlist[index].platform,
        '_t': Duration().inMicroseconds.toString()
      });
      Map songsMap = json.decode(response.toString());
      if (songsMap['result'] == 100) {
        lyricContent = LyricContent.from(songsMap['data']['lyric']);
        lyricTranslateContent = LyricContent.from(songsMap['data']['trans']);
      }
    } catch (e) {
      print(e.toString());
    }
    setState(() {});
  }

  _onDrawerOpenOrClose(state) {
    if (state) {
      Future.delayed(Duration(seconds: 0), () {
        Provider.of<DrawerManage>(context, listen: false).openDrawer();
      });
    } else {
      Future.delayed(Duration(seconds: 0), () {
        Provider.of<DrawerManage>(context, listen: false).closeDrawer();
      });
    }
  }

  Future<String> getSongNewPath() async {
    String path;
    final Response response = await HttpManager(context).get(
        apiList['SONG_URL'],
        data: {'id': context.read<PlaylistManage>().currentPlay.id});
    Map songsMap = json.decode(response.toString());
    if (songsMap['code'] == 200) {
      path = songsMap['data'][0]['url'];
    } else {
      print('error');
    }
    return path;
  }

  _handlePlayerErr() {
    try {
      AudioInstance().assetsAudioPlayer.onErrorDo = (handler) async {
        print('handler.error.errorType${handler.error.errorType}');
        print('handler.error.message${handler.error.message}');
        // handler.player.open(
        //   handler.playlist.copyWith(startIndex: handler.playlistIndex),
        //   seek: handler.currentPosition,
        // );
        // final path = await getSongNewPath();
        // print(path);
        // if (path != null) {
        //   handler.player.playlist.replaceAt(
        //       handler.playlistIndex,
        //       (oldAudio) =>
        //           new audioPlayer.Audio.network(path, metas: oldAudio.metas));
        // }
      };
    } catch (e) {
      print('e : $e');
    }
  }
}
