import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:net_easy_music/json/search_type_with_song_migu/search_type_with_song_migu.dart'
    as migu;
import 'package:net_easy_music/json/search_type_with_song_netease/search_type_with_song_netease.dart'
    as netease;
import 'package:net_easy_music/json/search_type_with_song_qq/search_type_with_song_qq.dart'
    as qq;
import 'package:net_easy_music/type/platform_type.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:net_easy_music/json/searchType/search_type_with_album.dart'
    as Album;
import 'package:net_easy_music/json/searchType/search_type_with_singer.dart'
    as Singer;
import 'package:net_easy_music/json/searchType/search_type_with_playlist.dart'
    as Playlist;

class SearchViewBuild {
  buildBySong(BuildContext context, Response response,
      RefreshController refreshController, PlatformMusic platformMusic) {
    var data;
    var content = [];
    if (platformMusic == PlatformMusic.NETEASE) {
      data = netease.SearchTypeWithSongNetease.fromJson(response.data);
    }
    if (platformMusic == PlatformMusic.QQ) {
      data = qq.SearchTypeWithSongQq.fromJson(response.data);
    }
    if (platformMusic == PlatformMusic.MIGU) {
      data = migu.SearchTypeWithSongMigu.fromJson(response.data);
    }
    if (data!=null && data.result == 100) {
      refreshController.loadComplete();
      if (data.data.content.length > 0) {
        content = data.data.content;
      } else {
        refreshController.loadNoData();
      }
    } else {
      refreshController.loadFailed();
    }
    return content;
  }

  List<Album.Content> buildByAlbum(BuildContext context, Response response,
      RefreshController refreshController) {
    final data = Album.SearchTypeWithAlbum.fromJson(response.data);
    List<Album.Content> content = [];
    if (data.result == 100) {
      refreshController.loadComplete();
      if (data.data.content.length > 0) {
        content = data.data.content;
      } else {
        refreshController.loadNoData();
      }
    } else {
      refreshController.loadFailed();
    }
    return content;
  }

  List<Singer.Content> buildBySinger(BuildContext context, Response response,
      RefreshController refreshController) {
    final data = Singer.SearchTypeWithSinger.fromJson(response.data);
    List<Singer.Content> content = [];
    if (data.result == 100) {
      refreshController.loadComplete();
      if (data.data.content.length > 0) {
        content = data.data.content;
      } else {
        refreshController.loadNoData();
      }
    } else {
      refreshController.loadFailed();
    }
    return content;
  }

  List<Playlist.Content> buildByPlaylist(BuildContext context,
      Response response, RefreshController refreshController) {
    final data = Playlist.SearchTypeWithPlaylist.fromJson(response.data);
    List<Playlist.Content> content = [];
    if (data.result == 100) {
      refreshController.loadComplete();
      if (data.data.content.length > 0) {
        content = data.data.content;
      } else {
        refreshController.loadNoData();
      }
    } else {
      refreshController.loadFailed();
    }
    return content;
  }
}
