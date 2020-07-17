import 'package:flutter/material.dart';

openRoute({@required Widget page, @required BuildContext context}) {
  Navigator.push(context, PageRouteBuilder(pageBuilder: (BuildContext context,
      Animation animation, Animation secondaryAnimation) {
    return new FadeTransition(
      opacity: animation,
      child: page,
    );
  }));
}
