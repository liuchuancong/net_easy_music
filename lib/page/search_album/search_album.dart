import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:net_easy_music/api/apiList.dart';
import 'package:net_easy_music/components/bottomPlayerBar.dart';
import 'package:net_easy_music/components/playAllButton.dart';
import 'package:net_easy_music/json/searchAlbum/search_album_migu/search_album_migu.dart';
import 'package:net_easy_music/json/searchAlbum/search_album_netease/search_album_netease.dart';
import 'package:net_easy_music/json/searchAlbum/search_album_qq/search_album_qq.dart';
import 'package:net_easy_music/plugin/httpManage.dart';
import 'package:net_easy_music/type/platform_type.dart';
import 'package:net_easy_music/utils/paletteColor.dart';

import 'components/albumList.dart';
import 'components/header.dart';

///歌单详情信息 header 高度
const double HEIGHT_HEADER = 280 + kToolbarHeight;

class SearchAlbum extends StatefulWidget {
  final String platform;
  final dynamic id;
  final PlatformMusic platformMusic;
  const SearchAlbum(
      {Key key,
      @required this.platform,
      @required this.id,
      @required this.platformMusic})
      : super(key: key);
  @override
  _SearchAlbumState createState() => _SearchAlbumState();
}

class _SearchAlbumState extends State<SearchAlbum> {
  ScrollController _controller = ScrollController();
  final maxExtent = 230.0;
  double currentExtent = 0.0;
  SearchAlbumNetease searchAlbumNetease;
  SearchAlbumQq searchAlbumQq;
  SearchAlbumMigu searchAlbumMigu;
  bool hasLoaded = false;
  Color _headerColor = Colors.black;
  @override
  void initState() {
    _getAlbumInfomation();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildLoading(BuildContext context) {
    return _buildPreview(
        context, Container(height: 200, child: Center(child: Text("加载中..."))));
  }

  Widget _buildPreview(BuildContext context, Widget content) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          expandedHeight: HEIGHT_HEADER,
          flexibleSpace: FlexibleSpaceBar(
              background: Container(
            color: _headerColor,
          )),
          bottom: PlayAllButton(0),
        ),
        SliverList(delegate: SliverChildListDelegate([content]))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _headerColor,
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
          child: BottomControllerBar(
        child: Stack(
          children: <Widget>[
            Positioned(
                child: Container(
              color: Colors.white,
            )),
            hasLoaded
                ? CustomScrollView(slivers: [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      expandedHeight: HEIGHT_HEADER,
                      backgroundColor: Colors.transparent,
                      pinned: true,
                      elevation: 0,
                      flexibleSpace: AlbumHeader(
                        width: MediaQuery.of(context).size.width,
                        searchAlbumMigu: searchAlbumMigu,
                        searchAlbumNetease: searchAlbumNetease,
                        searchAlbumQq: searchAlbumQq,
                        platformMusic: widget.platformMusic,
                        headerColor: _headerColor,
                      ),
                      bottom: PlayAllButton(_getPlayListLength()),
                    ),
                    AlbumList(
                      searchAlbumMigu: searchAlbumMigu,
                      searchAlbumNetease: searchAlbumNetease,
                      searchAlbumQq: searchAlbumQq,
                      platformMusic: widget.platformMusic,
                    )
                  ])
                : _buildLoading(context),
          ],
        ),
      )),
    );
  }

  _getAlbumInfomation() async {
    // 获取专辑信息
    Map<String, dynamic> searchMap = {
      '_p': widget.platform,
      'id': widget.id,
      '_t': Duration().inMicroseconds.toString()
    };

    final Response response =
        await HttpManager(context).get(apiList['ALBUM'], data: searchMap);
    //平台不同分开解析
    if (widget.platformMusic == PlatformMusic.NETEASE) {
      searchAlbumNetease = SearchAlbumNetease.fromJson(response.data);
      _headerColor = await PaletteColor()
          .getDarkColor(imageUrl: searchAlbumNetease.data.picUrl);
    } else if (widget.platformMusic == PlatformMusic.QQ) {
      searchAlbumQq = SearchAlbumQq.fromJson(response.data);
      _headerColor = await PaletteColor()
          .getDarkColor(imageUrl: searchAlbumQq.data.picUrl);
    }
    if (widget.platformMusic == PlatformMusic.MIGU) {
      searchAlbumMigu = SearchAlbumMigu.fromJson(response.data);

      _headerColor = await PaletteColor()
          .getDarkColor(imageUrl: 'http:' + searchAlbumMigu.data.picUrl);
    }

    setState(() {
      hasLoaded = true;
    });
  }

  _getPlayListLength() {
    int _count = 0;
    switch (widget.platformMusic) {
      case PlatformMusic.NETEASE:
        _count = searchAlbumNetease.data.content.length;
        break;
      case PlatformMusic.QQ:
        _count = searchAlbumQq.data.content.length;
        break;
      case PlatformMusic.MIGU:
        _count = searchAlbumMigu.data.content.length;
        break;
    }
    return _count;
  }
  // List<Widget> _buildDesc(BuildContext context) {
  //   List<String> descArr = albumDes.split(new RegExp(r'/[(\r\n)\r\n]+/'));
  //   return descArr.map((e) {
  //     var txt = e.split('');
  //     return Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: RichText(
  //           text: TextSpan(
  //               children: txt
  //                   .map((e) => TextSpan(
  //                       text: e,
  //                       style: TextStyle(color: Colors.white, fontSize: 12)))
  //                   .toList()),
  //           textAlign: TextAlign.left),
  //     );
  //   }).toList();
  // }
}

/// a detail header describe album informatio
