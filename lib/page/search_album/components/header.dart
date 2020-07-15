import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:net_easy_music/json/searchAlbum/search_album_migu/search_album_migu.dart';
import 'package:net_easy_music/json/searchAlbum/search_album_netease/search_album_netease.dart';
import 'package:net_easy_music/json/searchAlbum/search_album_qq/search_album_qq.dart';
import 'package:net_easy_music/type/platform_type.dart';

class AlbumHeader extends StatelessWidget {
  final SearchAlbumNetease searchAlbumNetease;
  final SearchAlbumQq searchAlbumQq;
  final SearchAlbumMigu searchAlbumMigu;
  final PlatformMusic platformMusic;
  final double width;
  const AlbumHeader(
      {Key key,
      this.searchAlbumNetease,
      this.searchAlbumQq,
      this.searchAlbumMigu,
      this.platformMusic,
      this.width})
      : super(key: key);

  Widget _buildImage() {
    Widget _widget;
    switch (platformMusic) {
      case PlatformMusic.NETEASE:
        _widget = Container(
          child: searchAlbumNetease.data.picUrl != null
              ? new CachedNetworkImage(
                  imageUrl: searchAlbumNetease.data.picUrl,
                  errorWidget: (context, url, error) => new Image.asset(
                      'assets/menu_cover.jpg',
                      fit: BoxFit.cover))
              : new Image.asset('assets/menu_cover.jpg', fit: BoxFit.cover),
        );
        break;
      case PlatformMusic.QQ:
        _widget = Container(
          child: searchAlbumQq.data.picUrl != null
              ? new CachedNetworkImage(
                  imageUrl: searchAlbumQq.data.picUrl,
                  errorWidget: (context, url, error) => new Image.asset(
                      'assets/menu_cover.jpg',
                      fit: BoxFit.cover))
              : new Image.asset('assets/menu_cover.jpg', fit: BoxFit.cover),
        );
        break;
      case PlatformMusic.MIGU:
        _widget = Container(
          child: searchAlbumMigu.data.picUrl != null
              ? new CachedNetworkImage(
                  imageUrl: 'http:' + searchAlbumMigu.data.picUrl,
                  errorWidget: (context, url, error) => new Image.asset(
                      'assets/menu_cover.jpg',
                      fit: BoxFit.cover))
              : new Image.asset('assets/menu_cover.jpg', fit: BoxFit.cover),
        );
        break;
    }
    return ClipRRect(borderRadius: BorderRadius.circular(10), child: _widget);
  }

  Widget _buildAlbumName() {
    Widget _widget;
    TextStyle _albumStyle = TextStyle(
        fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500);
    String _albumName;
    switch (platformMusic) {
      case PlatformMusic.NETEASE:
        _albumName = searchAlbumNetease.data.name;
        break;
      case PlatformMusic.QQ:
        _albumName = searchAlbumQq.data.name;

        break;
      case PlatformMusic.MIGU:
        _albumName = searchAlbumMigu.data.name;
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
    switch (platformMusic) {
      case PlatformMusic.NETEASE:
        searchAlbumNetease.data.artlists.forEach((ar) {
          singers += ar.name + ' ';
        });
        break;
      case PlatformMusic.QQ:
        searchAlbumQq.data.artlists.forEach((ar) {
          singers += ar.name + ' ';
        });
        break;
      case PlatformMusic.MIGU:
        searchAlbumMigu.data.artlists.forEach((ar) {
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

  String _getTime(int date) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(date);
    String year = dateTime.year.toString();
    String month = dateTime.month.toString();
    String day = dateTime.day.toString();
    return year + '.' + month + '.' + day;
  }

  Widget _buildPublishTime() {
    Widget _widget;
    TextStyle _publishTimeStyle = TextStyle(
        fontSize: 14, color: Colors.white60, fontWeight: FontWeight.normal);
    String _publistTime = '发行时间: ';
    switch (platformMusic) {
      case PlatformMusic.NETEASE:
        _publistTime += _getTime(searchAlbumNetease.data.publishTime);
        break;
      case PlatformMusic.QQ:
        _publistTime += _getTime(searchAlbumQq.data.publishTime);
        break;
      case PlatformMusic.MIGU:
        _publistTime += _getTime(searchAlbumMigu.data.publishTime);

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
    switch (platformMusic) {
      case PlatformMusic.NETEASE:
        if (searchAlbumNetease.data.desc != null) {
          _desc = searchAlbumNetease.data.desc.trim().replaceAll(new RegExp(r'/[(\r\n)\r\n]+/'), '');
        }

        break;
      case PlatformMusic.QQ:
        if (searchAlbumQq.data.desc != null) {
          _desc = searchAlbumQq.data.desc.trim().replaceAll(new RegExp(r'/[(\r\n)\r\n]+/'), '');
        }
        break;
      case PlatformMusic.MIGU:
        if (searchAlbumMigu.data.desc != null) {
          _desc = searchAlbumMigu.data.desc.trim().replaceAll(new RegExp(r'/[(\r\n)\r\n]+/'), '');
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

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: width * 0.3,
      padding: EdgeInsets.only(left: 15, right: 10),
      child: Row(
        children: <Widget>[
          Container(
            width: width * 0.3,
            height: width * 0.3,
            child: _buildImage(),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
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
          )
        ],
      ),
    );
  }
}
