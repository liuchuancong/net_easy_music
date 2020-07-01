import 'package:flutter/material.dart';

class UserNavBar extends StatelessWidget {
  final String title;

  const UserNavBar({Key key, @required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: Container(
          child: new Image.asset(
            'assets/user.png',
            color: Colors.white54,
          ),
          width: 25,
          height: 25,
        ),
        title: Text(
          title,
          style: useravBarTextStyle,
        ),
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}

final TextStyle useravBarTextStyle =
    const TextStyle(fontSize: 18, color: Colors.white54);
