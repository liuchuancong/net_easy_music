import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:net_easy_music/api/apiList.dart';
import 'package:net_easy_music/components/blurBackground.dart';
import 'package:net_easy_music/json/searchAlbum/search_album_netease/search_album_netease.dart';
import 'package:net_easy_music/model/playlist_manage.dart';
import 'package:net_easy_music/plugin/httpManage.dart';
import 'package:net_easy_music/type/platform_type.dart';
import 'package:provider/provider.dart';

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
  String albumDes = '';
  final maxExtent = 230.0;
  double currentExtent = 0.0;
  @override
  void initState() {
    _getAlbumInfomation();
    _controller.addListener(() {
      setState(() {
        currentExtent = maxExtent - _controller.offset;
        if (currentExtent < 0) currentExtent = 0.0;
        if (currentExtent > maxExtent) currentExtent = maxExtent;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
            CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  pinned: true,
                  expandedHeight: maxExtent,
                  flexibleSpace: FlexibleSpaceBar.createSettings(
                    currentExtent: currentExtent,
                    minExtent: 0,
                    maxExtent: maxExtent,
                    child: FlexibleSpaceBar(
                      background: Placeholder(),
                      collapseMode: CollapseMode.pin,
                      // titlePadding: EdgeInsetsDirectional.only(start: 50,top: 20),
                      title: new Text(
                        'Some Text Here',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (_, index) => ListTile(
                      title: Text(
                        "Index: $index",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
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
      SearchAlbumNetease searchAlbumNetease =
          SearchAlbumNetease.fromJson(response.data);
      albumDes = searchAlbumNetease.data.desc;
      setState(() {});
    }
  }

  List<Widget> _buildDesc(BuildContext context) {
    List<String> descArr = albumDes.split(new RegExp(r'/[(\r\n)\r\n]+/'));
    return descArr.map((e) {
      var txt = e.split('');
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: RichText(
            text: TextSpan(
                children: txt
                    .map((e) => TextSpan(
                        text: e,
                        style: TextStyle(color: Colors.white, fontSize: 12)))
                    .toList()),
            textAlign: TextAlign.left),
      );
    }).toList();
  }
}
