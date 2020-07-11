import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:net_easy_music/api/apiList.dart';
import 'package:net_easy_music/components/blurBackground.dart';
import 'package:net_easy_music/components/customIcon.dart';
import 'package:net_easy_music/json/searchType/search_type_with_song.dart'
    as Song;
import 'package:net_easy_music/model/playlist_manage.dart';
import 'package:net_easy_music/page/search/search_item.dart';
import 'package:net_easy_music/page/search/search_song_item.dart';
import 'package:net_easy_music/page/search/search_view.dart';
import 'package:net_easy_music/plugin/httpManage.dart';
import 'package:net_easy_music/type/platform_type.dart';
import 'package:net_easy_music/type/search_type.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
  List<Song.Content> _songList = [];
  @override
  void initState() {
    _editingController = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currentPlay = Provider.of<PlaylistManage>(context).currentPlay;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: new Stack(
          children: <Widget>[
            BlurBackground(
              imageUrl: currentPlay.al.picUrl + '?param=1440y1440',
            ),
            Column(
              children: <Widget>[
                _buildTopBar(context),
                _buildCard(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void platformMusicSelect(PlatformMusic select) {
    setState(() {
      platformMusic = select;
      pageNo = 1;
    });
    _onLoading();
  }

  void searchTypeSelect(SearchType select) {
    setState(() {
      searchType = select;
      pageNo = 1;
    });
    _onLoading();
  }

  void _onLoading() async {
    //关闭键盘
    FocusScope.of(context).requestFocus(FocusNode());
    if (_editingController.text.isEmpty) {
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
    _getListContent(response);
    print(_songList.length);
    setState(() {});
  }

  _getListContent(Response response) {
    Map songsMap = json.decode(response.toString());
    if (songsMap['result'] == 100) {
      pageNo++;
    }
    switch (searchType) {
      case SearchType.SONG:
        _songList.addAll(SearchViewBuild().buildBySong(
          context,
          response,
          _refreshController,
        ));
        break;
      case SearchType.ALBUM:
        break;
      case SearchType.SINGER:
        break;
      case SearchType.PLAYLIST:
        break;
    }
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              padding: const EdgeInsets.all(18.0),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 20,
              ),
            ),
          )
        ],
      ),
    );
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
                style: TextStyle(),
              );
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text(
                "加载失败,请稍后重试~",
                style: TextStyle(),
              );
            } else if (mode == LoadStatus.canLoading) {
              body = Text(
                "松开加载~",
                style: TextStyle(),
              );
            } else {
              body = Text(
                "没有更多了",
                style: TextStyle(),
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
        child: ListView.builder(
          itemCount: _songList.length,
          itemBuilder: (BuildContext context, int index) {
            return SearchSongItem(
              index: index,
              content: _songList[index],
            );
          },
        ),
      ),
    );
  }
}
