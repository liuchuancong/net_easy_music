import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
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
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountEmail: Text('wo shi Email'),
            accountName: Text('我是Drawer'),
            onDetailsPressed: () {},
            decoration: BoxDecoration(color: Colors.transparent),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://p2.music.126.net/ox4WsLbNGLpgcZkdn0IUbA==/109951165085426101.jpg?param=300y300'),
            ),
          ),
          ListTile(
            title: Text('ListTile1'),
            subtitle: Text(
              'ListSubtitle1',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            leading: CircleAvatar(child: Text("1")),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(), //分割线
          ListTile(
            title: Text('ListTile2'),
            subtitle: Text(
              'ListSubtitle2',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            leading: CircleAvatar(child: Text("2")),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(), //分割线
          ListTile(
            title: Text('ListTile3'),
            subtitle: Text(
              'ListSubtitle3',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            leading: CircleAvatar(child: Text("3")),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(), //分割线
        ],
      ),
    );
  }
}
