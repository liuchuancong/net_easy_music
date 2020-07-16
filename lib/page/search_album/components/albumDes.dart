import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:net_easy_music/json/searchAlbum/search_album_migu/search_album_migu.dart';
import 'package:net_easy_music/json/searchAlbum/search_album_netease/search_album_netease.dart';
import 'package:net_easy_music/json/searchAlbum/search_album_qq/search_album_qq.dart';
import 'package:net_easy_music/type/platform_type.dart';

class AlbumDes extends StatefulWidget {
  final Color backgroundColor;
  final SearchAlbumNetease searchAlbumNetease;
  final SearchAlbumQq searchAlbumQq;
  final SearchAlbumMigu searchAlbumMigu;
  final PlatformMusic platformMusic;
  const AlbumDes(
      {Key key,
      this.backgroundColor,
      this.searchAlbumNetease,
      this.searchAlbumQq,
      this.searchAlbumMigu,
      this.platformMusic})
      : super(key: key);

  @override
  _AlbumDesState createState() => _AlbumDesState();
}

class _AlbumDesState extends State<AlbumDes> {
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
                    ),),
              ]..addAll(_buildDesc(context))),
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
          child: widget.searchAlbumNetease.data.picUrl != null
              ? new CachedNetworkImage(
                  imageUrl: widget.searchAlbumNetease.data.picUrl,
                  errorWidget: (context, url, error) => new Image.asset(
                      'assets/menu_cover.jpg',
                      fit: BoxFit.cover))
              : new Image.asset('assets/menu_cover.jpg', fit: BoxFit.cover),
        );
        break;
      case PlatformMusic.QQ:
        _widget = Container(
          child: widget.searchAlbumQq.data.picUrl != null
              ? new CachedNetworkImage(
                  imageUrl: widget.searchAlbumQq.data.picUrl,
                  errorWidget: (context, url, error) => new Image.asset(
                      'assets/menu_cover.jpg',
                      fit: BoxFit.cover))
              : new Image.asset('assets/menu_cover.jpg', fit: BoxFit.cover),
        );
        break;
      case PlatformMusic.MIGU:
        _widget = Container(
          child: widget.searchAlbumMigu.data.picUrl != null
              ? new CachedNetworkImage(
                  imageUrl: 'http:' + widget.searchAlbumMigu.data.picUrl,
                  errorWidget: (context, url, error) => new Image.asset(
                      'assets/menu_cover.jpg',
                      fit: BoxFit.cover))
              : new Image.asset('assets/menu_cover.jpg', fit: BoxFit.cover),
        );
        break;
    }
    return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          child: _widget,
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.width * 0.5,
        ));
  }

  Widget _buildAlbumName(context, {double fontsize = 18}) {
    Widget _widget;
    TextStyle _albumStyle = TextStyle(
        fontSize: fontsize, color: Colors.white, fontWeight: FontWeight.w500);
    String _albumName = '';
    switch (widget.platformMusic) {
      case PlatformMusic.NETEASE:
        _albumName = widget.searchAlbumNetease.data.name;
        break;
      case PlatformMusic.QQ:
        _albumName = widget.searchAlbumQq.data.name;

        break;
      case PlatformMusic.MIGU:
        _albumName = widget.searchAlbumMigu.data.name;
        break;
    }
    _widget = Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Text(
        _albumName,
        style: _albumStyle,
      ),
    );
    return _widget;
  }

  List<Widget> _buildDesc(BuildContext context) {
    String albumDes;
    switch (widget.platformMusic) {
      case PlatformMusic.NETEASE:
        albumDes = widget.searchAlbumNetease.data.desc;
        break;
      case PlatformMusic.QQ:
        albumDes = widget.searchAlbumQq.data.desc;

        break;
      case PlatformMusic.MIGU:
        albumDes = widget.searchAlbumMigu.data.desc;
        break;
    }
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
