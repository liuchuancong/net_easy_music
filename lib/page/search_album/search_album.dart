import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:net_easy_music/api/apiList.dart';
import 'package:net_easy_music/json/searchAlbum/search_album_migu/search_album_migu.dart';
import 'package:net_easy_music/json/searchAlbum/search_album_netease/search_album_netease.dart';
import 'package:net_easy_music/json/searchAlbum/search_album_qq/search_album_qq.dart';
import 'package:net_easy_music/plugin/httpManage.dart';
import 'package:net_easy_music/type/platform_type.dart';
import 'package:net_easy_music/utils/paletteColor.dart';

import 'components/albumList.dart';
import 'components/header.dart';

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

  Widget _buildTopBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: hasLoaded ? Colors.transparent : Colors.black,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: new Stack(
          children: <Widget>[
            Container(
              color: _headerColor,
              child: Column(
                children: <Widget>[
                  Container(
                    height: maxExtent,
                    child: Column(
                      children: <Widget>[
                        _buildTopBar(context),
                        hasLoaded
                            ? AlbumHeader(
                                width: MediaQuery.of(context).size.width,
                                searchAlbumMigu: searchAlbumMigu,
                                searchAlbumNetease: searchAlbumNetease,
                                searchAlbumQq: searchAlbumQq,
                                platformMusic: widget.platformMusic,
                              )
                            : Container(),
                      ],
                    ),
                  ),
                  hasLoaded
                      ? Expanded(
                          child: Container(
                            color: hasLoaded ? _headerColor : Colors.white,
                            child: AlbumList(
                              searchAlbumMigu: searchAlbumMigu,
                              searchAlbumNetease: searchAlbumNetease,
                              searchAlbumQq: searchAlbumQq,
                              platformMusic: widget.platformMusic,
                            ),
                          ),
                        )
                      : Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0)),
                            child: Container(
                              color: Colors.white,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 30),
                                    child: SpinKitWave(
                                      color: Colors.red,
                                      size: 10.0,
                                      itemCount: 5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                ],
              ),
            )
          ],
        ),
      ),
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
        await HttpManager().get(apiList['ALBUM'], data: searchMap);
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
