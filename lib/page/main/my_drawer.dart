import 'package:flutter/material.dart';
import 'package:net_easy_music/page/main/user_nav_bar.dart';
import 'nav_bar.dart';

class MyDrawer extends StatefulWidget {
  final ValueChanged<bool> callback;

  const MyDrawer({Key key, @required this.callback}) : super(key: key);
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  void initState() {
    widget.callback(true);
    super.initState();
  }

  @override
  void dispose() {
    widget.callback(false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .5,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          HSLColor.fromAHSL(.6, 0, 0, 0.8).toColor(),
          HSLColor.fromAHSL(.6, 0, 0, 0.8).toColor(),
          HSLColor.fromAHSL(.33, 0, 0, 0.8).toColor(),
          HSLColor.fromAHSL(.0, 0, 0, 0.8).toColor(),
          HSLColor.fromAHSL(.0, 0, 0, 0.8).toColor(),
          HSLColor.fromAHSL(.0, 0, 0, 0.8).toColor()
        ],
      )),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).padding.top + 30,
          ),
          UserNavBar(
            title: '来登陆呀',
          ),
          NavBar(
            codePoint: 0xE606,
            title: '寻觅',
          ),
          NavBar(
            codePoint: 0xE61A,
            title: '歌单',
          ),
          NavBar(
            codePoint: 0xE620,
            title: '推荐',
          ),
          NavBar(
            codePoint: 0xE652,
            title: '下载',
          ),
          NavBar(
            codePoint: 0xE60F,
            title: '极简',
          ),
          NavBar(
            codePoint: 0xE612,
            title: '设置',
          ),
          NavBar(
            codePoint: 0xE712,
            title: '关于',
          ),
        ],
      ),
    );
  }
}
