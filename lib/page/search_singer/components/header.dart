import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:net_easy_music/common/common.dart';
import 'package:net_easy_music/json/singerInfo/singer_info.dart';
import 'package:net_easy_music/material/flexible_app_bar.dart';
import 'package:net_easy_music/type/platform_type.dart';

import 'singerDes.dart';
import 'singerDetailHeader.dart';

class SingerInfoHeader extends StatefulWidget {
  final SingerInfo singerInfo;
  final String singer;
  final PlatformMusic platformMusic;
  final double width;
  final Color headerColor;
  const SingerInfoHeader(
      {Key key,
      this.platformMusic,
      this.width,
      this.headerColor,
      this.singerInfo,
      this.singer})
      : super(key: key);

  @override
  _AlbumHeaderState createState() => _AlbumHeaderState();
}

class _AlbumHeaderState extends State<SingerInfoHeader> {
  Widget _buildImage() {
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
      child: ClipRRect(borderRadius: BorderRadius.circular(10), child: _widget),
    );
  }

  Widget _buildAlias() {
    Widget _widget;
    TextStyle _aliasStype = TextStyle(
        fontSize: 14, color: Colors.white60, fontWeight: FontWeight.normal);
    String _alias = '';
    if (widget.singerInfo.data.alias!=null && widget.singerInfo.data.alias.length > 0) {
      _alias = widget.singerInfo.data.alias[0];
      _widget = Text(
        _alias,
        maxLines: 1,
        style: _aliasStype,
      );
    } else {
      _widget = Container();
    }

    return _widget;
  }

  Widget _buildDesc() {
    Widget _widget;
    TextStyle _descStyle = TextStyle(fontSize: 14, color: Colors.white60);
    String _desc = widget.singer;
    _widget = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          _desc,
          style: _descStyle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Align(
            alignment: Alignment.topCenter,
            child: Icon(
              Icons.chevron_right,
              color: Colors.white60,
              size: 15,
            )),
      ],
    );
    return _widget;
  }

  _buildContent(BuildContext context) {
    return Container(
      width: widget.width,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + kToolbarHeight,
        left: 15,
        right: 10,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              openRoute(
                page: SingerDes(
                  backgroundColor: widget.headerColor,
                  platformMusic: widget.platformMusic,
                  singerInfo: widget.singerInfo,
                  singer: widget.singer,
                ),
                context: context,
              );
            },
            child: Row(
              children: <Widget>[
                Container(
                  width: widget.width * 0.3,
                  child: _buildImage(),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
                    height: widget.width * 0.3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 5,
                        ),
                        _buildAlias(),
                        SizedBox(
                          height: 10,
                        ),
                        _buildDesc(),
                        SizedBox(
                          height: 5,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          AlbumDetailHeader()
        ],
      ),
    );
  }

  getImageUrl() {
    String _imageUrl = '';
    switch (widget.platformMusic) {
      case PlatformMusic.NETEASE:
        _imageUrl = widget.singerInfo.data.picUrl;
        break;
      case PlatformMusic.QQ:
        _imageUrl = widget.singerInfo.data.picUrl;
        break;
      case PlatformMusic.MIGU:
        _imageUrl = 'http:' + widget.singerInfo.data.picUrl;
        break;
    }
    return _imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    return FlexibleDetailBar(
      content: _buildContent(context),
      builder: (context, t) => AppBar(
          automaticallyImplyLeading: false,
          title: Text(''),
          titleSpacing: 16,
          elevation: 0,
          leading: BackButton(),
          backgroundColor: Colors.transparent),
      background: Container(
        color: widget.headerColor,
      ),
    );
  }
}
