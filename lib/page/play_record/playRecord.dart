import 'package:flutter/material.dart';

import 'carsoule.dart';

class BottomPopupRecord {
  showCard({BuildContext context}) async {
    await showModalBottomSheet(
        context: context,
        barrierColor:Colors.black.withOpacity(0.3),
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Container(
            height: 400.0,
            child: Carsoule()
          );
        });
  }
}
