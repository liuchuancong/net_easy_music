import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final int codePoint;
  final String title;
  const NavBar({Key key, @required this.codePoint, @required this.title})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: Icon(
          IconData(codePoint, fontFamily: 'iconfont'),
          color: Colors.white54,
          size: 25,
        ),
        title: Text(
          title,
          style: navBarTextStyle,
        ),
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}

final TextStyle navBarTextStyle =
    const TextStyle(fontSize: 18, color: Colors.white54);
