import 'package:flutter/material.dart';
import 'package:net_easy_music/json/playlist.dart';

class PlaylistManage extends ChangeNotifier {
  List<DataList> _playList = [];
  int _playIndex = 0;
  int get playIndex => _playIndex;
  List<DataList> get playlist => _playList;
  DataList _currentPlay;
  DataList get currentPlay => _currentPlay;
  void setPlaylist(List<DataList> list) {
    this._playList = list;
    if (_currentPlay == null) {
      this._currentPlay = list[0];
    }
    notifyListeners();
  }

  void setPlayIndex(int index) {
    this._playIndex = index;
    notifyListeners();
  }

  void addAll(List<DataList> list) {
    this._playList.addAll(list);
    notifyListeners();
  }

  void setCurrentPlay(DataList currentPlay) {
    this._currentPlay = currentPlay;
    notifyListeners();
  }
}
