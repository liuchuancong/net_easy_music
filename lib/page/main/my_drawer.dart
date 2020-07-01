import 'package:flutter/material.dart';
import 'package:net_easy_music/model/drawer_manage.dart';
import 'package:provider/provider.dart';

import 'nav_bar.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  void initState() {
    open();
    super.initState();
  }

  open()  {
   Provider.of<DrawerManage>(context, listen: false).openDrawer();
  }

  @override
  void didChangeDependencies() {
    if (Provider.of<DrawerManage>(context, listen: false).isOpen) {
      Provider.of<DrawerManage>(context, listen: false).closeDrawer();
      print(Provider.of<DrawerManage>(context, listen: false).isOpen);
    }
    print('ssssss');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .65,
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
            height: MediaQuery.of(context).padding.top,
          ),
          NavBar(
            codePoint: 0xE606,
          ),
          NavBar(
            codePoint: 0xE606,
          ),
          NavBar(
            codePoint: 0xE61A,
          ),
          NavBar(
            codePoint: 0xE620,
          ),
          NavBar(
            codePoint: 0xE652,
          ),
          NavBar(
            codePoint: 0xE612,
          ),
          NavBar(
            codePoint: 0xE712,
          ),
        ],
      ),
    );
  }
}
