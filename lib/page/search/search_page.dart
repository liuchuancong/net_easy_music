import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:net_easy_music/api/apiList.dart';
import 'package:net_easy_music/common/common.dart';
import 'package:net_easy_music/components/blurBackground.dart';
import 'package:net_easy_music/components/customIcon.dart';
import 'package:net_easy_music/json/playlist.dart';
import 'package:net_easy_music/json/searchType/search_type_with_album.dart'
    as Album;
import 'package:net_easy_music/json/searchType/search_type_with_singer.dart'
    as Singer;
import 'package:net_easy_music/json/searchType/search_type_with_playlist.dart'
    as Playlist;
import 'package:net_easy_music/model/playlist_manage.dart';
import 'package:net_easy_music/page/search/search_album_item.dart';
import 'package:net_easy_music/page/search/search_item.dart';
import 'package:net_easy_music/page/search/search_playlist_item.dart';
import 'package:net_easy_music/page/search/search_singer_item.dart';
import 'package:net_easy_music/page/search/search_song_item.dart';
import 'package:net_easy_music/page/search/search_view.dart';
import 'package:net_easy_music/page/search_album/search_album.dart';
import 'package:net_easy_music/plugin/audioPlayer_plugin.dart';
import 'package:net_easy_music/plugin/httpManage.dart';
import 'package:net_easy_music/type/platform_type.dart';
import 'package:net_easy_music/type/search_type.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:assets_audio_player/assets_audio_player.dart' as audioPlayer;

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  PlatformMusic platformMusic = PlatformMusic.NETEASE;
  SearchType searchType = SearchType.SONG;
  int pageNo = 1;
  TextEditingController _editingController;
  List _songList = [];
  List<Album.Content> _albumList = [];
  List<Singer.Content> _singerList = [];
  List<Playlist.Content> _playList = [];
  // 此为临时播放列表
  audioPlayer.Playlist _audioPlaylist = new audioPlayer.Playlist();
  //需要一个状态来控制是否是第一次初始化播放列表,后续只需要往播放列表里面添加
  bool _openState = false;

  @override
  void initState() {
    _editingController = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currentPlay = Provider.of<PlaylistManage>(context).currentPlay;
    return Stack(
      children: <Widget>[
        BlurBackground(
          imageUrl: currentPlay.al.picUrl + '?param=1440y1440',
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomPadding: false,
          body: SafeArea(
            child: new Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    _buildTopBar(context),
                    _buildCard(context),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void platformMusicSelect(PlatformMusic select) {
    if (platformMusic == select) {
      return;
    }
    setState(() {
      platformMusic = select;
    });
    initSearchConditons();
    _onLoading();
  }

  void initSearchConditons() {
    setState(() {
      _songList = [];
      _albumList = [];
      _singerList = [];
      _playList = [];
      pageNo = 1;
      _audioPlaylist = new audioPlayer.Playlist();
      _openState = false;
    });
  }

  _getAudioPlaylist(List songArr) async {
    List unFoundList = [];
    List reMoveList = [];
    List<audioPlayer.Audio> _audios = [];
    if (platformMusic == PlatformMusic.NETEASE) {
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
        final Response response = await HttpManager()
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
            _songList.add(song);
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
        final Response response = await HttpManager()
            .post(apiList['QQ_SONG_FINDS'], data: {'data': findByQQ});
        if (response.data['result'] == 100) {
          String songsurl = jsonEncode(response.data['data']);
          unFoundList.getRange(baseLoop * i, loopEnd).forEach((song) {
            String url = jsonDecode(songsurl)[song.id.toString()]['url'];
            if (url != null) {
              audioPlayer.Audio _audio = _getAudio(song, url);
              _audioPlaylist.add(_audio);
              _songList.add(song);
              _audios.add(_audio);
            } else {
              reMoveList.add(song);
            }
          });
        }
      }
    } else if (platformMusic == PlatformMusic.QQ) {
      Map findByQQ = {};
      songArr.forEach((song) {
        findByQQ[song.id.toString()] =
            '${song.name}' + ' ' + '${song.ar.map((a) => a.name).join(' ')}';
      });
      final Response response = await HttpManager()
          .post(apiList['QQ_SONG_FINDS'], data: {'data': findByQQ});
      if (response.data['result'] == 100) {
        String songsurl = jsonEncode(response.data['data']);
        songArr.forEach((song) {
          String url = jsonDecode(songsurl)[song.id.toString()]['url'];
          if (url != null) {
            audioPlayer.Audio _audio = _getAudio(song, url);
            _audioPlaylist.add(_audio);
            _songList.add(song);
          } else {
            reMoveList.add(song);
          }
        });
      }
      reMoveList.forEach((song) {
        songArr.remove(song);
      });
    } else if (platformMusic == PlatformMusic.MIGU) {
      songArr.forEach((song) {
        String url = song.url;
        if (url != null) {
          audioPlayer.Audio _audio = _getAudio(song, url);
          _audioPlaylist.add(_audio);
          _songList.add(song);
        } else {
          reMoveList.add(song);
        }
      });
    }

    //这些歌曲都是找不到的 不过几乎没有
    //reMoveList
    // 将新增加的歌曲加入播放列表
    if (_openState) {
      List<DataList> list = [];
      songArr.forEach((song) {
        List<Ar> arList = [];
        song.ar.forEach((ar) {
          arList.add(new Ar(ar.id, ar.name, ar.picUrl, ar.platform));
        });
        Al al =
            new Al(song.al.id, song.al.name, song.al.picUrl, song.al.platform);
        if (platformMusic == PlatformMusic.MIGU) {
          list.add(new DataList(song.name, song.id, arList, al, song.mvId, null,
              song.platform, null, song.aId));
        } else {
          list.add(new DataList(
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

  void searchTypeSelect(SearchType select) {
    if (searchType == select) {
      return;
    }
    setState(() {
      searchType = select;
    });
    initSearchConditons();
    _onLoading();
  }

  void _onLoading() async {
    //关闭键盘
    FocusScope.of(context).requestFocus(FocusNode());
    if (_editingController.text.isEmpty) {
      _refreshController.loadComplete();
      return;
    }
    // 获取歌曲
    Map<String, dynamic> searchMap = {
      'key': _editingController.text,
      '_p': getPlatformPara(),
      'type': getsearchTypePara(),
      'pageNo': pageNo,
      '_t': Duration().inMicroseconds.toString()
    };

    final Response response =
        await HttpManager().get(apiList['SEARCH'], data: searchMap);
    if (response == null) {
      return;
    }
    await _getListContent(response);
  }

  _getListContent(Response response) async {
    if (response.toString().contains('<!DOCTYPE')) {
      _refreshController.loadNoData();
      return;
    }
    Map songsMap = json.decode(response.toString());
    if (songsMap['result'] == 100) {
      pageNo++;
    }
    switch (searchType) {
      case SearchType.SONG:
        List _songs = SearchViewBuild()
            .buildBySong(context, response, _refreshController, platformMusic);
        await _getAudioPlaylist(_songs);
        break;
      case SearchType.ALBUM:
        _albumList.addAll(SearchViewBuild().buildByAlbum(
          context,
          response,
          _refreshController,
        ));

        break;
      case SearchType.SINGER:
        _singerList.addAll(SearchViewBuild().buildBySinger(
          context,
          response,
          _refreshController,
        ));
        break;
      case SearchType.PLAYLIST:
        _playList.addAll(SearchViewBuild().buildByPlaylist(
          context,
          response,
          _refreshController,
        ));
        break;
    }
    setState(() {});
  }

  String getPlatformPara() {
    String _platform = '163';
    switch (platformMusic) {
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

  String getsearchTypePara() {
    String _type = '0';
    switch (searchType) {
      case SearchType.SONG:
        _type = '0';
        break;
      case SearchType.ALBUM:
        _type = '2';
        break;
      case SearchType.SINGER:
        _type = '3';
        break;
      case SearchType.PLAYLIST:
        _type = '1';
        break;
    }
    return _type;
  }

  searchConditions() {}

  Widget _buildTopBar(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton());
  }

  Widget _buildTextFiled(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      constraints: BoxConstraints(maxHeight: 37, minWidth: 200),
      child: Theme(
        data: new ThemeData(primaryColor: Colors.white54),
        child: TextField(
          controller: _editingController,
          maxLines: 1, //最大行数
          cursorColor: Colors.white54,
          cursorWidth: 1.0, //光标宽度
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.white54,
          ),

          decoration: InputDecoration(
            focusedBorder: new UnderlineInputBorder(
              borderSide: new BorderSide(color: Colors.white54, width: 1),
            ),
            enabledBorder: new UnderlineInputBorder(
              borderSide: new BorderSide(color: Colors.white54, width: 1),
            ),
            // focusedBorder: InputBorder.none,
          ),
          onEditingComplete: () {
            initSearchConditons();
            _onLoading();
          },
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: Colors.transparent.withOpacity(0.2),
            child: new Column(
              children: <Widget>[
                _buildTextFiled(context),
                _buildMusicPlatform(context),
                _buildSearchType(context),
                _buildSongList(context)
                // _buildSongList(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMusicPlatform(BuildContext context) {
    List<Widget> buttonGroup = [];
    List<int> iconList = [0xE60C, 0xE60B, 0xE644];
    for (var i = 0; i < PlatformMusic.values.length; i++) {
      buttonGroup.add(new CustomIcon(
        codePoint: iconList[i],
        platformMusic: PlatformMusic.values[i],
        activePlatformMusic: platformMusic,
        onTape: () => platformMusicSelect(PlatformMusic.values[i]),
      ));
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: new Row(children: buttonGroup),
    );
  }

  Widget _buildSearchType(BuildContext context) {
    List<Widget> buttonGroup = [];
    List<int> iconList = [0xE6E2, 0xE661, 0xE605, 0xE61A];
    List<Color> itemColors = [
      Color(0xfff56c6c),
      Color(0xff409eff),
      Color(0xff67c23a),
      Color(0xffe6a23c)
    ];
    List<String> searchTypeName = ['歌曲', '专辑', '歌手', '歌单'];
    for (var i = 0; i < SearchType.values.length; i++) {
      buttonGroup.add(Expanded(
        child: new SearchItem(
          codePoint: iconList[i],
          searchType: SearchType.values[i],
          activeSearchType: searchType,
          color: itemColors[i],
          text: searchTypeName[i],
          onTap: () => searchTypeSelect(SearchType.values[i]),
        ),
      ));
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: new Row(children: buttonGroup),
    );
  }

  Widget _buildSongList(BuildContext context) {
    TextStyle _style = TextStyle(
        fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500);
    return Expanded(
      child: SmartRefresher(
          enablePullDown: false,
          enablePullUp: true,
          footer: CustomFooter(
            builder: (BuildContext context, LoadStatus mode) {
              Widget body;
              if (mode == LoadStatus.idle) {
                body = Text(
                  "上拉加载更多~",
                  style: _style,
                );
              } else if (mode == LoadStatus.loading) {
                body = CupertinoTheme(
                  data: CupertinoTheme.of(context)
                      .copyWith(brightness: Brightness.dark),
                  child: CupertinoActivityIndicator(),
                );
              } else if (mode == LoadStatus.failed) {
                body = Text(
                  "加载失败,请稍后重试~",
                  style: _style,
                );
              } else if (mode == LoadStatus.canLoading) {
                body = Text(
                  "松开加载~",
                  style: _style,
                );
              } else {
                body = Text(
                  "没有更多了",
                  style: _style,
                );
              }
              return Container(
                height: 55.0,
                child: Center(child: body),
              );
            },
          ),
          controller: _refreshController,
          onLoading: _onLoading,
          header: WaterDropHeader(),
          child: _getListViewContent(context)),
    );
  }

  playAtIndex(content) async {
    final playManage = context.read<PlaylistManage>();
    // 是否是第一次播放
    if (_openState) {
    } else {
      _openState = true;
      List<DataList> list = [];
      _songList.forEach((song) {
        List<Ar> arList = [];
        song.ar.forEach((ar) {
          arList.add(new Ar(ar.id, ar.name, ar.picUrl, ar.platform));
        });
        Al al =
            new Al(song.al.id, song.al.name, song.al.picUrl, song.al.platform);
        if (platformMusic == PlatformMusic.MIGU) {
          list.add(new DataList(song.name, song.id, arList, al, song.mvId, null,
              song.platform, null, song.aId));
        } else {
          list.add(new DataList(song.name, song.id, arList, al, song.mvId,
              song.trackNo, song.platform, song.duration, song.aId));
        }
      });
      playManage.setPlaylist(list);
      await AudioInstance().initPlaylist(_audioPlaylist);
    }
    final idxSong =
        playManage.playlist.indexWhere((song) => content.id == song.id);
    playManage.setPlayIndex(idxSong);
    playManage.setCurrentPlay(playManage.playlist[idxSong]);
    await AudioInstance().playlistPlayAtIndex(idxSong);
  }

  Widget _getListViewContent(context) {
    Widget widget;

    if (_songList.length != 0 ||
        _albumList.length != 0 ||
        _singerList.length != 0 ||
        _playList.length != 0) {
      switch (searchType) {
        case SearchType.SONG:
          widget = ListView.builder(
            itemCount: _songList.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () => playAtIndex(_songList[index]),
                child: SearchSongItem(
                  index: index,
                  content: _songList[index],
                ),
              );
            },
          );
          break;
        case SearchType.ALBUM:
          widget = GridView.builder(
            itemCount: _albumList.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () => openRoute(
                    page: SearchAlbum(
                      platform: getPlatformPara(),
                      platformMusic: platformMusic,
                      //QQ 是mid 其他的是id
                      id: platformMusic == PlatformMusic.QQ
                          ? _albumList[index].mid
                          : _albumList[index].id,
                    ),
                    context: context),
                child: SearchAlbumItem(
                  index: index,
                  content: _albumList[index],
                ),
              );
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 0.0,
              crossAxisSpacing: 0.0,
              childAspectRatio: 1.0,
            ),
          );
          break;
        case SearchType.SINGER:
          widget = GridView.builder(
            itemCount: _singerList.length,
            itemBuilder: (BuildContext context, int index) {
              return SearchSingerItem(
                index: index,
                content: _singerList[index],
              );
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 0.0,
              crossAxisSpacing: 0.0,
              childAspectRatio: 1.0,
            ),
          );
          break;
        case SearchType.PLAYLIST:
          widget = ListView.builder(
            itemCount: _playList.length,
            itemBuilder: (BuildContext context, int index) {
              return SearchPlaylistItem(
                platform: platformMusic,
                index: index,
                content: _playList[index],
              );
            },
          );
          break;
        default:
          widget = Container();
      }
    } else {
      TextStyle _style = TextStyle(
          fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500);
      widget = Center(
        child: Text(
          '空空如也~',
          style: _style,
        ),
      );
    }
    return widget;
  }
}
