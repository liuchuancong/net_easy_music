import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:net_easy_music/json/singerInfo/singer_info.dart';
import 'package:net_easy_music/type/platform_type.dart';
import 'package:net_easy_music/extension/mapIndex.dart';

class SingerDes extends StatefulWidget {
  final Color backgroundColor;
  final SingerInfo singerInfo;
  final PlatformMusic platformMusic;
  final String singer;
  const SingerDes({
    Key key,
    this.backgroundColor,
    this.platformMusic,
    this.singerInfo,
    this.singer,
  }) : super(key: key);

  @override
  _SingerDesState createState() => _SingerDesState();
}

class _SingerDesState extends State<SingerDes> {
  Widget _buildTopBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Container(),
      actions: <Widget>[CloseButton()],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor.withOpacity(0.9),
      body: SafeArea(
        child: new ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                  children: <Widget>[
                _buildTopBar(context),
                _buildImage(context),
                _buildAlbumName(context),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  height: 0.5,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Colors.white24.withOpacity(0.05),
                        Colors.white24.withOpacity(0.2),
                        Colors.white24.withOpacity(0.05),
                      ],
                    ),
                  ),
                ),
              ]
                    ..addAll(_buildDesc(context))
                    ..addAll(_buildIntro(context))),
            ),
            // AudioControl()
          ],
        ),
      ),
    );
  }

  Widget _buildImage(context) {
    Widget _widget;
    switch (widget.platformMusic) {
      case PlatformMusic.NETEASE:
        _widget = Container(
          child: widget.singerInfo.data.picUrl != null
              ? new CachedNetworkImage(
                  imageUrl: widget.singerInfo.data.picUrl,
                  errorWidget: (context, url, error) => new Image.asset(
                      'assets/menu_cover.jpg',
                      fit: BoxFit.cover))
              : new Image.asset('assets/menu_cover.jpg', fit: BoxFit.cover),
        );
        break;
      case PlatformMusic.QQ:
        _widget = Container(
          child: widget.singerInfo.data.picUrl != null
              ? new CachedNetworkImage(
                  imageUrl: widget.singerInfo.data.picUrl,
                  errorWidget: (context, url, error) => new Image.asset(
                      'assets/menu_cover.jpg',
                      fit: BoxFit.cover))
              : new Image.asset('assets/menu_cover.jpg', fit: BoxFit.cover),
        );
        break;
      case PlatformMusic.MIGU:
        _widget = Container(
          child: widget.singerInfo.data.picUrl != null
              ? new CachedNetworkImage(
                  imageUrl: 'http:' + widget.singerInfo.data.picUrl,
                  errorWidget: (context, url, error) => new Image.asset(
                      'assets/menu_cover.jpg',
                      fit: BoxFit.cover))
              : new Image.asset('assets/menu_cover.jpg', fit: BoxFit.cover),
        );
        break;
    }
    return Hero(
      tag: 'album_detail',
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            child: _widget,
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.width * 0.5,
          )),
    );
  }

  Widget _buildAlbumName(context, {double fontsize = 18}) {
    Widget _widget;
    TextStyle _albumStyle = TextStyle(
        fontSize: fontsize, color: Colors.white, fontWeight: FontWeight.w500);
    String _albumName = '';
    switch (widget.platformMusic) {
      case PlatformMusic.NETEASE:
        _albumName = widget.singer;
        break;
      case PlatformMusic.QQ:
        _albumName = widget.singer;

        break;
      case PlatformMusic.MIGU:
        _albumName = widget.singer;
        break;
    }
    _widget = Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Text(
        _albumName.toString(),
        style: _albumStyle,
      ),
    );
    return _widget;
  }

  List<Widget> _buildDesc(BuildContext context) {
    String singerDes;
    switch (widget.platformMusic) {
      case PlatformMusic.NETEASE:
        singerDes = widget.singerInfo.data.desc;
        break;
      case PlatformMusic.QQ:
        singerDes = widget.singerInfo.data.desc;

        break;
      case PlatformMusic.MIGU:
        singerDes = widget.singerInfo.data.desc;
        break;
    }
    List<String> descArr = singerDes.split(new RegExp(r'/[(\r\n)\r\n]+/'));
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

  List<Widget> _buildIntro(BuildContext context) {
    List<Intro> singerDes;
    switch (widget.platformMusic) {
      case PlatformMusic.NETEASE:
        singerDes = widget.singerInfo.data.intro;
        break;
      case PlatformMusic.QQ:
        singerDes = widget.singerInfo.data.intro;

        break;
      case PlatformMusic.MIGU:
        singerDes = widget.singerInfo.data.intro;
        break;
    }
    return singerDes.map((Intro e) {
      var txt = e.txt.split('');
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Text(e.ti,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600)),
            ),
            RichText(
                text: TextSpan(
                    children: txt.mapIndex((e, i) {
                  return TextSpan(
                      text: e,
                      style: TextStyle(color: Colors.white, fontSize: 12));
                }).toList()),
                textAlign: TextAlign.left),
          ],
        ),
      );
    }).toList();
  }
}
