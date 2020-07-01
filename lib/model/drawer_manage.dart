import 'package:flutter/material.dart';

class DrawerManage extends ChangeNotifier {
  bool _isOpen = false;
  bool get isOpen => _isOpen;
  void openDrawer() {
    this._isOpen = true;
    notifyListeners();
  }

  void closeDrawer() {
    this._isOpen = false;
    notifyListeners();
  }
}
