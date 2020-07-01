import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final int codePoint;

  const NavBar({Key key,@required this.codePoint}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: Icon(IconData(codePoint,fontFamily: 'iconfont'),color: Colors.white54,),
        onTap: (){
          Navigator.of(context).pop();
        },
      ),
    );
  }
}