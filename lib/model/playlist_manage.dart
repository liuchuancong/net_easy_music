import 'package:flutter/material.dart';
import 'package:net_easy_music/json/playlist.dart';

class PlaylistManage extends ChangeNotifier {
  List<DataList> _playList = [];
  int _playIndex =
      0; //assetsAudioPlayer.current.value.index   不能使用这个 这个经常可能为null
  int get playIndex => _playIndex;
  int get nextIndex => _getNextIndex();
  int get prevIndex => _getPrevIndex();
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

  int _getPrevIndex() {
    int _prevIndex = playIndex - 1;
    if (_prevIndex < 0) {
      _prevIndex = 0;
    }
    return _prevIndex;
  }

  int _getNextIndex() {
    int _nextIndex = playIndex + 1;
    if (_playList.length != 0 && _nextIndex > _playList.length) {
      _nextIndex = _playList.length;
    }
    return _nextIndex;
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
    this._playIndex = _playList.indexOf(currentPlay);
    this._currentPlay = currentPlay;
    notifyListeners();
  }
}
