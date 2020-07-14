import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FlutterToastManage {
  //单例模式
  static FlutterToastManage _instance;
  FlutterToast _flutterToast;
  FlutterToast get flutterToast => _flutterToast;
  //单例模式，只创建一次实例
  static FlutterToastManage getInstance() {
    if (null == _instance) {
      _instance = new FlutterToastManage();
    }
    return _instance;
  }

  _init(BuildContext context) {
    _flutterToast = new FlutterToast(context);
  }

  showToast(String msg, BuildContext context,
      {int seconds = 1, Color color = Colors.white, Icon icon,ToastGravity gravity = ToastGravity.CENTER}) {
    _init(context);
    if(_flutterToast !=null){
      _flutterToast.removeCustomToast();
    }
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: color,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) icon,
          if (icon != null)
            SizedBox(
              width: 12.0,
            ),
          Text(msg),
        ],
      ),
    );

    _flutterToast.showToast(
      child: toast,
      gravity: gravity,
      toastDuration: Duration(seconds: seconds),
    );
  }
}
