import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:net_easy_music/common/common.dart';
import 'package:net_easy_music/json/searchAlbum/search_album_migu/search_album_migu.dart';
import 'package:net_easy_music/json/searchAlbum/search_album_netease/search_album_netease.dart';
import 'package:net_easy_music/json/searchAlbum/search_album_qq/search_album_qq.dart';
import 'package:net_easy_music/material/flexible_app_bar.dart';
import 'package:net_easy_music/type/platform_type.dart';
import 'package:net_easy_music/utils/time.dart';

import 'albumDes.dart';
import 'albumDetailHeader.dart';

class AlbumHeader extends StatefulWidget {
  final SearchAlbumNetease searchAlbumNetease;
  final SearchAlbumQq searchAlbumQq;
  final SearchAlbumMigu searchAlbumMigu;
  final PlatformMusic platformMusic;
  final double width;
  final Color headerColor;
  const AlbumHeader(
      {Key key,
      this.searchAlbumNetease,
      this.searchAlbumQq,
      this.searchAlbumMigu,
      this.platformMusic,
      this.width,
      this.headerColor})
      : super(key: key);

  @override
  _AlbumHeaderState createState() => _AlbumHeaderState();
}

class _AlbumHeaderState extends State<AlbumHeader> {
  Widget _buildImage() {
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
    return Hero(
      tag: 'album_detail',
      child: ClipRRect(borderRadius: BorderRadius.circular(10), child: _widget),
    );
  }

  Widget _buildAlbumName({double fontsize = 18}) {
    Widget _widget;
    TextStyle _albumStyle = TextStyle(
        fontSize: fontsize, color: Colors.white, fontWeight: FontWeight.w500);
    String _albumName;
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
    _widget = Text(
      _albumName,
      style: _albumStyle,
    );
    return _widget;
  }

  Widget _buildSingers() {
    Widget _widget;
    TextStyle _singersStyle = TextStyle(
        fontSize: 14, color: Colors.white70, fontWeight: FontWeight.w300);
    String singers = '歌手: ';
    switch (widget.platformMusic) {
      case PlatformMusic.NETEASE:
        widget.searchAlbumNetease.data.artlists.forEach((ar) {
          singers += ar.name + ' ';
        });
        break;
      case PlatformMusic.QQ:
        widget.searchAlbumQq.data.artlists.forEach((ar) {
          singers += ar.name + ' ';
        });
        break;
      case PlatformMusic.MIGU:
        widget.searchAlbumMigu.data.artlists.forEach((ar) {
          singers += ar.name + ' ';
        });

        break;
    }
    _widget = Row(
      children: <Widget>[
        Text(
          singers,
          style: _singersStyle,
        ),
        Align(
            alignment: Alignment.topCenter,
            child: Icon(
              Icons.chevron_right,
              color: Colors.white70,
              size: 15,
            )),
      ],
    );
    return _widget;
  }

  Widget _buildPublishTime() {
    Widget _widget;
    TextStyle _publishTimeStyle = TextStyle(
        fontSize: 14, color: Colors.white60, fontWeight: FontWeight.normal);
    String _publistTime = '发行时间: ';
    switch (widget.platformMusic) {
      case PlatformMusic.NETEASE:
        _publistTime +=
            getFormattedTime(widget.searchAlbumNetease.data.publishTime);
        break;
      case PlatformMusic.QQ:
        _publistTime += getFormattedTime(widget.searchAlbumQq.data.publishTime);
        break;
      case PlatformMusic.MIGU:
        _publistTime +=
            getFormattedTime(widget.searchAlbumMigu.data.publishTime);

        break;
    }
    _widget = Text(
      _publistTime,
      maxLines: 1,
      style: _publishTimeStyle,
    );
    return _widget;
  }

  Widget _buildDesc() {
    Widget _widget;
    TextStyle _descStyle = TextStyle(fontSize: 14, color: Colors.white60);
    String _desc = '';
    switch (widget.platformMusic) {
      case PlatformMusic.NETEASE:
        if (widget.searchAlbumNetease.data.desc != null) {
          _desc = widget.searchAlbumNetease.data.desc
              .trim()
              .replaceAll(new RegExp(r'/[(\r\n)\r\n]+/'), '');
        }

        break;
      case PlatformMusic.QQ:
        if (widget.searchAlbumQq.data.desc != null) {
          _desc = widget.searchAlbumQq.data.desc
              .trim()
              .replaceAll(new RegExp(r'/[(\r\n)\r\n]+/'), '');
        }
        break;
      case PlatformMusic.MIGU:
        if (widget.searchAlbumMigu.data.desc != null) {
          _desc = widget.searchAlbumMigu.data.desc
              .trim()
              .replaceAll(new RegExp(r'/[(\r\n)\r\n]+/'), '');
        }
        break;
    }
    _widget = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Text(
            _desc,
            style: _descStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (_desc != null && _desc.length > 0)
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
          right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              openRoute(
                  page: AlbumDes(
                    backgroundColor: widget.headerColor,
                    searchAlbumMigu: widget.searchAlbumMigu,
                    searchAlbumNetease: widget.searchAlbumNetease,
                    searchAlbumQq: widget.searchAlbumQq,
                    platformMusic: widget.platformMusic,
                  ),
                  context: context);
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 5,
                        ),
                        _buildAlbumName(),
                        Spacer(),
                        _buildSingers(),
                        Spacer(),
                        _buildPublishTime(),
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
        _imageUrl = widget.searchAlbumNetease.data.picUrl;
        break;
      case PlatformMusic.QQ:
        _imageUrl = widget.searchAlbumQq.data.picUrl;
        break;
      case PlatformMusic.MIGU:
        _imageUrl = widget.searchAlbumMigu.data.picUrl;
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
          title: t > 0.5 ? _buildAlbumName() : Text('专辑'),
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
