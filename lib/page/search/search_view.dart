import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:net_easy_music/json/searchType/search_type_with_song.dart'
    as Song;

class SearchViewBuild {
  List<Song.Content> buildBySong(BuildContext context, Response response,
      RefreshController refreshController) {
    final data = Song.SearchTypeWithSong.fromJson(response.data);
    List<Song.Content> content = [];
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
