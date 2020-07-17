import 'package:flutter/material.dart';
import 'package:net_easy_music/settings/setting.dart';
import 'package:net_easy_music/type/play_model.dart';

class PlayModelManage extends ChangeNotifier {
  PlayModel _playModel = setting.playModel;
  PlayModel get playModel => _playModel;

  void setPlayModel(PlayModel playModel) {
    this._playModel = playModel;
    setting.playModel = playModel;
    notifyListeners();
  }
}
