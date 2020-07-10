import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final int codePoint;
  final String title;
  final Function onTap;
  const NavBar(
      {Key key, @required this.codePoint, @required this.title, this.onTap})
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
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
          onTap();
        },
      ),
    );
  }
}

final TextStyle navBarTextStyle =
    const TextStyle(fontSize: 18, color: Colors.white54);
